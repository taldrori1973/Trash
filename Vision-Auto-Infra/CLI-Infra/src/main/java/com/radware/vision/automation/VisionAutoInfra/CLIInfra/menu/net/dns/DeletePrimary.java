package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class DeletePrimary extends Builder {

	public DeletePrimary(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " delete primary";
	}
}
