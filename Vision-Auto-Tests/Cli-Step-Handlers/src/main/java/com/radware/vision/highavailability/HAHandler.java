package com.radware.vision.highavailability;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionServerHA;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.ConfigSyncMode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.YesNo;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.ConfigSync;


public class HAHandler extends TestBase {
    public static String peer;
    public static VisionServerHA visionServerHA;
    
    private static void setHosts() {
        visionServerHA = new VisionServerHA();
        visionServerHA.setHost_1(sutManager.getClientConfigurations().getHostIp());
        visionServerHA.setHost_2(sutManager.getpair().getPairIp());
    }
    
    
    public static void setConfigSyncInterval(RadwareServerCli radwareServerCli, int interval) {
        try {
            ConfigSync.setInterval(radwareServerCli, interval + "");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setHost(ConfigSyncMode mode, RadwareServerCli radwareServerCli, RootServerCli rootCli) throws Exception {

        if (mode == null) throw new Exception("mode is equal to null");
        connect(radwareServerCli);
        if (getHAMode(radwareServerCli).equals(mode.getMode())) {
            return;
        }
        radwareServerCli.setHost(visionServerHA.getHost_1());
        if (verifyMode(radwareServerCli, mode)) {
            rootCli.setHost(visionServerHA.getHost_1());
            connect(rootCli);
        } else {
            radwareServerCli.setHost(visionServerHA.getHost_2());
            if (verifyMode(radwareServerCli, mode)) {
                rootCli.setHost(visionServerHA.getHost_2());
                connect(rootCli);
            } else {
                throw new Exception("there is no vision server that matches this mode " + mode + " to connect to");
            }


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

    public static void setConfigSyncPeer(RadwareServerCli radwareServerCli) {
        try {
            peer = visionServerHA.getHost_2();
            ConfigSync.setPeer(radwareServerCli, peer);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setBothVisionsDisabled(int timeout, RadwareServerCli radwareServerCli) {
        try {
            RadwareServerCli serverCli = getSessionByIp(visionServerHA.getHost_1(), radwareServerCli);
            ConfigSyncMode mode = ConfigSyncMode.DISABLED;
            ConfigSync.setMode(serverCli, mode, timeout, YesNo.YES.getText());
            serverCli = getSessionByIp(visionServerHA.getHost_2(), radwareServerCli);
            ConfigSync.setMode(serverCli, mode, timeout, YesNo.YES.getText());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void setTargetVision(String mode, RadwareServerCli radwareServerCli, RootServerCli rootCli) {
        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
            setHost(configSyncMode, radwareServerCli, rootCli);
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

    public static String getDeviceIp(String mode, RadwareServerCli radwareServerCli) throws Exception {
        ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
        return getRadwareSessionByMode(configSyncMode, radwareServerCli).getHost();
    }

    private static void connect(CliConnectionImpl target) throws Exception {
        target.disconnect();
        target.connect();
    }

    private static String getHAMode(RadwareServerCli serverCli) {
        CliOperations.runCommand(serverCli, Menu.system().configSync().mode().get().build(), 120 * 1000);

        return serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);
    }

    public static RadwareServerCli getSessionByIp(String host, RadwareServerCli radwareCli) throws Exception {

        RadwareServerCli serverCli = new RadwareServerCli(host, radwareCli.getUser(), radwareCli.getPassword());
        connect(serverCli);
        return serverCli;

    }

    //this method returns a new instance of RadwareServerCli which is equal to the mode
    public static RadwareServerCli getRadwareSessionByMode(ConfigSyncMode mode, RadwareServerCli radwareCli) throws Exception {
        if (mode == null) {
            throw new Exception("mode is equal to null");
        }
        RadwareServerCli serverCli;
        if (getHAMode(radwareCli).equals(mode.getMode())) {
            serverCli = new RadwareServerCli(radwareCli.getHost(), radwareCli.getUser(), radwareCli.getPassword());
            serverCli.connect();
            return serverCli;
        }

        serverCli = new RadwareServerCli(visionServerHA.getHost_2(), radwareCli.getUser(), radwareCli.getPassword());
        if (verifyMode(serverCli, mode)) {
            return serverCli;
        }

        serverCli = new RadwareServerCli(visionServerHA.getHost_1(), radwareCli.getUser(), radwareCli.getPassword());
        if (verifyMode(serverCli, mode)) {
            return serverCli;
        }


        throw new Exception("There is no vision equal to " + mode.getMode());


    }

    //this method returns a new instance of RootServerCli which is equal to the mode

    public RootServerCli getRootSessionByMode(ConfigSyncMode mode, RadwareServerCli radwareCli, RootServerCli rootCli) throws Exception {
        if (mode == null) throw new Exception("mode is equal to null");
        RadwareServerCli serverCli;
        if (getHAMode(radwareCli).equals(mode.getMode())) {
            rootCli = new RootServerCli(rootCli.getHost(), rootCli.getUser(), rootCli.getPassword());
            rootCli.connect();
            return rootCli;
        }
        serverCli = new RadwareServerCli(visionServerHA.getHost_2(), radwareCli.getUser(), radwareCli.getPassword());
        if (verifyMode(serverCli, mode))
            return new RootServerCli(visionServerHA.getHost_2(), rootCli.getUser(), rootCli.getPassword());

        serverCli = new RadwareServerCli(visionServerHA.getHost_1(), radwareCli.getUser(), radwareCli.getPassword());
        if (verifyMode(serverCli, mode))
            return new RootServerCli(visionServerHA.getHost_1(), rootCli.getUser(), rootCli.getPassword());

        throw new Exception("There is no vision equal to " + mode.getMode());
        
    }

    //verify that the vision mode is equal to mode coming from the param
    private static boolean verifyMode(RadwareServerCli visionServer, ConfigSyncMode mode) throws Exception {

        connect(visionServer);
        InvokeUtils.invokeCommand(Menu.system().configSync().mode().get().build(), visionServer);
        boolean active = visionServer.getTestAgainstObject().toString().contains((ConfigSyncMode.ACTIVE.getMode()));
        boolean standby = visionServer.getTestAgainstObject().toString().contains((ConfigSyncMode.STANDBY.getMode()));
        boolean disabled = visionServer.getTestAgainstObject().toString().contains((ConfigSyncMode.DISABLED.getMode()));

        if (mode.equals(ConfigSyncMode.ACTIVE)) {
            return active;
        } else if (mode.equals(ConfigSyncMode.STANDBY)) {
            return standby;
        } else if (mode.equals(ConfigSyncMode.DISABLED)) {
            return disabled;
        }

        return false;

    }
}
