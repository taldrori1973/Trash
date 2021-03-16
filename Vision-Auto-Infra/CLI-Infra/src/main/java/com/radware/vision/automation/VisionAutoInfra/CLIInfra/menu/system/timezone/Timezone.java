package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.timezone;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * 
 * @author Hadar Elbaz
 */

public class Timezone extends Builder{

	public Timezone(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public Set set(){
		return new Set(build());
	}
	
	public List list(){
		return new List(build());
	}

	
	@Override
	public String getCommand() {
		return " timezone";
	}
}