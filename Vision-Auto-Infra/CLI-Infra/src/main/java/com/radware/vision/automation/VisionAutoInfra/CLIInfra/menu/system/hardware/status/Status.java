package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.hardware.status;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;

public class Status extends Builder {

	public Status(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	} 
	
	@Override
	public String getCommand() {
		return " status";
	}
}
