package com.radware.vision.requestsRepository;

import lombok.Data;

@Data
public class FieldPojo {
    private String name;
    private String description;
    private Boolean required;
    private String schema;
    private String defaultValue;

}
