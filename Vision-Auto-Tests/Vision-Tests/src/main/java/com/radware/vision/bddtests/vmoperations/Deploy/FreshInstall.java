package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public abstract class FreshInstall extends Deploy{
    protected boolean isAPM;

    public FreshInstall(boolean isExtended, String build, String ipaddress, FileType fileType) {
        super(isExtended, build, ipaddress, fileType);
        initIsAPM();
        buildFileInfo(fileType);
    }

    public void initIsAPM() {
        String attr = getVisionSetupAttributeFromSUT("serverType");
        this.isAPM = attr != null && "apm".equals(attr.toLowerCase().trim());
    }
}
