package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * @author org
 * */
public class Stop extends Builder {

	public Stop(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " stop";
	}

}
