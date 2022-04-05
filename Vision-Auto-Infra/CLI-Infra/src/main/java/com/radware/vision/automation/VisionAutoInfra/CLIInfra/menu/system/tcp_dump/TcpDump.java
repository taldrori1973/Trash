package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.tcp_dump;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Export;

/**
 * 
 * @author Hadar Elbaz
 */

public class TcpDump extends Builder{

	public TcpDump(String prefix) {
		super(prefix);
	}
	
	public Export export(){
		return new Export(build());
	}
	
	public Print print(){
		return new Print(build());
	}
	
	@Override
	public String getCommand() {
		return " tcpdump";
	}
}
