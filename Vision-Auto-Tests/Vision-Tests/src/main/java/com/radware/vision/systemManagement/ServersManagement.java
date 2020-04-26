package com.radware.vision.systemManagement;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;

public class ServersManagement {

    private <SERVER extends ServerCliBase> SERVER createAndInitServer(Class type) {

    }

    enum ServerTypes {
        LINUX_FILE_SERVER("linuxFileServer");


        private String serverId;

        ServerTypes(String serverId) {
            this.serverId = serverId;
        }

        public String getServerId() {
            return serverId;
        }

        public void setServerId(String serverId) {
            this.serverId = serverId;
        }
    }
}
