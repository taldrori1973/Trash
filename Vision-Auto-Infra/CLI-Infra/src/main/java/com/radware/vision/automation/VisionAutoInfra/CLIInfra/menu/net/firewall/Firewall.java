package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.openport.OpenPort;

public class Firewall extends Builder {
	
	public Firewall(String prefix) {
		super(prefix);
	}

	public OpenPort openport() {
		return new OpenPort(build());
	}
	
	@Override
	public String getCommand() {
		return " firewall";
	}

}
