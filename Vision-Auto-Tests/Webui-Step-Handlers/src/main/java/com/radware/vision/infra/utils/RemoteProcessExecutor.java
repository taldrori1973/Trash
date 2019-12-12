package com.radware.vision.infra.utils;


import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Created by urig on 9/17/2014.
 */
public class RemoteProcessExecutor {
    String remoteServerIP;
    String remoteServerUsername;
    Process process;


    private RemoteProcessExecutor() {}

    public RemoteProcessExecutor(String ip, String remoteServerUsername) {
        this.remoteServerIP = ip;
        this.remoteServerUsername = remoteServerUsername;
    }

    public void execScript(String scriptPath, String scriptName) {
        try {
            process = Runtime.getRuntime().exec("ssh" + " " + remoteServerUsername + "@" + remoteServerIP + " " + scriptPath + "/" + scriptName + " &");
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public OutputStream getOutputStream() {
        return process.getOutputStream();
    }

    public InputStream getInputStream() {
        return process.getInputStream();
    }

    public String getRemoteServerIP() {
        return remoteServerIP;
    }

    public void setRemoteServerIP(String remoteServerIP) {
        this.remoteServerIP = remoteServerIP;
    }

    public String getRemoteServerUsername() {
        return remoteServerUsername;
    }

    public void setRemoteServerUsername(String remoteServerUsername) {
        this.remoteServerUsername = remoteServerUsername;
    }
}
