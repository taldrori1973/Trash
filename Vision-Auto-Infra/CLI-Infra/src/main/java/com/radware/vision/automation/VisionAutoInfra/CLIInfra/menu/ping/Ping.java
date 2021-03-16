package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.ping;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Ping extends Builder{

	public Ping(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " ping";
	}
}