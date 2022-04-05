package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class ChangePasswordRadware extends Builder{

	public ChangePasswordRadware(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " change-password radware";
	}
}
