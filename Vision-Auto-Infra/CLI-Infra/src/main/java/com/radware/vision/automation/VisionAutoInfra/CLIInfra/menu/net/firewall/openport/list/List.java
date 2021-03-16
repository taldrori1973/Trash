package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.openport.list;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class List extends Builder {
	
	public List(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " list";
	}
}
