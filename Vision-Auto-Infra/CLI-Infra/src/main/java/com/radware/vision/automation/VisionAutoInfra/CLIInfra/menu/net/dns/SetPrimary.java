package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetPrimary extends Builder{

	public SetPrimary(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set primary";
	}
}
