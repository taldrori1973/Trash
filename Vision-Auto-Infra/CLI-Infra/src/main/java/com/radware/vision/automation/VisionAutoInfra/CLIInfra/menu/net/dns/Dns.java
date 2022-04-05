package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns.*;

/**
 * 
 * @author Hadar Elbaz
 */

public class Dns extends Builder{
	
	public Dns(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public Set set(){
		return new Set(build());
	}
	
	public SetPrimary setPrimary(){
		return new SetPrimary(build());
	}
	
	public DeletePrimary deletePrimary(){
		return new DeletePrimary(build());
	}
	
	public SetSecondary setSecondary(){
		return new SetSecondary(build());
	}
	
	public DeleteSecondary deleteSecondary(){
		return new DeleteSecondary(build());
	}
	
	public SetTertiary setTertiary(){
		return new SetTertiary(build());
	}
	
	public DeleteTertiary deleteTertiary(){
		return new DeleteTertiary(build());
	}

	@Override
	public String getCommand() {
		return " dns";
	}

}
