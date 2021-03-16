package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal.banner.Banner;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal.prompt.Prompt;

public class Terminal extends Builder {

	public Terminal(String prefix) {
		super(prefix);
	}
	
	public Banner banner() {
		return new Banner(build());
	}
	
	public Prompt prompt() {
		return new Prompt(build());
	}
	
	@Override
	public String getCommand() {
		return " terminal";
	}

}
