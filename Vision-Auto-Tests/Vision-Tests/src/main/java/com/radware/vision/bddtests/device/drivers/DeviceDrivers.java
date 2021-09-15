package com.radware.vision.bddtests.device.drivers;

import java.util.HashMap;
import java.util.Map;

public class DeviceDrivers {

    public Map<String, String> alteonVersionsMap = new HashMap<>();
    public Map<String, String> dpVersionsMap = new HashMap<>();
    public static final String DEFAULT_DEVICE_DRIVERS_PATH = "/home/radware/Scripts/";
    public static final String SCRIPT_FILE_NAME = "upload_DD.sh";
    public static final String DEFAULT_DST_PATH = "/opt/radware/storage/";
    public static final int DEFAULT_TIME_OUT = 240 * 1000;

    public DeviceDrivers() {
        loadAlteonMap();
        loadDefenseProMap();
    }

    public Map<String, String> getDpVersionsMap() {
        return dpVersionsMap;
    }

    public Map<String, String> getAlteonVersionsMap() {
        return alteonVersionsMap;
    }

    private void loadAlteonMap() {
        alteonVersionsMap.put("32.4.0.0", "Alteon-32.4.0.0-DD-1.00-396.jar");
        alteonVersionsMap.put("32.2.1.0", "Alteon-32.2.1.0-DD-1.00-110.jar");
        alteonVersionsMap.put("32.6.5.0","Alteon-32.6.5.0-DD-1.00-10.jar");

    }

    private void loadDefenseProMap() {
        dpVersionsMap.put("6.14.03", "DefensePro-6.14.03-DD-1.00-28.jar");

    }
}
