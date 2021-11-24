package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

public enum LLSStateCMDs {

    GET("get"),
    ENABLE("enable"),
    DISABLE("disable");

    private String cmd;

    LLSStateCMDs(String cmd) {
        this.cmd = cmd;
    }

    public String getCmd() {
        return cmd;
    }

    public static LLSStateCMDs getConstant(String cmd){
        cmd = cmd.toLowerCase();
        switch (cmd){
            case "get": return GET;
            case "enable": return ENABLE;
            case "disable": return DISABLE;
            default:return null;
        }
    }
}
