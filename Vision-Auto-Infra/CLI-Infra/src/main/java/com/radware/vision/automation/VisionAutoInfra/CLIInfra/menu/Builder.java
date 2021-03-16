package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu;

/**
 * 
 * @author Liel Ran
 */

public abstract class Builder {

	public String prefix;
	public String command;

	public Builder(String prefix) {
		this.prefix = prefix;

	}
	public abstract String getCommand();

	public String build() {
		return prefix + getCommand();
	}
	
	public String getPrefix() {
		return prefix;
	}
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	public void setCommand(String command) {
		this.command = command;
	}

}
