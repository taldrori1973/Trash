package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community.add.Add;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community.delete.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community.list.List;

/**
 * Created by UriG on 12/22/2014.
 */
public class Community extends Builder {

    public Community(String prefix) {
        super(prefix);
    }

    public Add add(){
        return new Add(build());
    }

    public Delete delete(){
        return new Delete(build());
    }

    public List list(){
        return new List(build());
    }

    @Override
    public String getCommand() {
        return " community";
    }
}
