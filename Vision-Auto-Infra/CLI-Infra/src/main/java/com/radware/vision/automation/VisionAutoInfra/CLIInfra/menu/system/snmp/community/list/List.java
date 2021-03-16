package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community.list;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class List extends Builder {
    public List(String prefix) {
        super(prefix);
    }

    public String getCommand() {
        return " list";
    }

}
