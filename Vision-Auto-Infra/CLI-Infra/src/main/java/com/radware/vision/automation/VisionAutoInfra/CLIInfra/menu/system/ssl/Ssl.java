package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Create;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Import;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl.Show;

/**
 * 
 * @author Hadar Elbaz
 */

public class Ssl extends Builder{

	public Ssl(String prefix) {
		super(prefix);
	}
	
	public Show show(){
		return new Show(build());
	}

	public Import import1(){
		return new Import(build());
	}
	
	public Create create(){
		return new Create(build());
	}
	
	@Override
	public String getCommand() {
		return " ssl";
	}
}