package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut;

/*
 "defaultPort": 80,
  "defaultProtocol": "http"
 */

import lombok.Data;

@Data
public class RestConnection {
    private int defaultPort;
    private String defaultProtocol;

}
