package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.servers.Servers;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service.Service;

/**
 * 
 * @author Hadar Elbaz
 */

public class Ntp extends Builder{

	public Ntp(String prefix) {
		super(prefix);
	}
	
	public Servers servers(){
		return new Servers(build());
	}
	
	public Service service(){
		return new Service(build());
	}
	@Override
	public String getCommand() {
		return " ntp";
	}
}
