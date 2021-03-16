package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Statistics extends Builder{

	public Statistics(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " statistics";
	}
}