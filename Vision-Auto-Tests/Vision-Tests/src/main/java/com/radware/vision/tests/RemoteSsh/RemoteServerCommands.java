package com.radware.vision.tests.RemoteSsh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.utils.RemoteProcessExecutor;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 9/17/2014.
 */
public class RemoteServerCommands extends WebUITestBase {

    String remoteServerIP;
    String remoteUsername;
    String scriptPath;
    String scriptName;

    @Test
    @TestProperties(name = "Run Remote Linux Script", paramsInclude = {"qcTestId", "remoteServerIP", "remoteUsername", "scriptPath", "scriptName"})
    public void runRemoteScript() {
        try {
            RemoteProcessExecutor remoteProcessExecutor = new RemoteProcessExecutor(remoteServerIP, remoteUsername);
            remoteProcessExecutor.execScript(scriptPath, scriptName);
        }
        catch(Exception e) {
            BaseTestUtils.report("Failed to run script: " + scriptPath + "/" + scriptName + "\n" + parseExceptionBody(e), Reporter.WARNING);
        }
    }

    public String getRemoteServerIP() {
        return remoteServerIP;
    }

    public void setRemoteServerIP(String remoteServerIP) {
        this.remoteServerIP = remoteServerIP;
    }

    public String getRemoteUsername() {
        return remoteUsername;
    }

    public void setRemoteUsername(String remoteUsername) {
        this.remoteUsername = remoteUsername;
    }

    public String getScriptPath() {
        return scriptPath;
    }

    public void setScriptPath(String scriptPath) {
        this.scriptPath = scriptPath;
    }

    public String getScriptName() {
        return scriptName;
    }

    public void setScriptName(String scriptName) {
        this.scriptName = scriptName;
    }
}
