package com.radware.vision.requestsRepository.models;

import lombok.Data;
@Data
public class RequestPojo {
    private String label;
    private String description;
    private String method;
    private String basePath;
    private String produces;
    private String consumes;

}
