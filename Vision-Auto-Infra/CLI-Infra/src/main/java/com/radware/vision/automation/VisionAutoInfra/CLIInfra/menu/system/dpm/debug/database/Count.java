package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * 
 * @author Izik Penso
 */
public class Count extends Builder{

	public Count(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " count";
	}
}