package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetHost extends Builder {

	public SetHost(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set host";
	}

}
