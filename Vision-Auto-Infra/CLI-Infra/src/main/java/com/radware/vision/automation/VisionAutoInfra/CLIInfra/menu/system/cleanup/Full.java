package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.cleanup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Full extends Builder{

	public Full(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " full";
	}
}