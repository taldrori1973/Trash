package com.radware.vision.infra.utils.threadutils;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import junit.framework.SystemTestCase4;

import java.util.TimerTask;

/**
 * Created by UriG on 2/10/2015.
 */
public class ThreadsStatusMonitor extends TimerTask {

    CliConnectionImpl targetConnection;

    public ThreadsStatusMonitor(CliConnectionImpl connection) {
        this.targetConnection = connection;
    }

    @Override
    public void run() {
        String currentThreadsBusy = "/opt/radware/mgt-server/third-party/jboss-4.2.0.GA/bin/twiddle.sh  get jboss.web:name=ajp-0.0.0.0-8009,type=ThreadPool  currentThreadsBusy | cut -d \"=\" -f2";
        String currentThreadCount = "/opt/radware/mgt-server/third-party/jboss-4.2.0.GA/bin/twiddle.sh  get jboss.web:name=ajp-0.0.0.0-8009,type=ThreadPool  currentThreadCount | cut -d \"=\" -f2";
        String maxThreads = "/opt/radware/mgt-server/third-party/jboss-4.2.0.GA/bin/twiddle.sh  get jboss.web:name=ajp-0.0.0.0-8009,type=ThreadPool  maxThreads | cut -d \"=\" -f2";
        try {
            InvokeUtils.invokeCommand(null, currentThreadsBusy, targetConnection, 4000, true, false);
            String currentThreadsBusyResult = parseResponse(targetConnection.getTestAgainstObject().toString());
            InvokeUtils.invokeCommand(null, currentThreadCount, targetConnection, 4000, true, false);
            String currentThreadCountResult = parseResponse(targetConnection.getTestAgainstObject().toString());
            InvokeUtils.invokeCommand(null, maxThreads, targetConnection, 4000, true, false);
            String maxThreadsResult = parseResponse(targetConnection.getTestAgainstObject().toString());
            SystemTestCase4.report.report("Threads Utilization = " + ((Integer.valueOf(currentThreadsBusyResult) * 100) / Integer.valueOf(maxThreadsResult)) + "\n" +
                    "Threads Count: " + currentThreadCountResult, Reporter.PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String parseResponse(String testObject) {
        String testString = testObject.split("\n")[1];
        return testString.substring(0, testString.indexOf("\r"));
    }
}
