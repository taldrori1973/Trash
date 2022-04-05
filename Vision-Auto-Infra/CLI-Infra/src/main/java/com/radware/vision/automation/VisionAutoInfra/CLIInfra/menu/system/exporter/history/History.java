package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history.last.Last;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history.period.Period;

/**
 * Created by ashrafa on 9/27/2017.
 */
public class History extends Builder {

    public History(String prefix) {
        super(prefix);
    }

    public Last last() {
        return new Last(build());
    }

    public Period period() { return new Period(build()); }

    @Override
    public String getCommand() {
        return " history";
    }
}
