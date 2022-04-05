package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.backup.Backup;


/**
 * 
 * @author Hadar Elbaz
 */

public class Storage extends Builder{

	public Storage(String prefix) {
		super(prefix);
	}
	
	public Get get(){
		return new Get(build());
	}

	public Backup backup(){
		return new Backup(build());
	}
	
	@Override
	public String getCommand() {
		return " storage";
	}
}