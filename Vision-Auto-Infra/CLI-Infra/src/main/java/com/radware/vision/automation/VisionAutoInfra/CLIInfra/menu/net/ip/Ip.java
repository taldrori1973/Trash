package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.ip;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.ip.ManagementSet;

/**
 * 
 * @author Hadar Elbaz
 */

public class Ip extends Builder{

	public Ip(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public Delete delete(){
		return new Delete(build());
	}
	
	public ManagementSet managementSet(){
		return new ManagementSet(build());
	}
	
	public Management management(){
		return new Management(build());
	}
	
	public Set set(){
		return new Set(build());
	}

	@Override
	public String getCommand() {
		return " ip";
	}
	
}
