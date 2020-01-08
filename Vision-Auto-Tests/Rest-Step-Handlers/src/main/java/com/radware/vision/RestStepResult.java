package com.radware.vision;

import lombok.AllArgsConstructor;
import lombok.Data;
import models.RestResponse;
import models.StatusCode;

@Data
@AllArgsConstructor
public class RestStepResult {
    private Status status;
    private String message;


    public RestStepResult(RestResponse response, StatusCode expectedStatusCode) {
        this.status = response.getStatusCode().equals(expectedStatusCode) ? Status.SUCCESS : Status.FAILED;
        this.message = response.getStatusLine();
    }

    public enum Status {
        SUCCESS,
        FAILED
    }
}
