package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionServer;

public class Upgrade extends Deploy {
    public Upgrade(boolean isExtended, boolean isAPM, String build, String version, String featureBranch, String repositoryName) {
        super(isExtended, isAPM, build, version, featureBranch, repositoryName);
        buildFileInfo(isAPM ? FileType.UPGRADE_APM : FileType.UPGRADE);
    }

    public void deploy() {
        try {
            if (!isSetupNeeded) return;
            String[] path = buildFileInfo.getPath().toString().split("/");
            VisionServer.upgradeServerFile(WebUITestBase.getRestTestBase().getRadwareServerCli(), WebUITestBase.getRestTestBase().getRootServerCli()
                    , version, null, path[path.length - 1], buildFileInfo.getDownloadUri().toString());
            UpgradeSteps.validateVisionServerServicesUP(WebUITestBase.getRestTestBase().getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}
