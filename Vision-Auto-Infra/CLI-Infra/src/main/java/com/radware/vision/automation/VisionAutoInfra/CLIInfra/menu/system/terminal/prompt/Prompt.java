package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal.prompt;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

public class Prompt extends Builder {
	
	public Prompt(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}

	public Set set() {
		return new Set(build());
	}

	@Override
	public String getCommand() {
		return " prompt";
	}
}
