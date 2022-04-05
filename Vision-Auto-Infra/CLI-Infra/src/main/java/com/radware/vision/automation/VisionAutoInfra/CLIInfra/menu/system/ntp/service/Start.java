package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * @author org
 * */
public class Start extends Builder{

	public Start(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " start";
	}

}
