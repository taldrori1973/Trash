package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Update extends Builder {

	public Update(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " update";
	}
}
