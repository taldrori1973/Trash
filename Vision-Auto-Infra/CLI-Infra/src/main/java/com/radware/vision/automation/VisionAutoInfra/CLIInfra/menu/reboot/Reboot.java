package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.reboot;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Reboot extends Builder{

	public Reboot(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " reboot";
	}
}