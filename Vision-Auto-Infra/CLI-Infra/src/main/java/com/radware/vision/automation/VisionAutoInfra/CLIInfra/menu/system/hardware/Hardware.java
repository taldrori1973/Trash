package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.hardware;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.hardware.status.Status;

public class Hardware extends Builder {

	public Hardware(String prefix) {
		super(prefix);
	}
	
	public Status status() {
		return new Status(build());
	}
	@Override
	public String getCommand() {
		return " hardware";
	}
}
