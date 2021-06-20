package com.radware.vision.system;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.enums.ConfigSyncMode;

/**
 * Created by moaada on 5/4/2017.
 */

public class HaManager {

    VisionServerHA visionServerHA;
    RadwareServerCli radwareCli;
    RootServerCli rootCli;


    private HaManager() {
    }


    public HaManager(RadwareServerCli radwareCli, RootServerCli rootCli, VisionServerHA visionServerHA) {
        if (radwareCli == null || rootCli == null || visionServerHA == null) {
            return;
        }
        this.visionServerHA = visionServerHA;
        this.radwareCli = radwareCli;
        this.rootCli = rootCli;

    }


    public void setHost(ConfigSyncMode mode) throws Exception {

        if (mode == null) throw new Exception("mode is equal to null");
        connect(radwareCli);
        if (ConfigSync.getMode(radwareCli).equals(mode.getMode())) {
            return;
        }
        radwareCli.setHost(visionServerHA.getHost_1());
        if (verifyMode(radwareCli, mode)) {
            rootCli.setHost(visionServerHA.getHost_1());
            connect(rootCli);
        } else {
            radwareCli.setHost(visionServerHA.getHost_2());
            if (verifyMode(radwareCli, mode)) {
                rootCli.setHost(visionServerHA.getHost_2());
                connect(rootCli);
            } else {
                throw new Exception("there is no vision server that matches this mode " + mode + " to connect to");
            }


        }

    }


    public RadwareServerCli getSessionByIp(String host) throws Exception {

        RadwareServerCli serverCli = new RadwareServerCli(host, this.radwareCli.getUser(), this.radwareCli.getPassword());
        connect(serverCli);
        return serverCli;

    }

    //this method returns a new instance of RadwareServerCli which is equal to the mode
    public RadwareServerCli getRadwareSessionByMode(ConfigSyncMode mode) throws Exception {
        if (mode == null) {
            throw new Exception("mode is equal to null");
        }
        RadwareServerCli serverCli;
        if (ConfigSync.getMode(radwareCli).equals(mode.getMode())) {
            serverCli = new RadwareServerCli(this.radwareCli.getHost(), this.radwareCli.getUser(), this.radwareCli.getPassword());
            serverCli.connect();
            return serverCli;
        }

        serverCli = new RadwareServerCli(visionServerHA.getHost_2(), this.radwareCli.getUser(), this.radwareCli.getPassword());
        if (verifyMode(serverCli, mode)) {
            return serverCli;
        }

        serverCli = new RadwareServerCli(visionServerHA.getHost_1(), this.radwareCli.getUser(), this.radwareCli.getPassword());
        if (verifyMode(serverCli, mode)) {
            return serverCli;
        }


        throw new Exception("There is no vision equal to " + mode.getMode());


    }

    //this method returns a new instance of RootServerCli which is equal to the mode

    public RootServerCli getRootSessionByMode(ConfigSyncMode mode) throws Exception {
        if (mode == null) throw new Exception("mode is equal to null");
        RadwareServerCli serverCli;
        if (ConfigSync.getMode(radwareCli).equals(mode.getMode())) {
            rootCli = new RootServerCli(this.rootCli.getHost(), this.rootCli.getUser(), this.rootCli.getPassword());
            rootCli.connect();
            return rootCli;
        }
        serverCli = new RadwareServerCli(visionServerHA.getHost_2(), this.radwareCli.getUser(), this.radwareCli.getPassword());
        if (verifyMode(serverCli, mode))
            return new RootServerCli(visionServerHA.getHost_2(), this.rootCli.getUser(), this.rootCli.getPassword());

        serverCli = new RadwareServerCli(visionServerHA.getHost_1(), this.radwareCli.getUser(), this.radwareCli.getPassword());
        if (verifyMode(serverCli, mode))
            return new RootServerCli(visionServerHA.getHost_1(), this.rootCli.getUser(), this.rootCli.getPassword());

        throw new Exception("There is no vision equal to " + mode.getMode());


    }

    //verify that the vision mode is equal to mode coming from the param
    private boolean verifyMode(RadwareServerCli visionServer, ConfigSyncMode mode) throws Exception {

        connect(visionServer);
        InvokeUtils.invokeCommand(Menu.system().configSync().mode().get().build(), visionServer);
        boolean active = visionServer.getTestAgainstObject().toString().contains(ConfigSync.buildModeText(ConfigSyncMode.ACTIVE.getMode()));
        boolean standby = visionServer.getTestAgainstObject().toString().contains(ConfigSync.buildModeText(ConfigSyncMode.STANDBY.getMode()));
        boolean disabled = visionServer.getTestAgainstObject().toString().contains(ConfigSync.buildModeText(ConfigSyncMode.DISABLED.getMode()));

        if (mode.equals(ConfigSyncMode.ACTIVE)) {
            return active;
        } else if (mode.equals(ConfigSyncMode.STANDBY)) {
            return standby;
        } else if (mode.equals(ConfigSyncMode.DISABLED)) {
            return disabled;
        }

        return false;

    }

    private void connect(CliConnectionImpl target) throws Exception {
        target.disconnect();
        target.connect();
    }


}

