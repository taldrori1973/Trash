package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import java.util.Arrays;

import static com.radware.vision.automation.base.TestBase.getSutManager;

public class FreshInstallOVA extends FreshInstall {
    private FileType fileType = FileType.OVA;

    public FreshInstallOVA() {
        super(TestBase.restTestBase.getVisionRestClient().getDeviceIp(), FileType.OVA);
    }

    @Override
    public void deploy() {
        // init firstTimeWizardOva parameters
        String vmName = String.format("%s_%s", getSutManager().getServerName(), getSutManager().getClientConfigurations().getHostIp());
        if (vmName == null) {
            BaseTestUtils.report("Can't find \"vmPrefix\" at SUT File", Reporter.FAIL);
        }
        boolean isAPM = false;//this.fileType.isContained("APM");
        String vCenterUser = getSutManager().getEnvironment().get().getUser();
        String vCenterPassword = getSutManager().getEnvironment().get().getPassword();
        String hostIp = getSutManager().getEnvironment().get().getHostIp();
        String vCenterURL = getSutManager().getEnvironment().get().getUrl();
        String networkName = getSutManager().getEnvironment().get().getNetworkName();
        String resourcePool = getSutManager().getEnvironment().get().getResourcePool();
        String dataStores = getSutManager().getEnvironment().get().getDataStores();
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardOva(super.getBuildFileInfo().getDownloadUri().toString(), isAPM, vCenterURL, vCenterUser, vCenterPassword, hostIp,
                    super.getBuild(), vmName, null, networkName, resourcePool, null, dataStores);
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed. Changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report("Failed to Create NewVm: " + vmName + " failed with the following error: \n" +
                    "Message: " + e.getMessage() + "\n" +
                    "Cause: " + e.getCause() + "\n" +
                    "Stack Trace: " + Arrays.asList(e.getStackTrace()), Reporter.FAIL);
        }
    }
}
