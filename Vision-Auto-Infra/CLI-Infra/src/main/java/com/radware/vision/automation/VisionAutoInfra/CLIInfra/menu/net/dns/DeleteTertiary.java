package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class DeleteTertiary extends Builder{

	public DeleteTertiary(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " delete tertiary";
	}
}
