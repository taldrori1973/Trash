package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.java.certificate_algorithm;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Get extends Builder{

	public Get(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " get";
	}
}