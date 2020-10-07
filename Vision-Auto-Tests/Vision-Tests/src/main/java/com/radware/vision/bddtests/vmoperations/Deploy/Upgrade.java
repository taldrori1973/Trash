package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionServer;

import java.util.HashMap;
import java.util.Map;

public class Upgrade extends Deploy {
    private static final Map<String, String> LAST_SUPPORTED_UPGRADE_VERSION = new HashMap<String, String>() {{
        put("4.80.00", "4.50.00");
        put("4.70.00", "4.40.00");
        put("4.60.00", "4.30.00");
        put("4.50.00", "4.20.00");
        put("4.40.00", "4.10.00");
    }};

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

    public String[] getNonSupportedVersion() {
        String lastKnownSupportedVersion = LAST_SUPPORTED_UPGRADE_VERSION.get(version);
        String[] versionSplit = lastKnownSupportedVersion.split("\\.");
        for (int i = versionSplit.length - 2; i >= 0; i--) {
            if (Integer.parseInt(versionSplit[i]) > 0) {
                int x = Integer.parseInt(versionSplit[i]) - 1;
                versionSplit[i] = Integer.toString(x);
                break;
            }
        }
        return versionSplit;
    }


}
