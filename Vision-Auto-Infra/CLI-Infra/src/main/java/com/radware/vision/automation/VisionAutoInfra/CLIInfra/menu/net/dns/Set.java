package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;


public class Set extends Builder{

	public Set(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set";
	}
}