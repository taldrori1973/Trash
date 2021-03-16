package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl.Pem;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl.Pkcs12;


/**
 * 
 * @author Hadar Elbaz
 */

public class Import extends Builder{
	
	public Import(String prefix) {
		super(prefix);
	}
	
	public Pkcs12 pkcs12(){
		return new Pkcs12(build());
	}
	
	public Pem pem(){
		return new Pem(build());
	}

	@Override
	public String getCommand() {
		return " import";
	}
}