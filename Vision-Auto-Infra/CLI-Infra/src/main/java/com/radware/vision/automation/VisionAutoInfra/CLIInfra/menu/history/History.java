package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.history;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class History extends Builder{

	public History(String prefix) {
		super(prefix);
	}
	
	@Override
	public String getCommand() {
		return " history";
	}
}