package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.state;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Disable;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Enable;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;

/**
 * Created by ashrafa on 9/26/2017.
 */
public class State extends Builder {
    public State(String prefix) {
        super(prefix);
    }

    public Disable disable() { return new Disable(build()); }

    public Enable enable() { return new Enable(build()); }

    public Get get(){
        return new Get(build());
    }

    @Override
    public String getCommand() {
        return " state";
    }
}
