package com.radware.vision.bddtests.vmoperations.Deploy;

public class FreshInstallFactory {

    public static FreshInstall getFreshInstall(String fileType)
    {
        switch (fileType.toLowerCase())
        {
            case "qcow2":
                return new FreshInstallQCow2();
            case "serial iso":
                return new FreshInstallSerialISO();
            case "ova":
                return new FreshInstallOVA();
            default:
                return null;
        }
    }
}
