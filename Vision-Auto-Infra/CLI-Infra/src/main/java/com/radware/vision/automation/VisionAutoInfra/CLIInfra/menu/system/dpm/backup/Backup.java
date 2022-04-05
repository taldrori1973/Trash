package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.backup;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.*;



/**
 * 
 * @author Izik Penso
 */

public class Backup extends Builder{

	public Backup(String prefix) {
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
	
	public Import import_(){
		return new Import(build());
	}
	public Export export(){
		return new Export(build());
	}
	
	public Restore restore(){
		return new Restore(build());
	}
	
	@Override
	public String getCommand() {
		return " backup";
	}
}
