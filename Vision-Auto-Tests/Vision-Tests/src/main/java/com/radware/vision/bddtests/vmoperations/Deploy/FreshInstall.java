package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;


public abstract class FreshInstall extends Deploy{

    public FreshInstall(String ipaddress, FileType fileType) {
        super(ipaddress, fileType);
        buildFileInfo(fileType);
    }
}
