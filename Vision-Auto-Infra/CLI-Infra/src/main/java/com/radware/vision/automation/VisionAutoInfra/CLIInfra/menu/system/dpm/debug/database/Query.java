package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * 
 * @author Izik Penso
 */
public class Query extends Builder{

	public Query(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " query";
	}
}