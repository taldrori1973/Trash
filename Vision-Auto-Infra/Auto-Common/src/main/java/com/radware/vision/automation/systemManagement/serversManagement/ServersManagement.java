package com.radware.vision.automation.systemManagement.serversManagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.CliConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.base.TestBase;

import java.lang.reflect.Constructor;
import java.util.Optional;

public class ServersManagement {


    private LinuxFileServer linuxFileServer;
    private RadwareServerCli radwareServerCli;
    private RootServerCli rootServerCli;


    public ServersManagement() {
        this.linuxFileServer = this.createAndInitServer(ServerIds.GENERIC_LINUX_SERVER, LinuxFileServer.class);
        this.radwareServerCli = this.createAndInitServer(RadwareServerCli.class);
        this.rootServerCli = this.createAndInitServer(RootServerCli.class);
    }

    private <SERVER extends ServerCliBase> SERVER createAndInitServer(ServerIds serverId, Class<SERVER> clazz) {
        try {
            Constructor<SERVER> constructor = clazz.getConstructor(String.class, String.class, String.class);
            Optional<ServerDto> serverById = TestBase.getSutManager().getServerById(serverId.getServerId());
            if (!serverById.isPresent()) return null;
            ServerDto serverDto = serverById.get();
            SERVER server = constructor.newInstance(serverDto.getHost(), serverDto.getUser(), serverDto.getPassword());
            server.setConnectOnInit(serverDto.isConnectOnInit());
            server.init();
            return server;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private <SERVER extends ServerCliBase> SERVER createAndInitServer(Class<SERVER> clazz) {
        try {
            Constructor<SERVER> constructor = clazz.getConstructor(String.class, String.class, String.class);
            String iP = TestBase.getSutManager().getClientConfigurations().getHostIp();
            CliConfigurationDto CliConfigurationDto = TestBase.getSutManager().getCliConfigurations();
            SERVER server;
            if (clazz == RadwareServerCli.class) {
                server = constructor.newInstance(iP, CliConfigurationDto.getRadwareServerCliUserName(), CliConfigurationDto.getRadwareServerCliPassword());
            } else {
                server = constructor.newInstance(iP, CliConfigurationDto.getRootServerCliUserName(), CliConfigurationDto.getRootServerCliPassword());
            }
            server.init();
            return server;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Optional<LinuxFileServer> getLinuxFileServer() {
        return this.linuxFileServer != null ? Optional.of(linuxFileServer) : Optional.empty();
    }

    public Optional<RadwareServerCli> getRadwareServerCli() {
        return this.radwareServerCli != null ? Optional.of(radwareServerCli) : Optional.empty();
    }

    public Optional<RootServerCli> getRootServerCLI() {
        return this.rootServerCli != null ? Optional.of(rootServerCli) : Optional.empty();
    }

    public enum ServerIds {
        GENERIC_LINUX_SERVER("linuxFileServer"),
        RADWARE_SERVER_CLI("radwareServerCli"),
        ROOT_SERVER_CLI("rootServerCli"),
        DEPLOYMENT_SERVER("deploymentServer");

        private String serverId;

        ServerIds(String serverId) {
            this.serverId = serverId;
        }

        public String getServerId() {
            return serverId;
        }

        public void setServerId(String serverId) {
            this.serverId = serverId;
        }
    }

    public ServerCliBase getServerById(ServerIds ServerId) {
        ServerCliBase serverCliBase = null;
        switch (ServerId) {
            case GENERIC_LINUX_SERVER:
                serverCliBase = this.linuxFileServer;
                break;
            case RADWARE_SERVER_CLI:
                serverCliBase = this.radwareServerCli;
                break;
            case ROOT_SERVER_CLI:
                serverCliBase = this.rootServerCli;
                break;
            default:
                BaseTestUtils.report("Server ID" + ServerId + " is not implemented", Reporter.FAIL);
        }
        return serverCliBase;
    }

}
