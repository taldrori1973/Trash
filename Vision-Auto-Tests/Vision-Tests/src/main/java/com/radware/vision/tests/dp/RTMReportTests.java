package com.radware.vision.tests.dp;

import com.radware.automation.tools.basetest.Reporter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;

import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import com.radware.automation.webui.webpages.dp.securitymonitoring.dashboardview.securitydashboard.SecurityDashboard;

public class RTMReportTests extends DpTestBase {

	private String StartTime;
	private String AttackCategory;
	private String Status;
	private String Risk;
	private String AttackName;
	private String SourceAddress;
	private String DestinationAddress;
	private String Policy;
	private String RadwareID;
	private String Direction;
	private String ActionType;
	private String PacketCount;
	private String Bandwidth;
	private String DeviceIP;
	private String DestinationPort;

	private String StartTimeResult;
	private String AttackCategoryResult;
	private String StatusResult;
	private String RiskResult;
	private String AttackNameResult;
	private String SourceAddressResult;
	private String DestinationAddressResult;
	private String RadwareIDResult;
	private String DirectionResult;
	private String ActionTypeResult;
	private String PacketCountResult;
	private String BandwidthResult;
	private String DeviceIPResult;
	private String DestinationPortResult;

	boolean passed = true;

	@Test
	@TestProperties(name = "Check Report", paramsInclude = { "Policy",
			"StartTime", "AttackCategory", "Status", "Risk", "AttackName",
			"SourceAddress", "DestinationAddress", "RadwareID", "Direction",
			"ActionType", "PacketCount", "Bandwidth", "DeviceIP",
			"DestinationPort" })
	public void checkReport() throws Exception {
		SecurityDashboard sd = new SecurityDashboard();
		sd.open();
		WebDriver driver = webUtils.getDriver();
		WebElement frame = driver.findElement(By
				.id("dpd-frameSecurity_Dashboard"));
		driver.switchTo().frame(frame);
		sd.tableView();
		sd.init(driver.findElement(By.className("the-table")));

		if (sd.isAttackExists(Policy)) {
			if (StartTime != null) {
				StartTimeResult = sd.getStartTimeByPolicyName(Policy);
				if (!StartTimeResult.equalsIgnoreCase(StartTime)) {
					ListenerstManager.getInstance().report(
							"FAIL : StartTime: " + StartTimeResult
									+ " but expected: " + StartTime,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (AttackCategory != null) {
				AttackCategoryResult = sd.getAttackCategoryByPolicyName(Policy);
				if (!AttackCategoryResult.equalsIgnoreCase(AttackCategory)) {
					ListenerstManager.getInstance().report(
							"FAIL : AttackCategory: " + AttackCategoryResult
									+ " but expected: " + AttackCategory,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (Status != null) {
				StatusResult = sd.getStatusByPolicyName(Policy);
				if (!StatusResult.equalsIgnoreCase(Status)) {
					ListenerstManager
							.getInstance()
							.report("FAIL : Status: " + StatusResult
									+ " but expected: " + Status, Reporter.FAIL);
					passed = false;
				}
			}
			if (Risk != null) {
				RiskResult = sd.getRiskByPolicyName(Policy);
				if (!RiskResult.equalsIgnoreCase(Risk)) {
					ListenerstManager.getInstance().report(
							"FAIL : Risk: " + RiskResult + " but expected: "
									+ Risk, Reporter.FAIL);
					passed = false;
				}
			}
			if (AttackName != null) {
				if (!AttackNameResult.equalsIgnoreCase(AttackName)) {
					ListenerstManager.getInstance().report(
							"FAIL : AttackName: " + AttackNameResult
									+ " but expected: " + AttackName,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (SourceAddress != null) {
				SourceAddressResult = sd.getSourceAddressByPolicyName(Policy);
				if (!SourceAddressResult.equalsIgnoreCase(SourceAddress)) {
					ListenerstManager.getInstance().report(
							"FAIL : SourceAddress: " + SourceAddressResult
									+ " but expected: " + SourceAddress,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (DestinationAddress != null) {
				DestinationAddressResult = sd
						.getDestinationAddressByPolicyName(Policy);
				if (!DestinationAddressResult.equalsIgnoreCase(DestinationAddress)) {
					ListenerstManager.getInstance().report(
							"FAIL : DestinationAddress: "
									+ DestinationAddressResult
									+ " but expected: " + DestinationAddress,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (RadwareID != null) {
				RadwareIDResult = sd.getRadwareIDByPolicyName(Policy);
				if (!RadwareIDResult.equalsIgnoreCase(RadwareID)) {
					ListenerstManager.getInstance().report(
							"FAIL : RadwareID: " + RadwareIDResult
									+ " but expected: " + RadwareID,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (Direction != null) {
				DirectionResult = sd.getDirectionByPolicyName(Policy);
				if (!DirectionResult.equalsIgnoreCase(Direction)) {
					ListenerstManager.getInstance().report(
							"FAIL : Direction: " + DirectionResult
									+ " but expected: " + Direction,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (ActionType != null) {
				ActionTypeResult = sd.getActionTypeByPolicyName(Policy);
				if (!ActionTypeResult.equalsIgnoreCase(ActionType)) {
					ListenerstManager.getInstance().report(
							"FAIL : ActionType: " + ActionTypeResult
									+ " but expected: " + ActionType,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (PacketCount != null) {
				PacketCountResult = sd.getPacketCountByPolicyName(Policy);
				if (!PacketCountResult.equalsIgnoreCase(PacketCount)) {
					ListenerstManager.getInstance().report(
							"FAIL : PacketCount: " + PacketCountResult
									+ " but expected: " + PacketCount,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (Bandwidth != null) {
				BandwidthResult = sd.getBandwidthByPolicyName(Policy);
				if (!BandwidthResult.equalsIgnoreCase(Bandwidth)) {
					ListenerstManager.getInstance().report(
							"FAIL : Bandwidth: " + BandwidthResult
									+ " but expected: " + Bandwidth,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (DeviceIP != null) {
				DeviceIPResult = sd.getDeviceIPByPolicyName(Policy);
				if (!DeviceIPResult.equalsIgnoreCase(DeviceIP)) {
					ListenerstManager.getInstance().report(
							"FAIL : DeviceIP: " + DeviceIPResult
									+ " but expected: " + DeviceIP,
							Reporter.FAIL);
					passed = false;
				}
			}
			if (DestinationPort != null) {
				DestinationPortResult = sd
						.getDestinationPortByPolicyName(Policy);
				if (!DestinationPortResult.equalsIgnoreCase(DestinationPort)) {
					ListenerstManager.getInstance().report(
							"FAIL : DestinationPort: " + DestinationPortResult
									+ " but expected: " + DestinationPort,
							Reporter.FAIL);
					passed = false;
				}
			}

		} else {
			ListenerstManager.getInstance().report(
					"FAIL : Attack with the given Policy does not exist!",
					Reporter.FAIL);
			passed = false;
		}

		if (passed) {
			if (Policy != null)
				ListenerstManager.getInstance().report(
						"Pass : Attack with the given Policy Exists");
			if (StartTime != null)
				ListenerstManager.getInstance().report(
						"Pass : StartTime : " + StartTime + " expected: "
								+ StartTimeResult);
			if (AttackCategory != null)
				ListenerstManager.getInstance().report(
						"Pass : AttackCategory : " + AttackCategory
								+ " expected: " + AttackCategoryResult);
			if (Status != null)
				ListenerstManager.getInstance().report(
						"Pass : Status : " + Status + " expected: "
								+ StatusResult);
			if (Risk != null)
				ListenerstManager.getInstance().report(
						"Pass : Risk : " + Risk + " expected: " + RiskResult);
			if (AttackName != null)
				ListenerstManager.getInstance().report(
						"Pass : AttackName : " + AttackName + " expected: "
								+ AttackNameResult);
			if (SourceAddress != null)
				ListenerstManager.getInstance().report(
						"Pass : SourceAddress : " + SourceAddress
								+ " expected: " + SourceAddressResult);
			if (DestinationAddress != null)
				ListenerstManager.getInstance().report(
						"Pass : DestinationAddress : " + DestinationAddress
								+ " expected: " + DestinationAddressResult);
			if (RadwareID != null)
				ListenerstManager.getInstance().report(
						"Pass : RadwareID : " + RadwareID + " expected: "
								+ RadwareIDResult);
			if (Direction != null)
				ListenerstManager.getInstance().report(
						"Pass : Direction : " + Direction + " expected: "
								+ DirectionResult);
			if (ActionType != null)
				ListenerstManager.getInstance().report(
						"Pass : ActionType : " + ActionType + " expected: "
								+ ActionTypeResult);
			if (PacketCount != null)
				ListenerstManager.getInstance().report(
						"Pass : PacketCount : " + PacketCount + " expected: "
								+ PacketCountResult);
			if (Bandwidth != null)
				ListenerstManager.getInstance().report(
						"Pass : Bandwidth : " + Bandwidth + " expected: "
								+ BandwidthResult);
			if (DeviceIP != null)
				ListenerstManager.getInstance().report(
						"Pass : DeviceIP : " + DeviceIP + " expected: "
								+ DeviceIPResult);
			if (DestinationPort != null)
				ListenerstManager.getInstance().report(
						"Pass : DestinationPort : " + DestinationPort
								+ " expected: " + DestinationPortResult);
		}

	}

	public String getStartTime() {
		return StartTime;
	}

	public void setStartTime(String startTime) {
		StartTime = startTime;
	}

	public String getAttackCategory() {
		return AttackCategory;
	}

	public void setAttackCategory(String attackCategory) {
		AttackCategory = attackCategory;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}

	public String getRisk() {
		return Risk;
	}

	public void setRisk(String risk) {
		Risk = risk;
	}

	public String getAttackName() {
		return AttackName;
	}

	public void setAttackName(String attackName) {
		AttackName = attackName;
	}

	public String getSourceAddress() {
		return SourceAddress;
	}

	public void setSourceAddress(String sourceAddress) {
		SourceAddress = sourceAddress;
	}

	public String getDestinationAddress() {
		return DestinationAddress;
	}

	public void setDestinationAddress(String destinationAddress) {
		DestinationAddress = destinationAddress;
	}

	public String getPolicy() {
		return Policy;
	}

	public void setPolicy(String policy) {
		Policy = policy;
	}

	public String getRadwareID() {
		return RadwareID;
	}

	public void setRadwareID(String radwareID) {
		RadwareID = radwareID;
	}

	public String getDirection() {
		return Direction;
	}

	public void setDirection(String direction) {
		Direction = direction;
	}

	public String getActionType() {
		return ActionType;
	}

	public void setActionType(String actionType) {
		ActionType = actionType;
	}

	public String getPacketCount() {
		return PacketCount;
	}

	public void setPacketCount(String packetCount) {
		PacketCount = packetCount;
	}

	public String getBandwidth() {
		return Bandwidth;
	}

	public void setBandwidth(String bandwidth) {
		Bandwidth = bandwidth;
	}

	public String getDeviceIP() {
		return DeviceIP;
	}

	public void setDeviceIP(String deviceIP) {
		DeviceIP = deviceIP;
	}

	public String getDestinationPort() {
		return DestinationPort;
	}

	public void setDestinationPort(String destinationPort) {
		DestinationPort = destinationPort;
	}

}
