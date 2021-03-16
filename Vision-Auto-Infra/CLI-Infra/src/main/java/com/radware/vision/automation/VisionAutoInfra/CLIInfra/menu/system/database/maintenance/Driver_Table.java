package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.maintenance;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.access.Delete;

/**
 * @author OrG
 * */
public class Driver_Table extends Builder{

	
	public Driver_Table(String prefix) {
		super(prefix);
	}
	
	public Delete delete(){
		return new Delete(build());
	}

	@Override
	public String getCommand() {
		return " driver_table";
	}
}
