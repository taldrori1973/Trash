package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.clioperation.connections.NewVmSteps;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.NewVmHandler;
import cucumber.api.DataTable;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class FreshInstallOVA extends Deploy {

    public FreshInstallOVA(boolean isExtended, boolean isAPM, String build, String version, String featureBranch, String repositoryName) {
        super(isExtended, isAPM, build, version, featureBranch, repositoryName);
        buildFileInfo(isAPM ? FileType.OVA_APM : FileType.OVA);

    }

    public void deploy() {
        try {
//            NewVmHandler vmHandler = new NewVmHandler();
////            vmHandler.firstTimeWizardKVM(isAPM, version, build,buildFileInfo.getDownloadUri().getPath());
//            VisionVMs visionVMs = WebUITestBase.restTestBase.getVisionVMs();
//            NewVmSteps newVmSteps = new NewVmSteps();
//            String vmName = VMOperationsSteps.getVisionSetupAttributeFromSUT("vmPrefix");
//            if (vmName == null) throw new NullPointerException("Can't find \"vmPrefix\" at SUT File");
//
//            List<String> columnNames = Arrays.asList("version", "build", "NewVmName", "isAPM");
//            List<String> values;
//            values = Arrays.asList(version, build, vmName, String.valueOf(isAPM));
//            List<List<String>> row = Arrays.asList(columnNames, values);
//            DataTable dataTable = DataTable.create(row, Locale.getDefault(), "version", "build", "NewVmName", "isAPM");
//            newVmSteps.firstTimeWizardOva(dataTable, visionVMs);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
