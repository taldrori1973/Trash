package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/** 
 * 
 * @author izikp
 *
 */
public class Radware extends Builder{

	public Radware(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " radware";
	}
}