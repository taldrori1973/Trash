package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.servers;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;

/**
 * 
 * @author Hadar Elbaz
 */

public class Servers extends Builder{

	public Servers(String prefix) {
		super(prefix);
	}
	
	public Del del(){
		return new Del(build());
	}
	
	public Delete delete(){
		return new Delete(build());
	}
	
	public Add add(){
		return new Add(build());
	}
	
	public Get get(){
		return new Get(build());
	}
	
	@Override
	public String getCommand() {
		return " servers";
	}
}