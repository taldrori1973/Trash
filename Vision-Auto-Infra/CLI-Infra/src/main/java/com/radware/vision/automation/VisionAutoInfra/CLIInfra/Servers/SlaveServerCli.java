package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

public class SlaveServerCli extends RootServerCli{
    private final static String username = "root";
    private final static String password = "radware";
    public SlaveServerCli(String host, String user, String password) {
        super(host, user, password);
    }

    public static String getSlaveUsername()
    {
        return username;
    }

    public static String getSlavePassword()
    {
        return password;
    }


}
