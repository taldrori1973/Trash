package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Set extends Builder{
	
	public Set(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set";
	}
}