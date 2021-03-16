package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.Password;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.authenticationmode.AuthenticationMode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.cliaccess.CliAccess;

/**
 * 
 * @author Hadar Elbaz
 */

public class User extends Builder{

	public User(String prefix) {
		super(prefix);
	}
	
	public AuthenticationMode authenticationMode(){
		return new AuthenticationMode(build());
	}
	
	public CliAccess cliAccess(){
		return new CliAccess(build());
	}
	public AuthenticationMode AuthenticationMode(){
		return new AuthenticationMode(build());
	}
	
	public CliAccess CliAccess(){
		return new CliAccess(build());
	}
	
	public Password password(){
		return new Password(build());
	}
	
	@Override
	public String getCommand() {
		return " user";
	}
}