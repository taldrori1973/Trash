package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.dns.Dns;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.firewall.Firewall;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.ip.Ip;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.nat.Nat;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.physical_interface.PhysicalInterface;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.net.route.Route;

/**
 * 
 * @author Hadar Elbaz
 */

public class Net extends Builder{

	public Net(String prefix) {
		super(prefix);
	}
	
	public Ip ip(){
		return new Ip(build());
	}
	
	public Route route(){
		return new Route(build());
	}
	
	public Dns dns(){
		return new Dns(build());
	}
	
	public Firewall firewall() {
		return new Firewall(build());
	}
	
	public Nat nat(){
		return new Nat(build());
	}
	
	public PhysicalInterface physicalInterface(){
		return new PhysicalInterface(build());
	}

	@Override
	public String getCommand() {
		return " net";
	}
}
