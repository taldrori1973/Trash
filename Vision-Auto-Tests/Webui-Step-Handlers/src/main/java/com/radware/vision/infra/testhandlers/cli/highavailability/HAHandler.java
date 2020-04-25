package com.radware.vision.infra.testhandlers.cli.highavailability;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.enums.YesNo;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.vision_handlers.system.ConfigSync;
import com.radware.vision.vision_project_cli.HaManager;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.VisionServerHA;

public class HAHandler extends BaseHandler {
    static String peer;

    public static void setConfigSyncInterval(RadwareServerCli radwareServerCli, int interval) {
        try {
            ConfigSync.setInterval(radwareServerCli, interval + "");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setConfigSyncMode(RadwareServerCli radwareServerCli, String mode, int timeout, String yesNo) {

        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.getConstant(mode);
            YesNo yes = YesNo.valueOf(yesNo);
            ConfigSync.setMode(radwareServerCli, configSyncMode, timeout, yes.getText());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setConfigSyncModeWithoutServices(RadwareServerCli radwareServerCli, String mode, int timeout, String yesNo) {

        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.getConstant(mode);
            YesNo yes = YesNo.valueOf(yesNo);
            ConfigSync.setModeWitoutServices(radwareServerCli, configSyncMode, timeout, yes.getText());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setConfigSyncPeer(RadwareServerCli radwareServerCli, String chosenPeer, VisionServerHA visionServerHA) {
        try {
            if (chosenPeer == null) {

                if (radwareServerCli.getHost().equals(visionServerHA.getHost_1())) {
                    peer = visionServerHA.getHost_2();
                } else if (radwareServerCli.getHost().equals(visionServerHA.getHost_2())) {
                    peer = visionServerHA.getHost_1();
                }

            } else {
                peer = chosenPeer;
            }
            ConfigSync.setPeer(radwareServerCli, peer);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setBothVisionsDisabled(HaManager haManager, VisionServerHA visionServerHA, int timeout) {
        try {
            RadwareServerCli serverCli = haManager.getSessionByIp(visionServerHA.getHost_1());
            ConfigSyncMode mode = ConfigSyncMode.DISABLED;
            ConfigSync.setMode(serverCli, mode, timeout, YesNo.YES.getText());
            serverCli = haManager.getSessionByIp(visionServerHA.getHost_2());
            ConfigSync.setMode(serverCli, mode, timeout, YesNo.YES.getText());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setTargetVision(HaManager haManager, String mode) {
        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
            haManager.setHost(configSyncMode);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void manualSync(RadwareServerCli radwareServerCli) {
        try {
            ConfigSync.manualSync(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static String getDeviceIp(HaManager haManager, String mode) throws Exception {
        ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
        return haManager.getRadwareSessionByMode(configSyncMode).getHost();
    }
}
