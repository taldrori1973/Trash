package com.radware.vision.tests.dp.serverprotection;

import com.radware.automation.webui.webpages.dp.configuration.serverprotection.serverprotectionpolicy.ServerProtectionPolicy;
import com.radware.automation.webui.webpages.dp.enums.ProtectionPoliciesDeleteOptions;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class ServerProtectionTest extends DpTestBase {

	private String ServerName;
	private String HTTPFloodProfile;
	private String ServerCrackingProfile;
	private String IPRange;
	private String VLANTagGroup;
	private String Policy;


	private DpStatus enable;
	private DpStatus PacketReporting;
	private DpStatus PacketReportingPrecedence;
	private DpStatus PacketTrace;
	private DpStatus PacketTracePrecedence;

	
	@Test
    @TestProperties(name = "Delete server protection", paramsInclude = {"qcTestId", "deviceName", "ServerName"})
	public void deleteServerProtection() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
		ServerProtectionPolicy serverProtectionPolicy = dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
		serverProtectionPolicy.openPage();
		serverProtectionPolicy.deleteServerProtectionPolicy("Server Name", ServerName);
	}

    @Test
    @TestProperties(name = "Delete All server protection", paramsInclude = {"qcTestId", "deviceName"})
    public void deleteAllServerProtection() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), true);
        ServerProtectionPolicy serverProtectionPolicy = dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        serverProtectionPolicy.openPage();
        serverProtectionPolicy.deleteAllServerProtectionPolicy(ProtectionPoliciesDeleteOptions.POLICIES_ONLY);
    }
	
	
	@Test
    @TestProperties(name = "Create server protection", paramsInclude = {"qcTestId", "deviceName", "ServerName", "enable", "HTTPFloodProfile", "ServerCrackingProfile",
			"IPRange", "VLANTagGroup", "Policy","PacketReporting", "PacketReportingPrecedence", "PacketTrace", "PacketTracePrecedence", })
	public void createServerProtection() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
		ServerProtectionPolicy serverProtectionPolicy = dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
		serverProtectionPolicy.openPage();
		serverProtectionPolicy.addServerProtectionPolicy();
		
		serverProtectionPolicy.setServerName(ServerName);

		if (enable != null) {
			if (enable.equals(DpStatus.enable)) {
				serverProtectionPolicy.enable();
			}
			if (enable.equals(DpStatus.disable)) {
				serverProtectionPolicy.disable();
			}
		}

		if (HTTPFloodProfile != null) {
			serverProtectionPolicy.selectHTTPFloodProfile(HTTPFloodProfile);
		}
		if (ServerCrackingProfile != null) {
			serverProtectionPolicy.selectServerCrackingProfile(ServerCrackingProfile);
		}

		serverProtectionPolicy.selectPolicy(Policy);
		
		if (PacketReporting != null) {
			if (PacketReporting.equals(DpStatus.enable)) {
				serverProtectionPolicy.enablePacketReporting();
			}
			if (PacketReporting.equals(DpStatus.disable)) {
				serverProtectionPolicy.disablePacketReporting();
			}
		}

		serverProtectionPolicy.selectIPRange(IPRange);
		if (VLANTagGroup != null) {
			serverProtectionPolicy.selectVLANTagGroup(VLANTagGroup);
		}

		if (PacketReportingPrecedence != null) {
			if (PacketReportingPrecedence.equals(DpStatus.enable)) {
				serverProtectionPolicy.enablePacketReportingPrecedence();
			}
			if (PacketReportingPrecedence.equals(DpStatus.disable)) {
				serverProtectionPolicy.disablePacketReportingPrecedence();
			}

		}

		if (PacketTrace != null) {
			if (PacketTrace.equals(DpStatus.enable)) {
				serverProtectionPolicy.enablePacketTrace();
			}
			if (PacketTrace.equals(DpStatus.disable)) {
				serverProtectionPolicy.disablePacketTrace();
			}
		}

		if (PacketTracePrecedence != null) {
			if (PacketTracePrecedence.equals(DpStatus.enable)) {
				serverProtectionPolicy.enablePacketTracePrecedence();
			}
			if (PacketTracePrecedence.equals(DpStatus.disable)) {
				serverProtectionPolicy.disablePacketReportingPrecedence();
			}
		}

		serverProtectionPolicy.submit();
	}

	public String getServerName() {
		return ServerName;
	}

	public void setServerName(String serverName) {
		ServerName = serverName;
	}

	public String getHTTPFloodProfile() {
		return HTTPFloodProfile;
	}

	public void setHTTPFloodProfile(String hTTPFloodProfile) {
		HTTPFloodProfile = hTTPFloodProfile;
	}

	public String getServerCrackingProfile() {
		return ServerCrackingProfile;
	}

	public void setServerCrackingProfile(String serverCrackingProfile) {
		ServerCrackingProfile = serverCrackingProfile;
	}

	public String getIPRange() {
		return IPRange;
	}

	public void setIPRange(String iPRange) {
		IPRange = iPRange;
	}

	public String getVLANTagGroup() {
		return VLANTagGroup;
	}

	public void setVLANTagGroup(String vLANTagGroup) {
		VLANTagGroup = vLANTagGroup;
	}

	public DpStatus getEnable() {
		return enable;
	}

	public void setEnable(DpStatus enable) {
		this.enable = enable;
	}

	public DpStatus getPacketReporting() {
		return PacketReporting;
	}

	public void setPacketReporting(DpStatus packetReporting) {
		PacketReporting = packetReporting;
	}

	public DpStatus getPacketReportingPrecedence() {
		return PacketReportingPrecedence;
	}

	public void setPacketReportingPrecedence(DpStatus packetReportingPrecedence) {
		PacketReportingPrecedence = packetReportingPrecedence;
	}

	public DpStatus getPacketTrace() {
		return PacketTrace;
	}

	public void setPacketTrace(DpStatus packetTrace) {
		PacketTrace = packetTrace;
	}

	public DpStatus getPacketTracePrecedence() {
		return PacketTracePrecedence;
	}

	public void setPacketTracePrecedence(DpStatus packetTracePrecedence) {
		PacketTracePrecedence = packetTracePrecedence;
	}

	public String getPolicy() {
		return Policy;
	}


	public void setPolicy(String policy) {
		Policy = policy;
	}


}
