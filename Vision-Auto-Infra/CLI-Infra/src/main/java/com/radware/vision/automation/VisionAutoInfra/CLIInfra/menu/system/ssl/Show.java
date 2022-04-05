package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Show extends Builder {

	public Show(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " show";
	}

}