package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Clear;


/**
 * 
 * @author Izik Penso
 */

public class Database extends Builder{

	public Database(String prefix) {
		super(prefix);
	}
	
	public Clear clear(){
		return new Clear(build());
	}
	
	@Override
	public String getCommand() {
		return " database";
	}	
}
