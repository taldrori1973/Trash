package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade.help;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Help extends Builder {

	public Help(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " help";
	}

}
