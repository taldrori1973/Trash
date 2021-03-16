package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Service extends Builder {

	public Service(String prefix) {
		super(prefix);
	}
	
	public Start start(){
		return new Start(build());
	}
	
	public Stop stop(){
		return new Stop(build());
	}
	
	public Status status(){
		return new Status(build());
	}

	@Override
	public String getCommand() {
		return " service";
	}

}