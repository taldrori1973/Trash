package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.access;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Access extends Builder{

	public Access(String prefix) {
		super(prefix);
	}
	
	public Display display(){
		return new Display(build());
	}
	
	public Grant grant(){
		return new Grant(build());
	}
	
	public Revoke revoke(){
		return new Revoke(build());
	}
	
	@Override
	public String getCommand() {
		return " access";
	}
}