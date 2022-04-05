package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.openport;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.openport.list.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.openport.set.Set;

public class OpenPort extends Builder {
	
	public OpenPort(String prefix) {
		super(prefix);
	}

	public Set set() {
		return new Set(build());
	}
	
	public List list() {
		return new List(build());
	}
	
	@Override
	public String getCommand() {
		return " open-port";
	}
}
