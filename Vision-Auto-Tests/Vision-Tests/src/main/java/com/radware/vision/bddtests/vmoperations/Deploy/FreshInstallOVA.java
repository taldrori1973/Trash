package com.radware.vision.bddtests.vmoperations.Deploy;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallOVA extends Deploy {

    public FreshInstallOVA(boolean isExtended, String build) {
        super(isExtended, build);
        this.isAPM = getVisionSetupAttributeFromSUT("isAPM") != null && Boolean.parseBoolean(getVisionSetupAttributeFromSUT("isAPM"));
        buildFileInfo(this.isAPM ? FileType.OVA_APM : FileType.OVA);

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
