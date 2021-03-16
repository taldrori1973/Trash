package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.servers;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Add extends Builder {

	public Add(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " add";
	}

}