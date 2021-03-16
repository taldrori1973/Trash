package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.vision_server;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Start;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Status;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Stop;

/**
 * 
 * @author Hadar Elbaz
 */

public class VisionServer extends Builder{

	public VisionServer(String prefix) {
		super(prefix);
	}
	
	public Start start(){
		return new Start(build());
	}
	
	public Status status(){
		return new Status(build());
	}
	
	public Stop stop(){
		return new Stop(build());
	}
	
	@Override
	public String getCommand() {
		return " vision-server";
	}
}