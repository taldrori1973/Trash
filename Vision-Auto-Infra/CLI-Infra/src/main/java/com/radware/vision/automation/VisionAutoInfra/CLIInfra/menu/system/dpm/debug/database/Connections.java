package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * 
 * @author Izik Penso
 */
public class Connections extends Builder{

	public Connections(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " connections";
	}
}