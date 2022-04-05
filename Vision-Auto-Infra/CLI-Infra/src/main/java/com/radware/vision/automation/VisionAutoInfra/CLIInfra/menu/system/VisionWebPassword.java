package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * 
 * @author Hadar Elbaz
 */

public class VisionWebPassword extends Builder{

	public VisionWebPassword(String prefix) {
		super(prefix);
	}
	
	public Set set(){
		return new Set(build());
	}

	
	@Override
	public String getCommand() {
		return " vision-web-password";
	}
}