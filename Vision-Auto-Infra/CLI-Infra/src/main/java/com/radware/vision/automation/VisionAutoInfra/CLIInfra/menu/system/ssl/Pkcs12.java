package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
/**
 * @author org
 * */
public class Pkcs12 extends Builder{

	public Pkcs12(String prefix) {
		super(prefix);
	}
	
	public String getCommand() {
		return " pkcs12";
	}
}