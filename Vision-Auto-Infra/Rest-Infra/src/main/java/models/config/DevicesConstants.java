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
    String ALTEON_LOGOUT_PATH = "/config/logout";

    //    APPWALL
    int APPWALL_DEFAULT_PORT = 443;
    String APPWALL_LOGIN_PATH = "/appwall-api/v3/authentication/login";
    String APPWALL_LOGOUT_PATH = "/appwall-api/v3/authentication/logout";
    String APPWALL_USER_INFO_PATH = "/v2/config/aw/Users/{Login_Name}";
    String APPWALL_USER_INFO_PATH_PARAMETER = "Login_Name";


    StatusCode APPWALL_ON_SUCCESS_STATUS_CODE = StatusCode.OK;
    String APPWALL_USERNAME_FIELD_NAME = "userName";
    String APPWALL_PASSWORD_FIELD_NAME = "password";
    String APPWALL_JWT_COOKIE_NAME = "vantage_auth";

}
