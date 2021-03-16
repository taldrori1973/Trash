package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.exit.Exit;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.help.Help;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.history.History;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.Net;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.ping.Ping;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.reboot.Reboot;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.shutdown.Shutdown;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.System;

/**
 * 
 * @author Hadar Elbaz
 */

public class Menu {

	private Menu(){	
	}
	
	public static Exit exit(){
		return new Exit("");
	}
	
	public static Help help(){
		return new Help("");
	}

	public static History history(){
		return new History("");
	}
	
	public static Net net(){
		return new Net("");
	}
	
	public static Ping ping(){
		return new Ping("");
	}
	
	public static Reboot reboot(){
		return new Reboot("");
	}
	
	public static Shutdown shutdown(){
		return new Shutdown("");
	}
	
	public static System system(){
		return new System("");
	}
}
