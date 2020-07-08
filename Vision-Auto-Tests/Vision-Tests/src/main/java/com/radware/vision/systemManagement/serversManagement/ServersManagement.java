package com.radware.vision.systemManagement.serversManagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.base.TestBase;

import java.lang.reflect.Constructor;
import java.util.Optional;

public class ServersManagement {


    private LinuxFileServer linuxFileServer;
    private LinuxFileServer deploymentServer;
//    private RadwareServerCli radwareServerCli;
//    private RootServerCli rootServerCli;

    public ServersManagement() {
        this.linuxFileServer = this.createAndInitServer(ServerIds.LINUX_FILE_SERVER, LinuxFileServer.class);
        this.deploymentServer = this.createAndInitServer(ServerIds.DEPLOYMENT_SERVER, LinuxFileServer.class);
//        this.radwareServerCli = this.createAndInitServer(ServerIds.RADWARE_SERVER_CLI, RadwareServerCli.class);
//        this.rootServerCli = this.createAndInitServer(ServerIds.ROOT_SERVER_CLI, RootServerCli.class);
    }

    private <SERVER extends ServerCliBase> SERVER createAndInitServer(ServerIds serverId, Class<SERVER> clazz) {
        try {
            Constructor<SERVER> constructor = clazz.getConstructor(String.class, String.class, String.class);
//          kVision
//              fix when will have RADWARE/ROOT users
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

    public Optional<LinuxFileServer> getLinuxFileServer() {
        return this.linuxFileServer != null ? Optional.of(linuxFileServer) : Optional.empty();
    }

//    public Optional<RadwareServerCli> getRadwareServerCli() {
//        return this.radwareServerCli != null ? Optional.of(radwareServerCli) : Optional.empty();
//    }
//
//    public Optional<RootServerCli> getRootServerCLI() {
//        return this.rootServerCli != null ? Optional.of(rootServerCli) : Optional.empty();
//    }

    public enum ServerIds {
        LINUX_FILE_SERVER("linuxFileServer"),
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
        switch (ServerId){
            case LINUX_FILE_SERVER:
                serverCliBase = this.linuxFileServer;
                break;
            default:
                BaseTestUtils.report("Server ID" + ServerId + " is not implemented", Reporter.FAIL);
        };
        return serverCliBase;
    }

}
