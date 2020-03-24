package com.radware.vision.requestsRepository.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class RequestsFilesRepository {
    private static final String REQUESTS_FILES_PATH_PREFIX = "restApis/Generic-REST-API/requests/";
    private ObjectMapper mapper;

    private final Map<String, RequestsFilePojo> requests_files_repository;


    private static RequestsFilesRepository _instance = new RequestsFilesRepository();

    public static RequestsFilesRepository get_instance() {
        return _instance;
    }

    private RequestsFilesRepository() {
        this.requests_files_repository = new HashMap<>();
        this.mapper = new ObjectMapper();

    }

    public RequestsFilePojo getRequestsFilePojo(String filePath) {

        if (requests_files_repository.containsKey(filePath)) return requests_files_repository.get(filePath);

        try (InputStream resourceAsStream = this.getClass().getClassLoader().getResourceAsStream(REQUESTS_FILES_PATH_PREFIX + filePath)) {
            RequestsFilePojo requestsFilePojo = mapper.readValue(resourceAsStream, RequestsFilePojo.class);
            requests_files_repository.put(filePath, requestsFilePojo);
            return requestsFilePojo;
        } catch (IOException e) {
            throw new IllegalArgumentException(String.format("the file path %s not exist", filePath));
        }

    }

}
