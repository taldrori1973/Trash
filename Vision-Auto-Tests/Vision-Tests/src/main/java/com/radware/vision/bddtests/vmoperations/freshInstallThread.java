package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.bddtests.vmoperations.Deploy.FreshInstallOVA;
import com.radware.vision.vision_handlers.NewVmHandler;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import static com.radware.vision.base.VisionUITestBase.restTestBase;

public class freshInstallThread extends Thread {

    private NewVmHandler vmHandler;
    private String build = "";
    VisionVMs visionVMs;
    String vmName;
    String vCenterUser;
    String vCenterPassword;
    String hostip;
    String vCenterURL;
    String networkName;
    String resourcePool;
    String dataStores;
    String version;

    freshInstallThread(String machine, String cli, String vmName) {
        vmHandler = new NewVmHandler(machine, cli);
        build = BaseTestUtils.getRuntimeProperty("BUILD", build);//get build from portal
        visionVMs = restTestBase.getVisionVMs();
        this.vmName = vmName;
        vCenterUser = visionVMs.getUserName();
        vCenterPassword = visionVMs.getPassword();
        hostip = visionVMs.getvCenterIP();
        vCenterURL = visionVMs.getvCenterURL();
        networkName = visionVMs.getNetworkName();
        resourcePool = visionVMs.getResourcePool();
        dataStores = visionVMs.getDataStores();
        version = readVisionVersionFromPomFile();
    }

    @Override
    public void run() {
        try {
            FreshInstallOVA freshInstallOVA = new FreshInstallOVA(true, null);
            vmHandler.firstTimeWizardOva(freshInstallOVA.getBuildFileInfo().getDownloadUri().toString(), false, vCenterURL, vCenterUser, vCenterPassword, hostip,
                    build, vmName, null, networkName, resourcePool, null, dataStores);
        }
        catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public String readVisionVersionFromPomFile() {
        Properties properties = new Properties();

        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("vision-tests-pom.properties");

        if (inputStream != null) {
            try {
                properties.load(inputStream);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return properties.getProperty("vision-version");
    }
}
