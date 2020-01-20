package com.radware.vision.requestsRepository.controllers;

import com.radware.vision.requestsRepository.models.RequestPojo;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;

import java.util.List;
import java.util.stream.Collectors;

public class RequestsRepository {

    public static RequestPojo getRequestPojo(String filePath, String requestLabel){
        RequestsFilePojo requestsFilePojo = RequestsFilesRepository.get_instance().getRequestsFilePojo(filePath);
        List<RequestPojo> requestsPojo = requestsFilePojo.getApi().stream().filter(request -> request.getLabel().equals(requestLabel)).collect(Collectors.toList());

        if (requestsPojo.size() > 1)
            throw new IllegalStateException(String.format("There are %d occurrences of %s label in the file %s", requestsPojo.size(), requestLabel, filePath));
        if (requestsPojo.size() == 0)
            throw new IllegalArgumentException(String.format("The Label %s not exist in file %s", requestLabel, filePath));

        return requestsPojo.stream().findFirst().get();
    }
}
