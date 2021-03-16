package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Change extends Builder {
	
	public Change(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " change";
	}
}
