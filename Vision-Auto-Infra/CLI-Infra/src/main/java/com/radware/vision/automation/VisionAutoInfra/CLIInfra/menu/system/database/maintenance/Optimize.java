package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.maintenance;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * 
 * @author Hadar Elbaz
 */
public class Optimize extends Builder{

	
	public Optimize(String prefix) {
		super(prefix);
	}
	

	@Override
	public String getCommand() {
		return " optimize";
	}
}
