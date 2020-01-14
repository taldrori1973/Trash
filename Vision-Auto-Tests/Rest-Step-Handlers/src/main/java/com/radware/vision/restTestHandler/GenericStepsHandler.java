package com.radware.vision.restTestHandler;

import com.radware.vision.requestsRepository.controllers.RequestsFilesRepository;
import com.radware.vision.requestsRepository.models.RequestPojo;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;
import models.ContentType;
import models.Method;
import models.RestRequestSpecification;

import java.util.*;
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
}
