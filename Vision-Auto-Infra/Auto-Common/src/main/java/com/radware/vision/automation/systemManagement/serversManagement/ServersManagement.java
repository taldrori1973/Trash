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


    private final LinuxFileServer linuxFileServer;
    private final RadwareServerCli radwareServerCli;
    private final RootServerCli rootServerCli;


    public ServersManagement() {
        this.linuxFileServer = this.createAndInitServer(getServerId(TestBase.getSutManager().getLinuxServerID()), LinuxFileServer.class);
        this.radwareServerCli = this.createAndInitServer(RadwareServerCli.class);
        this.rootServerCli = this.createAndInitServer(RootServerCli.class);
    }

    private ServerIds getServerId(String ServerID) {
        try {
            switch (ServerID) {
                case "linuxFileServer":
                    return ServerIds.GENERIC_LINUX_SERVER;
                case "linuxFileServerVanc":
                    return ServerIds.GENERIC_LINUX_SERVER_VANC;
                default:
                    BaseTestUtils.report("ServerID: " + ServerID + ", is not valid.", Reporter.FAIL);

            }
        } catch (NullPointerException e) {
            // TODO - check case that SUT file didnt contins genericLinuxID field
            //BaseTestUtils.report("Field genericLinuxID is missing, connecting to default: " + ServerIds.GENERIC_LINUX_SERVER, Reporter.PASS_NOR_FAIL);
            return ServerIds.GENERIC_LINUX_SERVER;
        }
        return null;
    }

    private <SERVER extends ServerCliBase> SERVER createAndInitServer(ServerIds serverId, Class<SERVER> clazz) {
        try {
            Constructor<SERVER> constructor = clazz.getConstructor(String.class, String.class, String.class, String.class);
            Optional<ServerDto> serverById = TestBase.getSutManager().getServerById(serverId.getServerId());
            if (!serverById.isPresent()) return null;
            ServerDto serverDto = serverById.get();
            SERVER server = constructor.newInstance(serverDto.getHost(), serverDto.getUser(), serverDto.getPassword(), serverDto.getGwMacAddress());
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
            server.setConnectOnInit(TestBase.connectOnInit());
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
        GENERIC_LINUX_SERVER_VANC("linuxFileServerVanc"),
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
