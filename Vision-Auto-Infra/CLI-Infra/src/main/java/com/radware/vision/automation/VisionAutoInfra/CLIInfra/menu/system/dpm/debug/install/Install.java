package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.install;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Izik Penso
 */

public class Install extends Builder{
	
	public Install(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " install";
	}
	

}
