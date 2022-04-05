package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Start extends Builder {

	public Start(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " start";
	}

}
