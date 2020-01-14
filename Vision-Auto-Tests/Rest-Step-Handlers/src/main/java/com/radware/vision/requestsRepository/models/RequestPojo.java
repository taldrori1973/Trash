package com.radware.vision.requestsRepository.models;

import lombok.Data;

import java.util.List;
@Data
public class RequestPojo {
    private String label;
    private String description;
    private String method;
    private String basePath;
    private String produces;
    private String consumes;
    private List<FieldPojo> pathParameters;
    private List<FieldPojo> bodyParameters;

}
