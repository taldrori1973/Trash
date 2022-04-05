package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.database;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Izik Penso
 */

public class Database extends Builder{

	public Database(String prefix) {
		super(prefix);
	}
	
	public Connections connections(){
		return new Connections(build());
	}
	
	public Count count(){
		return new Count(build());
	}

	public Devices devices(){
		return new Devices(build());
	}
	
	public Query query(){
		return new Query(build());
	}
	
	@Override
	public String getCommand() {
		return " database";
	}
	
	

	

	

	

}
