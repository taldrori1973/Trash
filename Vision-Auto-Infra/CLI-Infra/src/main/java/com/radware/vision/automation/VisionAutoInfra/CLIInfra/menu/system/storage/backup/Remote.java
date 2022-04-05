package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.backup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Remote extends Builder{

	public Remote(String prefix) {
		super(prefix);
	}
	
	
	@Override
	public String getCommand() {
		return " remote";
	}
}