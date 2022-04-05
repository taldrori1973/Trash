package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Info extends Builder{

	public Info(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " info";
	}
}