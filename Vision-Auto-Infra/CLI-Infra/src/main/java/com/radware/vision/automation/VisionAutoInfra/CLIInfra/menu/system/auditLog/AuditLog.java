package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.auditLog;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Export;

/**
 * Created by stanislava on 12/21/2014.
 */
public class AuditLog extends Builder {

    public AuditLog(String prefix) {
        super(prefix);
    }

    public Export export(){
        return new Export(build());
    }

    @Override
    public String getCommand() {
        return " audit-log";
    }
}
