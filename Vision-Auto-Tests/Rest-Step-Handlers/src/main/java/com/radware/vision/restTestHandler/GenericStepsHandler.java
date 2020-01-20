package com.radware.vision.restTestHandler;

import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.vision.requestsRepository.controllers.RequestsFilesRepository;
import com.radware.vision.requestsRepository.models.RequestPojo;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;
import com.radware.vision.utils.BodyEntry;
import models.ContentType;
import models.Method;
import models.RestRequestSpecification;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

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
        checkIndices(bodyEntries);
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
                            documentContext.add(path, entry.getValue());

                        else documentContext.add(path, new LinkedHashMap<>());
                    } else {//the path is exist , update the value
                        if (pathTokens.size() - 1 == i)//this is last element
                            documentContext.set(format("%s[%d]", path, entryIndex), entry.getValue());
                    }
                    path = format("%s[%d]", path, entryIndex);


                } else {//not array
                    if (pathTokens.size() - 1 == i)//this is last element
                        documentContext.put(path, token, entry.getValue());
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

    private static void checkIndices(List<BodyEntry> bodyEntries) {

    }

    private static void createBodyRecursive(Map<String, Object> map, List<String> pathTokens, String
            value, Pattern arrayPattern) {
        if (pathTokens.size() == 0) return;


        if (pathTokens.size() == 1) map.put(pathTokens.get(0), value);

        else {
            Matcher matcher = arrayPattern.matcher(pathTokens.get(0));
            if (matcher.matches()) {
                String key = matcher.group(1);
                if (map.containsKey(key)) ;
            }
//            else{
//
//            }
        }
    }
}
