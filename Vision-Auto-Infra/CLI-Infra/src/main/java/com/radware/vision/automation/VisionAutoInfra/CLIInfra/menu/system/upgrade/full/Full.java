package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade.full;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Full extends Builder {
	
	public Full(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " full";
	}
}

