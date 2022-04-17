package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.systemManagement.visionConfigurations.SetupImpl;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;


public abstract class FreshInstall extends Deploy{

    public FreshInstall(String ipaddress, FileType fileType) {
        super(ipaddress, fileType);
        buildFileInfo(fileType);
    }

    @Override
    public void afterDeploy() {
        super.afterDeploy();

        try
        {
            SetupImpl setup = new SetupImpl();
            setup.buildSetup();
        }
        catch (Exception ignore){}
    }
}
