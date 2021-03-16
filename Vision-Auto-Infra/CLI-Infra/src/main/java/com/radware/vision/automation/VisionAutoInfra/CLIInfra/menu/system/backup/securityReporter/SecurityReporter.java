package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.create.Create;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.delete.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.export.Export;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.import_.Import;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.info.Info;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.list.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.securityReporter.restore.Restore;

/**
 * Created by urig on 6/22/2015.
 */
public class SecurityReporter extends Builder {

    public SecurityReporter(String prefix) {
        super(prefix);
    }

    public Create create() {
        return new Create(build());
    }

    public Delete delete() {
        return new Delete(build());
    }

    public Export export() {
        return new Export(build());
    }

    public Import importBackup() {
        return new Import(build());
    }

    public Info info() {
        return new Info(build());
    }

    public List list() {
        return new List(build());
    }

    public Restore restore() {
        return new Restore(build());
    }

    @Override
    public String getCommand() {
        return " securityReporter";
    }
}
