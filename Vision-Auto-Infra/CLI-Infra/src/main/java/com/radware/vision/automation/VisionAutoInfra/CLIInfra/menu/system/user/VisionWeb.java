package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/** 
 * 
 * @author izikp
 *
 */
public class VisionWeb extends Builder{

	public VisionWeb(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " vision-web";
	}
}
