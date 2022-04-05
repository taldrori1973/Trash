package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetDefault extends Builder{

	public SetDefault(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set default";
	}
}