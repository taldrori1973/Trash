package models.config;

import models.StatusCode;

public interface DevicesConstants {


    //VISION
    int VISION_DEFAULT_PORT = 443;
    String VISION_LOGIN_PATH = "/mgmt/system/user/login";
    String VISION_LOGOUT_PATH = "/mgmt/system/user/logout";
    String VISION_INFO_PATH = "/mgmt/system/user/info?showpolicies=true";
    StatusCode VISION_ON_SUCCESS_STATUS_CODE = StatusCode.OK;
    String VISION_USERNAME_FIELD_NAME = "username";
    String VISION_PASSWORD_FIELD_NAME = "password";
    String VISION_LICENSE_FIELD_NAME = "license";

    //VDirect
    int V_DIRECT_DEFAULT_PORT = 2189;
    String V_DIRECT_INFO_PATH = "/api/session";
    StatusCode V_DIRECT_ON_SUCCESS_STATUS_CODE = StatusCode.OK;
    String V_DIRECT_USERNAME_FIELD_NAME_IN_RESPONSE = "userName";
}
