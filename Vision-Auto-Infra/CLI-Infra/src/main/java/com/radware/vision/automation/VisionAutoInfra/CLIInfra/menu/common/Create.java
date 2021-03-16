package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.backup.Remote;


/**
 * 
 * @author Hadar Elbaz
 */

public class Create extends Builder{
	
	public Create(String prefix) {
		super(prefix);
	}
	
	public Remote remote(){
		return new Remote(build());
	}

	@Override
	public String getCommand() {
		return " create";
	}
}