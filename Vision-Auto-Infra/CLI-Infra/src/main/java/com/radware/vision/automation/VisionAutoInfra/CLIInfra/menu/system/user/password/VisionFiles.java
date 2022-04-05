package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

;

public class VisionFiles extends Builder {
	
	public VisionFiles(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " vision-files";
	}
}
