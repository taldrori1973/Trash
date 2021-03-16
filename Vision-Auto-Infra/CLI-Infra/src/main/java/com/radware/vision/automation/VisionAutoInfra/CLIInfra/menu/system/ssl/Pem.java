package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * @author org
 * */
public class Pem extends Builder{

	public Pem(String prefix) {
		super(prefix);
	}
	
	public String getCommand() {
		return " pem";
	}
}