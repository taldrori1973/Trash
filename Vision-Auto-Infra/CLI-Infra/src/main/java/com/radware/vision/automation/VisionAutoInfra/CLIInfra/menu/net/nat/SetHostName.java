package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetHostName extends Builder{
	
	public SetHostName(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set hostname";
	}
}