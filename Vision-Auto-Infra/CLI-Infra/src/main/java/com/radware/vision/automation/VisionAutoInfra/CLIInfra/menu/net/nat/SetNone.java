package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetNone extends Builder{
	
	public SetNone(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set none";
	}
}