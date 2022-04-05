package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetIp extends Builder{
	
	public SetIp(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set ip";
	}
}