package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.authenticationmode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

public class AuthenticationMode extends Builder {
	
	public AuthenticationMode(String prefix) {
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
		return " authentication-mode";
	}
}
