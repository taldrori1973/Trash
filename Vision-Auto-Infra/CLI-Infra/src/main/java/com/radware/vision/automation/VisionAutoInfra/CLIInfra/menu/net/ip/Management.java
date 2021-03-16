package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.ip;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Management extends Builder{
	
	public Management(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " management";
	}
}