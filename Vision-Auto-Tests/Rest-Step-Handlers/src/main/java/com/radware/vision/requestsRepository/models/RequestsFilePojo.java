package com.radware.vision.requestsRepository.models;

import lombok.Data;

import java.util.List;

@Data
public class RequestsFilePojo {

    private String deviceName;
    private String fileName;
    private String description;
    private List<RequestPojo> api;
}
