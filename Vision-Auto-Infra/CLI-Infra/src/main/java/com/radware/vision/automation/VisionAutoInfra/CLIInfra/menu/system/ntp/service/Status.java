package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * @author org
 * */
public class Status extends Builder{

	public Status(String prefix) {
		super(prefix);
	}

	@Override
	public String getCommand() {
		return " status";
	}

}
