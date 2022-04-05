package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal.banner;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Update;

public class Banner extends Builder {
	
	public Banner(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}

	public Update update() {
		return new Update(build());
	}

	@Override
	public String getCommand() {
		return " banner";
	}
}
