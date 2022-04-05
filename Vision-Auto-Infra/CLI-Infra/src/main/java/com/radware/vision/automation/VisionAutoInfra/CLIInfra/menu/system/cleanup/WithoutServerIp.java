package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.cleanup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class WithoutServerIp extends Builder{

	public WithoutServerIp(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " without-server-ip";
	}
}