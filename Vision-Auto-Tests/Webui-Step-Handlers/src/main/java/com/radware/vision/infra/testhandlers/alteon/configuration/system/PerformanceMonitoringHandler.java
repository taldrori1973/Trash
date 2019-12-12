package com.radware.vision.infra.testhandlers.alteon.configuration.system;

import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.devicePerformanceMonitoring.DevicePerformanceMonitoring;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by konstantinr on 6/3/2015.
 */
public class PerformanceMonitoringHandler extends BaseHandler {

    public static void setPerformanceMonitoringsettings(HashMap<String, String> testProperties, GeneralEnums.State state){
        DevicePerformanceMonitoring performanceMonitoring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mDevicePerformanceMonitoring();
        initLockDevice(testProperties);
        performanceMonitoring.openPage();

        if (state == GeneralEnums.State.ENABLE){
        performanceMonitoring.enablePerformanceMonitoring();}
        if (state == GeneralEnums.State.DISABLE){
            performanceMonitoring.disablePerformanceMonitoring();}

        performanceMonitoring.setPort(testProperties.get("port"));
        performanceMonitoring.submit();
    }
}
