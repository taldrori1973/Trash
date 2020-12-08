package com.radware.vision.restAPI;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.restTestHandler.RestClientsStepsHandler;
import controllers.RestApiManagement;
import lombok.Getter;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.RestApi;

@Getter
public class FormatterRestApi {
    private static RestApi restApi = RestApiManagement.getRestApi();
    private RestRequestSpecification restRequestSpecification;
    private String baseUri;
    private Integer connectionPort;
    /**
     * @param baseUri             : the request will be sent to https://<visionIp>
     * @param connectionPort                 :nullable ,
     * @param requestFilePath      : request file path under APSoluteVisionAutomation\Vision-Auto-Tests\Vision-Tests\src\main\resources\restApis\Generic-REST-API\requests\
     *                             for example for user the SystemConfigItemList file under vision folder the value should be Vision/SystemConfigItemList.json
     * @param requestLabel         :request label under the file
     */
    public FormatterRestApi(String baseUri, Integer connectionPort, String requestFilePath, String requestLabel) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;
        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(requestFilePath, requestLabel);
    }
    public RestResponse sendRequest() {
        try {
            RestClientsStepsHandler.switchToNoAuthClient(this.baseUri, this.connectionPort);
            return restApi.sendRequest(this.restRequestSpecification);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}