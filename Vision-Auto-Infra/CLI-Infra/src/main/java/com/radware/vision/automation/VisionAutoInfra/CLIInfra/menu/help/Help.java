package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.help;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Help extends Builder{

	public Help(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " help";
	}
}