package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.date;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * 
 * @author Izik Penso
 */

public class Date extends Builder{

	public Date(String prefix) {
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
		return " date";
	}
}