package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.shutdown;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Shutdown extends Builder{

	public Shutdown(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " shutdown";
	}
}