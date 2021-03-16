package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history.period;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by ashrafa on 9/27/2017.
 */
public class Period extends Builder {

    public Period(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " period";
    }

}
