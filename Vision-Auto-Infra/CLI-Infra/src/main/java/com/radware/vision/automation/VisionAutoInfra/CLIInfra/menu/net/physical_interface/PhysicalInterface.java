package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.physical_interface;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * 
 * @author Hadar Elbaz
 */

public class PhysicalInterface extends Builder{

	public PhysicalInterface(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public Set set(){
		return new Set(build());
	}
	

	@Override
	public String getCommand() {
		return " physical-interface";
	}
	
}