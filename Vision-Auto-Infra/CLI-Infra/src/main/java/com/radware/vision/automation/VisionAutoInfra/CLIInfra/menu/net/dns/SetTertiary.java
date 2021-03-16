package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class SetTertiary extends Builder{

	public SetTertiary(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " set tertiary";
	}
}
