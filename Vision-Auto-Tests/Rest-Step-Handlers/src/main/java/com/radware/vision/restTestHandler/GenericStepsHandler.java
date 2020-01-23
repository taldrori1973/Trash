package com.radware.vision.restTestHandler;

import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.Option;
import com.jayway.jsonpath.PathNotFoundException;
import com.radware.vision.RestStepResult;
import com.radware.vision.requestsRepository.controllers.RequestsFilesRepository;
import com.radware.vision.requestsRepository.models.RequestPojo;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;
import com.radware.vision.utils.BodyEntry;
import com.radware.vision.utils.StepsParametersUtils;
import models.ContentType;
import models.Method;
import models.RestRequestSpecification;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.radware.vision.RestStepResult.Status.FAILED;
import static com.radware.vision.RestStepResult.Status.SUCCESS;
import static com.radware.vision.utils.JsonPathUtils.isPathExist;
import static java.lang.String.format;

public class GenericStepsHandler {


    public static RestRequestSpecification createNewRestRequestSpecification(String filePath, String requestLabel) {
        RestRequestSpecification requestSpecification;
        RequestsFilePojo requestsFilePojo = RequestsFilesRepository.get_instance().getRequestsFilePojo(filePath);
        List<RequestPojo> requestsPojo = requestsFilePojo.getApi().stream().filter(request -> request.getLabel().equals(requestLabel)).collect(Collectors.toList());

        if (requestsPojo.size() > 1)
            throw new IllegalStateException(format("There are %d occurrences of %s label in the file %s", requestsPojo.size(), requestLabel, filePath));
        if (requestsPojo.size() == 0)
            throw new IllegalArgumentException(format("The Label %s not exist in file %s", requestLabel, filePath));

        RequestPojo requestPojo = requestsPojo.stream().findFirst().get();

        Method method = Method.valueOf(requestPojo.getMethod());
        requestSpecification = new RestRequestSpecification(method);

        requestSpecification.setBasePath(requestPojo.getBasePath());

        if (!Objects.isNull(requestPojo.getConsumes()))
            requestSpecification.setContentType(ContentType.fromContentType(requestPojo.getConsumes()));
        if (!Objects.isNull(requestPojo.getProduces()))
            requestSpecification.setAccept(ContentType.fromContentType(requestPojo.getProduces()));


        return requestSpecification;

    }

    public static String createBody(List<BodyEntry> bodyEntries, String type) {
        validateEntries(bodyEntries);
        Pattern arrayPattern = Pattern.compile("(.*)\\[(\\d+)\\]");

        String rootJson = type.equals("Object") ? "{}" : "[]";
        DocumentContext documentContext = JsonPath.parse(rootJson);

        for (BodyEntry entry : bodyEntries) {

            List<String> pathTokens = Arrays.asList(entry.getJsonPath().split("\\."));
/*            each token can be as one of the following:
              1. attribute for example : "name" , the attribute will be added with value = Object
              2. attribute[i] for example: addresses[0], the addressees will be added as attribute , and the value will be Array ,
                 then if the address[0] is not exist it will be created as Object
              3. [i] for example : [0] ,at this case will add new Object for the array which already created on entry 0.
*/
            String path = "$";
            for (int i = 0; i < pathTokens.size(); i++) {
                String token = pathTokens.get(i);

                Matcher matcher = arrayPattern.matcher(token);//matcher for array entry
                if (matcher.matches()) {//this is an array entry
                    String arrayName = matcher.group(1);
                    int entryIndex = Integer.parseInt(matcher.group(2));

                    if (!arrayName.equals("")) {
                        if (!isPathExist(format("%s.%s", path, arrayName), documentContext)) {
                            documentContext.put(path, arrayName, new ArrayList<>());
                        }
                        path = path + "." + arrayName;
                    }

                    //the array is without attribute name for example "$.[i]" or "$.[i].name"

                    if (!isPathExist(format("%s[%d]", path, entryIndex), documentContext)) {

                        if (pathTokens.size() - 1 == i)//this is last element
                            documentContext.add(path, StepsParametersUtils.valueOf(entry.getValue()));

                        else documentContext.add(path, new LinkedHashMap<>());
                    } else {//the path is exist , update the value
                        if (pathTokens.size() - 1 == i)//this is last element
                            documentContext.set(format("%s[%d]", path, entryIndex), StepsParametersUtils.valueOf(entry.getValue()));
                    }
                    path = format("%s[%d]", path, entryIndex);


                } else {//not array
                    if (pathTokens.size() - 1 == i)//this is last element
                        documentContext.put(path, token, StepsParametersUtils.valueOf(entry.getValue()));
                    else {
                        if (!isPathExist(format("%s.%s", path, token), documentContext))
                            documentContext.put(path, token, new LinkedHashMap<>());
                    }
                    path = format("%s.%s", path, token);
                }
            }
        }

        return documentContext.jsonString();
    }

    private static void validateEntries(List<BodyEntry> bodyEntries) {
        Pattern arrayPattern = Pattern.compile("(.*)\\[(\\d+)\\]");
        Map<String, Set<Integer>> indicesMap = new HashMap<>();
        for (BodyEntry bodyEntry : bodyEntries) {

            if (bodyEntry.getJsonPath().startsWith("$.")) bodyEntry.setJsonPath(bodyEntry.getJsonPath().substring(2));
            else if (bodyEntry.getJsonPath().startsWith("$"))
                bodyEntry.setJsonPath(bodyEntry.getJsonPath().substring(1));

            //validate that the array entries numbers are not
            String[] pathTokens = bodyEntry.getJsonPath().split("\\.");
            for (String token : pathTokens) {
                Matcher matcher = arrayPattern.matcher(token);
                if (matcher.matches()) {
                    String arrayName = matcher.group(1);
                    int index = Integer.parseInt(matcher.group(2));
                    Set<Integer> currentArrayIndices;
                    if (indicesMap.containsKey(arrayName)) currentArrayIndices = indicesMap.get(arrayName);
                    else currentArrayIndices = new TreeSet<>();

                    currentArrayIndices.add(index);
                    indicesMap.put(arrayName, currentArrayIndices);
                }
            }

        }

//        validate that each array indices are begin from 0 and not have any gaps
        for (String key : indicesMap.keySet()) {
            Set<Integer> indices = indicesMap.get(key);
            int i = 0;
            for (Integer index : indices) {
                if (index != i)
                    throw new IllegalArgumentException(String.format("The Indices of each array in the Json Path must start from 0 and without any Gaps.\n" +
                            "for the Array %s , the following indices provided %s", key, indices));

                i++;
            }
        }

    }


    public static RestStepResult validateBody(List<BodyEntry> bodyEntries, DocumentContext documentContext) {
        documentContext.configuration().addOptions(Option.SUPPRESS_EXCEPTIONS);
        List<String> errors = new ArrayList<>();
        for (BodyEntry bodyEntry : bodyEntries) {
            Object readResult;
            Object value = null;
            try {
                readResult = documentContext.read(bodyEntry.getJsonPath());
                value = readResult;
            } catch (PathNotFoundException e) {
                errors.add(e.getMessage());
            }

            if (value != null && !value.equals(StepsParametersUtils.valueOf(bodyEntry.getValue())))
                errors.add(String.format("For Json Path \"%s\" actual value \"%s\" is not equal to the expected value \"%s\"", bodyEntry.getJsonPath(), value, StepsParametersUtils.valueOf(bodyEntry.getValue())));

        }

        if (errors.isEmpty()) return new RestStepResult(SUCCESS, "The Test Passed");
        return new RestStepResult(FAILED, String.format("Test Failed with the following errors :\n[%s]", String.join("\n", errors)));
    }
}
