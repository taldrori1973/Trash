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


    //    ALTEON
    int ALTEON_DEFAULT_PORT = 443;
    String ALTEON_SESSION_DETAILS_PATH = "/config/sessiondetails";
    StatusCode ALTEON_ON_SUCCESS_STATUS_CODE = StatusCode.OK;

    //    APPWALL
    int APPWALL_DEFAULT_PORT = 443;
    String APPWALL_USER_INFO_PATH = "/v2/config/aw/Users/{Login_Name}";
    String APPWALL_USER_INFO_PATH_PARAMETER = "Login_Name";
    StatusCode APPWALL_ON_SUCCESS_STATUS_CODE = StatusCode.OK;


    //VISION
    int DEFENSE_FLOW_DEFAULT_PORT = 9101;
    String DEFENSE_FLOW_LOGIN_PATH = "/rest/v2/authentication/login";
    String DEFENSE_FLOW_LOGOUT_PATH = "/rest/v2/authentication/logout";
    String DEFENSE_FLOW_VALIDATE_PATH = "/rest/v2/authentication/validat";
    StatusCode DEFENSE_FLOW_ON_SUCCESS_STATUS_CODE = StatusCode.OK;
    String DEFENSE_FLOW_USERNAME_FIELD_NAME = "user";
    String DEFENSE_FLOW_PASSWORD_FIELD_NAME = "password";
    String DEFENSE_FLOW_LOGIN_RESPONSE_FIELD_NAME = "token";
    String DEFENSE_FLOW_HEADER_AUTH_FIELD_NAME = "dfctoken";
}
