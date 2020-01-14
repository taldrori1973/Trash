package com.radware.vision.requestsRepository;

import lombok.Data;

import java.util.List;

@Data
public class RequestsFilePojo {

    private String deviceName;
    private String fileName;
    private String basePath;
    private List<RequestPojo> api;
}
