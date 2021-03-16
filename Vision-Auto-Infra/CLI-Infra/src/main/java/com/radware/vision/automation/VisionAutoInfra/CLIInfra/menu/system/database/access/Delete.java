package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.access;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;


/**
 * @author OrG
 * */
public class Delete extends Builder {

	public Delete(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " delete";
	}

}
