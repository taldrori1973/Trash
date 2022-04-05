package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.tcp_dump;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Print extends Builder{

	public Print(String prefix) {
		super(prefix);
	}
	
	
	@Override
	public String getCommand() {
		return " print";
	}
}