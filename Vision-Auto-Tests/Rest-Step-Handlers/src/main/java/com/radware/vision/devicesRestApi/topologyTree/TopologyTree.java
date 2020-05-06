package com.radware.vision.devicesRestApi.topologyTree;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.RestStepResult;

import java.util.Optional;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/5/2020
 * Time: 1:24 AM
 */
public interface TopologyTree {

    //    devices

    RestStepResult addDevice(String setId);

    Optional<JsonNode> getDeviceData(String setId) throws Exception;

    RestStepResult updateDevice(String setId);

    RestStepResult deleteDevice(String setId);

//    Sites

    RestStepResult addSite(String siteName);

    String getSiteOrmId(String siteName) throws Exception;

    boolean isSiteExist(String siteName) throws NoSuchFieldException;

    RestStepResult deleteSite(String siteName);
}
