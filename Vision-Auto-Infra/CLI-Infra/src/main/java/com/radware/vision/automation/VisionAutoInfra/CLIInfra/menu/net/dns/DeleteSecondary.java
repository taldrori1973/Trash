package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class DeleteSecondary extends Builder{

	public DeleteSecondary(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " delete secondary";
	}
}
