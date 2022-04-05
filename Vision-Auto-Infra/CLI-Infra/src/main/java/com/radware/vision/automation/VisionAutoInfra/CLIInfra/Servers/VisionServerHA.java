package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

/**
 * Created by moaada on 4/16/2017.
 */
public class VisionServerHA extends ServerCliBase {



    String host_1;
    String host_2;
    @Override
    public void init() throws Exception {
        super.init();
    }


    public String getHost_1() {
        return host_1;
    }

    public void setHost_1(String host_1) {
        this.host_1 = host_1;
    }

    public String getHost_2() {
        return host_2;
    }

    public void setHost_2(String host_2) {
        this.host_2 = host_2;
    }
}
