package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade.full.Full;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade.help.Help;

public class Upgrade extends Builder {
	
	public Upgrade(String prefix) {
		super(prefix);
	}
	
	public Full full() {
		return new Full(build());
	}
	
	public Help help(){
		return new Help(build());
	}

	@Override
	public String getCommand() {
		return " upgrade";
	}

}
