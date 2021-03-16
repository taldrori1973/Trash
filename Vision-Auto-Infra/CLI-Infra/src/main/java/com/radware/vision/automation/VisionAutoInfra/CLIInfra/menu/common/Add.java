package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Add extends Builder {

	public Add(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " add";
	}
}
