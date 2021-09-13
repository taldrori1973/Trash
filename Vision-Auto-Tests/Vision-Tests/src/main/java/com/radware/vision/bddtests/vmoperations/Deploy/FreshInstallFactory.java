package com.radware.vision.bddtests.vmoperations.Deploy;

public class FreshInstallFactory {

    public static FreshInstall getFreshInstall(String fileType, boolean isExtended, String build)
    {
        switch (fileType.toLowerCase())
        {
            case "qcow2":
                return new FreshInstallQCow2(isExtended, build);
            case "serial iso":
                return new FreshInstallSerialISO(isExtended, build);
            case "ova":
                return new FreshInstallOVA(isExtended, build);
            default:
                return null;
        }
    }
}
