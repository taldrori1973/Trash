package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.syslog_port;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * Created by ashrafa on 9/26/2017.
 */
public class SysLogPort extends Builder {

    public SysLogPort(String prefix) {
        super(prefix);
    }

    public Get get(){
        return new Get(build());
    }

    public Set set(){
        return new Set(build());
    }

    @Override
    public String getCommand() {
        return " syslog-port";
    }
}
