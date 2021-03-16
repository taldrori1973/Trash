package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.configuration;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;

/**
 * Created by ashrafa on 9/26/2017.
 */
public class Configuration extends Builder {
    public Configuration(String prefix) {
        super(prefix);
    }

    public Get get(){
        return new Get(build());
    }

    @Override
    public String getCommand() {
        return " configuration";
    }
}
