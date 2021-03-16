package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password.Change;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password.Root;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password.VisionFiles;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.password.VisionTech;

/** 
 * 
 * @author izikp
 *
 */
public class Password extends Builder{

	public Password(String prefix) {
		super(prefix);
	}
	
	public Change change(){
		return new Change(build());
	}
	
	public Root root(){
		return new Root(build());
	}
	
	public VisionFiles visionFiles(){
		return new VisionFiles(build());
	}
	
	public VisionTech visionTech(){
		return new VisionTech(build());
	}
	
	@Override
	public String getCommand() {
		return " password";
	}
}