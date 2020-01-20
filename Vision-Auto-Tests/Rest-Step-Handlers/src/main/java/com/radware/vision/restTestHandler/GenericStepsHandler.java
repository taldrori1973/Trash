package com.radware.vision.restTestHandler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
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

public class GenericStepsHandler {


    public static RestRequestSpecification createNewRestRequestSpecification(String filePath, String requestLabel) {
        RestRequestSpecification requestSpecification;
        RequestsFilePojo requestsFilePojo = RequestsFilesRepository.get_instance().getRequestsFilePojo(filePath);
        List<RequestPojo> requestsPojo = requestsFilePojo.getApi().stream().filter(request -> request.getLabel().equals(requestLabel)).collect(Collectors.toList());

        if (requestsPojo.size() > 1)
            throw new IllegalStateException(String.format("There are %d occurrences of %s label in the file %s", requestsPojo.size(), requestLabel, filePath));
        if (requestsPojo.size() == 0)
            throw new IllegalArgumentException(String.format("The Label %s not exist in file %s", requestLabel, filePath));

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

    public static void createBody(List<BodyEntry> bodyEntries) {

        DocumentContext documentContext = JsonPath.parse("{}");
        for (BodyEntry entry : bodyEntries) {
            List<String> pathTokens = Arrays.asList(entry.getJsonPath().split("\\."));
            String join = String.join(".", pathTokens.subList(0, pathTokens.size() - 1));
            String path = join.equals("") ? "$" : "$." + join;
            String key = !pathTokens.isEmpty() ? pathTokens.get(pathTokens.size() - 1) : entry.getJsonPath();
            documentContext.put(path, key, entry.getValue());
        }
//        Map<String, Object> root = new HashMap<>();
//        Pattern arrayPattern= Pattern.compile("(.*)\\[(\\d+)\\]");
//
//        for (BodyEntry entry : bodyEntries) {
//            List<String> pathTokens = Arrays.asList(entry.getJsonPath().split("\\."));
//            createBodyRecursive(root,pathTokens,entry.getValue(),arrayPattern);
//            if (pathTokens.size() == 1) root.put(pathTokens.get(0), entry.getValue());
////            for(String token:pathTokens){
////                if()
////            }
//        }
    }

    private static void createBodyRecursive(Map<String, Object> map, List<String> pathTokens, String value, Pattern arrayPattern) {
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
