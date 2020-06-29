package com.radware.vision.restAPI;

import com.radware.vision.RestClientsFactory;
import models.RestResponse;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogRestAPI {

    private String baseUri;
    private Integer connectionPort;

    public RestResponse sendRequest(){
        RestClientsFactory.getNoAuthConnection()
    }
}
