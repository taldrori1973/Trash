package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.create.Create;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.delete.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.export.Export;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.import_.Import;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.info.Info;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.list.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.restore.Restore;

/**
 * Created by urig on 6/22/2015.
 */
public class Full extends Builder {

    public Full(String prefix) {
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
        return " full";
    }
}
