package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat.SetHostName;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat.SetIp;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat.SetNone;

/**
 * 
 * @author Hadar Elbaz
 */

public class Nat extends Builder{

	public Nat(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}
	
	public SetHostName setHostName(){
		return new SetHostName(build());
	}
	
	public SetIp setIp(){
		return new SetIp(build());
	}
	
	public SetNone setNone(){
		return new SetNone(build());
	}
	public Set set(){
		return new Set(build());
	}
	

	@Override
	public String getCommand() {
		return " nat";
	}
	
}
