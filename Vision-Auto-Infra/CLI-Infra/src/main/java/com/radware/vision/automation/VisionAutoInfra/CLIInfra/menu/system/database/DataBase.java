package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Clear;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Start;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Status;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Stop;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.access.Access;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.maintenance.Maintenance;

/**
 * 
 * @author Hadar Elbaz
 */

public class DataBase extends Builder{

	public DataBase(String prefix) {
		super(prefix);
	}
	
	
	public Clear clear(){
		return new Clear(build());
	}
	
	public Start start(){
		return new Start(build());
	}
	
	public Access access(){
		return new Access(build());
	}
	
	public Stop stop(){
		return new Stop(build());
	}
	
	public Status status(){
		return new Status(build());
	}
	
	public Maintenance maintenance(){
		return new Maintenance(build());
	}
	
	
	@Override
	public String getCommand() {
		return " database";
	}
}
