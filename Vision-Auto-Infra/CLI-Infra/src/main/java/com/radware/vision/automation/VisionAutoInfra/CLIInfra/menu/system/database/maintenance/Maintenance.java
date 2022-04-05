package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.maintenance;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;


/**
 * 
 * @author OrG
 */

public class Maintenance extends Builder{
		
		public Maintenance(String prefix) {
			super(prefix);
		}
		
		public Driver_Table driver_table(){
			return new Driver_Table(build());
		}
		
		public Optimize optimize(){
			return new Optimize(build());
		}

		@Override
		public String getCommand() {
			return " maintenance";
		}
	
}
