package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.backup.Backup;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.database.Database;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.debug.Debug;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.techSupport.TechSupport;



	/**
	 * 	 * 
	 * @author Izik Penso
	 */

	public class Dpm extends Builder{

		public Dpm(String prefix) {
			super(prefix);
		}
		
		public Debug debug(){
			return new Debug(build());
		}
		
		public Backup backup(){
			return new Backup(build());
		}
		
		public Database database(){
			return new Database(build());
		}
		
		public TechSupport techsupport(){
			return new TechSupport(build());
		}
/*		
		public Dpm dpm(){
			return new Dpm(build());
		}*/
		
		@Override
		public String getCommand() {
			return " dpm";
		}

}
