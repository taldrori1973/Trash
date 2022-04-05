package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.cleanup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Cleanup extends Builder{

	public Cleanup(String prefix) {
		super(prefix);
	}

	public Full full(){
		return new Full(build());
	}
	
	public WithoutServerIp withoutServerIp(){
		return new WithoutServerIp(build());
	}
	
	@Override
	public String getCommand() {
		return " cleanup";
	}
}