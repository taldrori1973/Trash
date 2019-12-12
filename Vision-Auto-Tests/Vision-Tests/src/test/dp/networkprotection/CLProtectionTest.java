package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionlimitprofiles.connectionlimitprotections.ConnectionLimitProtections;
import com.radware.products.defensepro.defensepro.DefenseProEnums.ConnLimitActionMode;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class CLProtectionTest extends DpTestBase {

	public enum SuspendAction {
		None, SrcIP, SrcIP_DestIP, SrcIP_DestPort, SrcIP_DestIP_DestPort, SrcIP_DestIP_SrcPort_DestPort;

		public String getName() {
			switch (this) {
			case None:
				return "None";
			case SrcIP:
				return "Source Ip";
			case SrcIP_DestIP:
				return "Source IP + Destination IP";
			case SrcIP_DestPort:
				return "Source IP + Destination Port";
			case SrcIP_DestIP_DestPort:
				return "Source IP + Destination IP and Port";
			case SrcIP_DestIP_SrcPort_DestPort:
				return "Source IP and Port + Destination IP and Port";
			default:
				return name();
			}
		}

		public String toString() {
			return getName();
		}
	}

	public enum TrackingType {
		Source_Count, Target_Count, Source_and_Target_Count;

		public String getName(){
			switch(this){
			case Source_Count:
				return "Source Count";
			case Target_Count:
				return "Target Count";
			case Source_and_Target_Count:
				return "Source and Target Count";
			default:
				return name();
			}
		}
		
		public String toString () {
			return getName ();
		}

	}
	
	
	enum Protocol {
		TCP, UDP
	}
	
	public enum Risk {
		Info, Low, Medium, High;
	}
	
	public enum ActionMode{
		Report_Only, Drop, Reset_Source;
	
		public String getName(){
			switch(this){
			case Report_Only:
				return "Report Only";
			case Drop:
				return "Drop";
			case Reset_Source:
				return "Reset Source";
			default:
				return name();
			}
		}
		
		public String toString () {
			return getName ();
		}


	}

	private String protectionName;
	private String applicationPortGroupName;
	private Protocol protocol;
	private String numberOfConnections;
	private TrackingType trackingType;
	private ActionMode actionMode;
	private Risk risk;
	private SuspendAction suspendAction;
	private DpStatus packetReport;
	private DpStatus packetTrace;

	@Test
    @TestProperties(name = "Create Connection Limit Protection", paramsInclude = {"qcTestId", "deviceName", "protectionName", "applicationPortGroupName", "protocol",
			"numberOfConnections", "trackingType", "actionMode", "risk", "suspendAction", "packetReport", "packetTrace" })
	public void createConnectionLimitProtection() throws Exception {
		ConnectionLimitProtections clProtection = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles()
				.mConnectionLimitProtections();

		clProtection.openPage();
		clProtection.addConnectionLimitProtections();
		clProtection.setProtectionName(protectionName);
		if (applicationPortGroupName != null) {
			clProtection.selectApplicationPortGroupName(applicationPortGroupName);
		}
		if (protocol != null) {
			clProtection.selectProtocol(protocol.toString());
		}
		if (numberOfConnections != null) {
			clProtection.setNumberofConnections(numberOfConnections);
		}
		if (trackingType != null) {
			clProtection.selectTrackingType(trackingType.toString());
		}
		if (actionMode != null) {
			if (actionMode.equals(ConnLimitActionMode.Reset_Source)) {
				clProtection.selectActionMode("Send Reset to Source");
			} else {
				clProtection.selectActionMode(actionMode.toString());
			}
		}
		if (risk != null) {
			clProtection.selectRisk(risk.toString());
		}
		if (suspendAction != null) {
			clProtection.selectSuspendAction(suspendAction.toString());
		}
		if (packetReport.equals(DpStatus.disable)) {
			clProtection.disablePacketReport();
		}
		if (packetReport.equals(DpStatus.enable)) {
			clProtection.enablePacketReport();
		}
		if (packetTrace.equals(DpStatus.disable)) {
			clProtection.disablePacketTrace();
		}
		if (packetTrace.equals(DpStatus.enable)) {
			clProtection.enablePacketTrace();
		}
		clProtection.submit();
	}

	
	@Test
    @TestProperties(name = "Delete Connection Limit Protection", paramsInclude = {"qcTestId", "deviceName", "protectionName"})
	public void deleteConnectionLimitProtection() throws Exception {
		ConnectionLimitProtections clProtection = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles()
		.mConnectionLimitProtections();
		clProtection.openPage();
		clProtection.deleteConnectionLimitProtectionsByKeyValue("Protection Name", protectionName);
	}
	
	
	
	public String getProtectionName() {
		return protectionName;
	}

	public void setProtectionName(String protectionName) {
		this.protectionName = protectionName;
	}

	public String getApplicationPortGroupName() {
		return applicationPortGroupName;
	}

	public void setApplicationPortGroupName(String applicationPortGroupName) {
		this.applicationPortGroupName = applicationPortGroupName;
	}

	public Protocol getProtocol() {
		return protocol;
	}

	public void setProtocol(Protocol protocol) {
		this.protocol = protocol;
	}

	public String getNumberOfConnections() {
		return numberOfConnections;
	}

	public void setNumberOfConnections(String numberOfConnections) {
		this.numberOfConnections = numberOfConnections;
	}

	public TrackingType getTrackingType() {
		return trackingType;
	}

	public void setTrackingType(TrackingType trackingType) {
		this.trackingType = trackingType;
	}

	public ActionMode getActionMode() {
		return actionMode;
	}

	public void setActionMode(ActionMode actionMode) {
		this.actionMode = actionMode;
	}

	public Risk getRisk() {
		return risk;
	}

	public void setRisk(Risk risk) {
		this.risk = risk;
	}

	public SuspendAction getSuspendAction() {
		return suspendAction;
	}

	public void setSuspendAction(SuspendAction suspendAction) {
		this.suspendAction = suspendAction;
	}

	public DpStatus getPacketReport() {
		return packetReport;
	}

	public void setPacketReport(DpStatus packetReport) {
		this.packetReport = packetReport;
	}

	public DpStatus getPacketTrace() {
		return packetTrace;
	}

	public void setPacketTrace(DpStatus packetTrace) {
		this.packetTrace = packetTrace;
	}
	
}
