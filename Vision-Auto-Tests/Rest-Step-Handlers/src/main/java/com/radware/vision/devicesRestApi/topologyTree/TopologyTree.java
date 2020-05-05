package com.radware.vision.devicesRestApi.topologyTree;

import com.radware.vision.RestStepResult;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/5/2020
 * Time: 1:24 AM
 */
public interface TopologyTree {

    //    devices
    RestStepResult addDevice(String setId);

    RestStepResult getDevice(String setId);

    RestStepResult updateDevice(String setId);

    RestStepResult deleteDevice(String setId);

//    Sites

    RestStepResult addSite(String siteName, String parentSiteName);

    String getSiteOrmId(String siteName) throws Exception;

    boolean isSiteExist(String siteName);
    RestStepResult deleteSite(String siteName);


}
