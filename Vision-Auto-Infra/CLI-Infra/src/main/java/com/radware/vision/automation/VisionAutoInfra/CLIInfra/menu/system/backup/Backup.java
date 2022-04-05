package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.config.Config;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.Full;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.SecurityReporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.TechSupport;

/**
 * @author Hadar Elbaz
 */

public class Backup extends Builder {

    public Backup(String prefix) {
        super(prefix);
    }

    public Config config() {
        return new Config(build());
    }

    public Full full() {
        return new Full(build());
    }

    public SecurityReporter securityReporter() {
        return new SecurityReporter(build());
    }

    public TechSupport techSupport() {
        return new TechSupport(build());
    }

    @Override
    public String getCommand() {
        return " backup";
    }
}