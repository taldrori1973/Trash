package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.backup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Local extends Builder{

	public Local(String prefix) {
		super(prefix);
	}
	
	
	@Override
	public String getCommand() {
		return " local";
	}
}