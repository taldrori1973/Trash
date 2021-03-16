package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.create.Create;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.delete.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.export.Export;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.import_.Import;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.info.Info;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.list.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.restore.Restore;

/**
 * @author Hadar Elbaz
 */

public class TechSupport extends Builder {

    public TechSupport(String prefix) {
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
        return " techSupport";
    }
}
