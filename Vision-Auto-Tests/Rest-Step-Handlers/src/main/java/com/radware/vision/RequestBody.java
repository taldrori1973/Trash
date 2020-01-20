package com.radware.vision;

import com.radware.vision.requestsRepository.controllers.RequestsFilesRepository;
import com.radware.vision.requestsRepository.controllers.RequestsRepository;
import com.radware.vision.requestsRepository.controllers.SchemaRepository;
import com.radware.vision.requestsRepository.models.RequestPojo;

import java.util.HashMap;
import java.util.Map;

public class RequestBody {
    private Map<String, String> requestBody;
    private RequestPojo requestPojo;

    public RequestBody(String requestPojoFilePath, String requestLabel) {
        this.requestBody = new HashMap<>();
        this.requestPojo = RequestsRepository.getRequestPojo(requestPojoFilePath, requestLabel);
        SchemaRepository.getInstance().getFieldPojoList(
                RequestsFilesRepository.get_instance().getRequestsFilePojo(requestPojoFilePath).getDeviceName(),
                requestPojo.getBodyParameters().get(0).getSchema()
        );
        BuildBodyBySchema();

    }

    private void BuildBodyBySchema() {

    }

}
