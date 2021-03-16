package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/** 
 * 
 * @author izikp
 *
 */
public class VisionTech extends Builder{

	public VisionTech(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " vision-tech";
	}
}
