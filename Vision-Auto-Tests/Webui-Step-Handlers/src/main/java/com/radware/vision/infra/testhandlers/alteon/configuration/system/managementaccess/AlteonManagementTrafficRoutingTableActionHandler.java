package com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess;

import com.radware.automation.webui.webpages.configuration.system.SystemEnums;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.managementTrafficRouting.ManagementTrafficRouting;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 5/20/2015.
 */
public class AlteonManagementTrafficRoutingTableActionHandler extends BaseHandler {


    public static void setManagementTrafficRouting(HashMap<String, SystemEnums.MmgmtData> testPropertiesEnums, HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ManagementTrafficRouting managementTrafficRouting = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementTrafficRouting();
        managementTrafficRouting.openPage();
        managementTrafficRouting.setRadius(testPropertiesEnums.get("RADIUS"));
        managementTrafficRouting.setTacacs(testPropertiesEnums.get("TACACSPlus"));
        managementTrafficRouting.setSyslog(testPropertiesEnums.get("SYSLOG"));
        managementTrafficRouting.setSnmpTraps(testPropertiesEnums.get("SNMPTraps"));
        managementTrafficRouting.setFtp(testPropertiesEnums.get("FTP_TFTP_SCP"));
        managementTrafficRouting.setNtp(testPropertiesEnums.get("NTP"));
        managementTrafficRouting.setBwm(testPropertiesEnums.get("BWMStatistics"));
        managementTrafficRouting.setDns(testPropertiesEnums.get("DNS"));
        managementTrafficRouting.setOcsp(testPropertiesEnums.get("OCSP"));
        managementTrafficRouting.setWlm(testPropertiesEnums.get("WLM"));
        managementTrafficRouting.setSmtp(testPropertiesEnums.get("SMTP"));
        managementTrafficRouting.submit();

    }

}
