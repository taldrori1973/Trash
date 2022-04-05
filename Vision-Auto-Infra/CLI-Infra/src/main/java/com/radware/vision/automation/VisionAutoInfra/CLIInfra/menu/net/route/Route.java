package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route.SetDefault;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route.SetHost;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route.SetNet;

/**
 * 
 * @author Hadar Elbaz
 */

public class Route extends Builder{

	public Route(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public Delete delete(){
		return new Delete(build());
	}
	
	public SetHost setHost(){
		return new SetHost(build());
	}
	
	public SetNet setNet(){
		return new SetNet(build());
	}
	
	public SetDefault setDefault(){
		return new SetDefault(build());
	}
	
	public Set set(){
		return new Set(build());
	}

	@Override
	public String getCommand() {
		return " route";
	}
}