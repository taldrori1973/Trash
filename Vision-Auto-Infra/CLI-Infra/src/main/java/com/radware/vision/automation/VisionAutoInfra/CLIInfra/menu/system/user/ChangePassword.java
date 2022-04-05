package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class ChangePassword extends Builder{

	public ChangePassword(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " change-password";
	}
}
