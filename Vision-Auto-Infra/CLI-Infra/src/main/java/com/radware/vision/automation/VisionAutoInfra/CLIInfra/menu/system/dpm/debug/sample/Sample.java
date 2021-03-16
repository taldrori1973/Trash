package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.sample;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.*;

/**
 * 
 * @author Izik Penso
 */

public class Sample extends Builder{

	public Sample(String prefix) {
		super(prefix);
	}
	
	public Create create(){
		return new Create(build());
	}
	
	public Delete delete(){
		return new Delete(build());
	}
	
	public List list(){
		return new List(build());
	}
	
	public Export export(){
		return new Export(build());
	}

	
	@Override
	public String getCommand() {
		return " sample";
	}
}
