package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.configuration.Configuration;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history.History;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.state.State;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.syslog_host.SysLogHost;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.syslog_port.SysLogPort;

/**
 * Created by ashrafa on 9/26/2017.
 */
public class Exporter extends Builder {
    public Exporter(String prefix) {
        super(prefix);
    }

    public Configuration configuration() { return new Configuration(build()); }

    public History history() { return new History(build()); }

    public State state() { return new State(build()); }

    public SysLogHost sysLogHost() {
        return new SysLogHost(build());
    }

    public SysLogPort sysLogPort() { return new SysLogPort(build()); }

    @Override
    public String getCommand() {
        return " exporter";
    }
}
