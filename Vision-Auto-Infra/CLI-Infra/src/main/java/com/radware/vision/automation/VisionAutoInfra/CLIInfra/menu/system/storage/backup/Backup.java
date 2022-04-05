package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.backup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Info;

/**
 * 
 * @author Hadar Elbaz
 */

public class Backup extends Builder{

	public Backup(String prefix) {
		super(prefix);
	}
	
	public Local local(){
		return new Local(build());
	}
	
	public Remote remote(){
		return new Remote(build());
	}
	
	public Info info(){
		return new Info(build());
	}

	
	@Override
	public String getCommand() {
		return " backup";
	}
}