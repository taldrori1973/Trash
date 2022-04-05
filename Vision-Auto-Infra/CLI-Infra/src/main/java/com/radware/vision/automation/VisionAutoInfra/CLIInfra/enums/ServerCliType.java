package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by AviH on 11/22/2015.
 */

public enum ServerCliType {
        ROOT_SERVER_CLI("rootServerCli"),
        RADWARE_SERVER_CLI("radwareServerCli");

        private String type;

        private ServerCliType(String type) {
            this.type = type;
        }

        public String ServerCliType() {
            return this.type;
        }
    }
