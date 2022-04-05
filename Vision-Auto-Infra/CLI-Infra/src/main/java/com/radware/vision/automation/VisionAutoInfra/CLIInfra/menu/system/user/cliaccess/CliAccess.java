package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.cliaccess;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Add;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.List;

public class CliAccess extends Builder {
	
	public CliAccess(String prefix) {
		super(prefix);
	}
	
	public Add add(){
		return new Add(build());
	}
	
	public Delete delete(){
		return new Delete(build());
	}
	
	public List list(){
		return new List(build());
	}

	@Override
	public String getCommand() {
		return " cli-access";
	}
}
