package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.access;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Revoke extends Builder{
	
	public Revoke(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " revoke";
	}
}