package com.radware.vision.requestsRepository.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.requestsRepository.models.RequestsFilePojo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class RequestsFilesRepository {
    private static final String REQUESTS_FILES_PATH_PREFIX = "restApis/Generic-REST-API/requests/";
    private ObjectMapper mapper;

    private final Map<String, RequestsFilePojo> requests_files_repository;

//    private final List<File> requests_files;

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

//    private File getRequestFile(String filePath) {
//        URL restApiResource = RequestsFilesRepository.class.getResource(REQUESTS_FILES_PATH_PREFIX + filePath);
//        return new File(restApiResource.getPath());
//    }
//
//    private void getAllRequestsFiles() {
//
//        URL restApiResource = RequestsFilesRepository.class.getResource(REQUESTS_FILES_PATH_PREFIX);
//
//        File rootDirectory = new File(restApiResource.getPath());
//
//        listFiles(rootDirectory);
//    }

//    private void listFiles(File rootDirectory) {
//        File[] list = rootDirectory.listFiles((dir, name) -> dir.isDirectory() || (dir.isFile() && name.toLowerCase().endsWith(".json")));
//        if (list != null) {
//            for (File file : list) {
//                if (file.isFile()) requests_files.add(file);
//                else if (file.isDirectory()) listFiles(file);
//            }
//        }
//    }

}
