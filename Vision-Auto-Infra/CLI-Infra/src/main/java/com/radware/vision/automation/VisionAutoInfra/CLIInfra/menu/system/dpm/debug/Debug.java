package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.*;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.database.Database;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.install.Install;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.sample.Sample;

/**
 * 	 * 
 * @author Izik Penso
 */

public class Debug extends Builder{
	
	public Debug(String prefix) {
		super(prefix);
	}

	
	public Database database(){
		return new Database(build());
	}
	
	public Install install(){
		return new Install(build());
	}
	
	public Sample sample(){
		return new Sample(build());
	}
	
	public Start start(){
		return new Start(build());
	}
	
	public Stop stop(){
		return new Stop(build());
	}
	
	public Status status(){
		return new Status(build());
	}
	
	public Version version(){
		return new Version(build());
	}
	
	public Debug debug(){
		return new Debug(build());
	}
	
	public Create create(){
		return new Create(build());
	}
	
	@Override
	public String getCommand() {
		return " debug";
	}


}
