package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.mode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * Created by moaada on 4/9/2017.
 */
public class Mode extends Builder {

    public Mode(String prefix) {
        super(prefix);
    }

    public Get get() {
        return new Get(build());
    }

    public Set set() {
        return new Set(build());
    }

    @Override
    public String getCommand() {
        return " mode";
    }


}
