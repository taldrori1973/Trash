package com.radware.vision.infra;

import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks.ValidateTasksHandler;
import org.junit.Test;

import java.util.Arrays;

public class ValidateTasksHandlerTests {


    @Test
    public void validateExternalLocationDeviceConfBackupTest() {
        VisionRestClient visionRestClient = new VisionRestClient("172.17.163.4", "", RestBasicConsts.RestProtocol.HTTPS);
        visionRestClient.login("radware", "radware", null, 2);
        visionRestClient.getHttpSession().setJsessionidRH(true);
        LinuxServerCredential linuxServerCredential = new LinuxServerCredential("172.17.164.100", "root", "radware");
        String[] devices = {"172.17.163.7", "172.16.22.31"};
        try {
            if (!ValidateTasksHandler.validateExternalLocationDeviceConfBackup("/root/temp", "ssd", Arrays.asList(devices), visionRestClient, linuxServerCredential)) {
                System.out.println(ValidateTasksHandler.errorMessages);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            visionRestClient.logout(2);
        }
    }
}

