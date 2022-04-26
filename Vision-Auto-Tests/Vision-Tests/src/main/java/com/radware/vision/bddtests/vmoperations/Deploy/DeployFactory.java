package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;

import java.util.HashMap;

public class DeployFactory {

    private static HashMap<String, Upgrade> upgradeHM = new HashMap<>();
    private static HashMap<String, FreshInstall> freshInstallHM = new HashMap<>();

    public static Upgrade getUpgrade(RadwareServerCli radwareServerCli, RootServerCli rootServerCli)
    {
        //TODO why do we need the HM is it relevant for parallel?
        String key = String.format("%s", radwareServerCli.getDnsServerIp());

        if(upgradeHM.containsKey(key))
            return upgradeHM.get(key);

        Upgrade upgrade = new Upgrade(radwareServerCli, rootServerCli);
        upgradeHM.put(key, upgrade);

        return upgrade;
    }

    public static FreshInstall getFreshInstall(String environmentType)
    {
        //TODO why do we need the HM is it relevant for parallel?
        String key = String.format("%s", environmentType).toLowerCase();

        if(freshInstallHM.containsKey(key))
            return freshInstallHM.get(key);

        FreshInstall freshInstall;

        switch (environmentType.toLowerCase())
        {
            case "kvm":
                freshInstall = new FreshInstallQCow2(); break;
            case "serial iso":
                freshInstall = new FreshInstallSerialISO(); break;
            case "ova":
                freshInstall = new FreshInstallOVA(); break;
            default:
                freshInstall = null;
        }

        freshInstallHM.put(key, freshInstall);
        return freshInstall;
    }
}
