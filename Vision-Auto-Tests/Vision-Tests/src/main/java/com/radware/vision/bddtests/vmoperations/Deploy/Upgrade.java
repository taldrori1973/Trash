package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionServer;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;

import java.util.HashMap;
import java.util.Map;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class Upgrade extends Deploy {
    private static final Map<String, String> LAST_SUPPORTED_UPGRADE_VERSION = new HashMap<String, String>() {{
        put("4.84.00", "4.81.00");
        put("4.83.00", "4.80.00");
        put("4.82.00", "4.70.00");
        put("4.81.00", "4.60.00");
        put("4.80.00", "4.50.00");
        put("4.70.00", "4.40.00");
        put("4.60.00", "4.30.00");
        put("4.50.00", "4.20.00");
        put("4.40.00", "4.10.00");
    }};
    private final RadwareServerCli radwareServerCli;
    private final RootServerCli rootServerCli;
    private FileType upgradeType;

    public Upgrade(boolean isExtended, String build, RadwareServerCli radwareServerCli, RootServerCli rootServerCli) {
        super(isExtended, build, rootServerCli.getHost());
        this.radwareServerCli = radwareServerCli;
        this.rootServerCli = rootServerCli;
        this.initFileType();
        buildFileInfo(this.upgradeType);
    }

    /**
     * initialize the right FileType according to serverCli for deploy.
     */
    public void initFileType() {
        if (UpgradeSteps.isAPM()) {
            this.upgradeType = FileType.UPGRADE_APM;
        } else {
            this.upgradeType = FileType.UPGRADE;
        }
    }


    @Override
    public void deploy() {
        try {
            if (!isSetupNeeded) return;
            String[] path = buildFileInfo.getPath().toString().split("/");
            VisionServer.upgradeServerFile(this.radwareServerCli, this.rootServerCli
                    , version, null, path[path.length - 1], buildFileInfo.getDownloadUri().toString());
            UpgradeSteps.validateVisionServerServicesUP(WebUITestBase.getRestTestBase().getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed. Changing server to OFFLINE", Reporter.FAIL);
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
