package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/** 
 * 
 * @author izikp
 *
 */
public class ClientRadware extends Builder{

	public ClientRadware(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " client-radware";
	}
}