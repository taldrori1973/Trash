package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.exit;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Exit extends Builder{

	public Exit(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " exit";
	}
}