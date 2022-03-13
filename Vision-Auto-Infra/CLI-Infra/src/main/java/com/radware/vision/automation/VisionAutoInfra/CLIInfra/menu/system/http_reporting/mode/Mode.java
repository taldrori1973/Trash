package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;

public class Mode extends Builder {
    public Mode(String prefix) {
        super(prefix);
    }

    public com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get get() {return new Get(build());}

    public SetOn setOn() {return new SetOn(build());}

    public Validate validate() {return new Validate(build());}

    @Override
    public String getCommand() {
        return " mode";
    }
}
