package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;

import java.util.HashMap;

public class DeployFactory {

    private static HashMap<String, Upgrade> upgradeHM = new HashMap<>();
    private static HashMap<String, FreshInstall> freshInstallHM = new HashMap<>();

    public static Upgrade getUpgrade(boolean isExtended, String build, RadwareServerCli radwareServerCli, RootServerCli rootServerCli)
    {
        String key = String.format("%s#%s", isExtended, build);

        if(upgradeHM.containsKey(key))
            return upgradeHM.get(key);

        Upgrade upgrade = new Upgrade(isExtended, build, radwareServerCli, rootServerCli);
        upgradeHM.put(key, upgrade);

        return upgrade;
    }

    public static FreshInstall getFreshInstall(String environmentType, boolean isExtended, String build)
    {
        String key = String.format("%s#%s#%s", environmentType, isExtended, build).toLowerCase();

        if(freshInstallHM.containsKey(key))
            return freshInstallHM.get(key);

        FreshInstall freshInstall;

        switch (environmentType.toLowerCase())
        {
            case "kvm":
                freshInstall = new FreshInstallQCow2(isExtended, build); break;
            case "serial iso":
                freshInstall = new FreshInstallSerialISO(isExtended, build); break;
            case "ova":
                freshInstall = new FreshInstallOVA(isExtended, build); break;
            default:
                freshInstall = null;
        }

        freshInstallHM.put(key, freshInstall);
        return freshInstall;
    }
}
