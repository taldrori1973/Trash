package com.radware.vision.tests.dp.accesscontrol.cliaccesscontrol;

import org.junit.Before;
import org.junit.Test;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpPolicyAction;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;

public class CliBlackList extends SystemTestCase4 {
	private String BlackListName;
	private String Description;
	private String SourceNetwork;
	private String SourcePort;
	private String DestinationNetwork;
	private String DestinationPort;
	private String PhysicalPorts;
	private String VLANTag;
	private String Protocol;
	private String Direction;
	private String Action;
	DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify Black List Profile - Cli", paramsInclude = { "qcTestId", "BlackListName", "Description", "SourceNetwork", "SourcePort",
			"DestinationNetwork", "DestinationPort", "PhysicalPorts", "VLANTag", "Protocol", "Direction", "Action" })
	public void BlackListCLITest() throws Exception {

		String description = defensepro.dp.getDpBlackListDescription(BlackListName);
		String sourceNetwork = defensepro.dp.getDpBlackListSrcNetwork(BlackListName);
		String sourcePort = defensepro.dp.getDpBlackListSrcPortGroup(BlackListName);
		String destinationNetwork = defensepro.dp.getDpBlackListDstNetwork(BlackListName);
		String destinationPort = defensepro.dp.getDpBlackListDstPortGroup(BlackListName);
		String physicalPorts = defensepro.dp.getDpBlackListPhysicalPortGroup(BlackListName);
		String vLANTag = defensepro.dp.getDpBlackListVLANTag(BlackListName);
		String protocol = defensepro.dp.getDpBlackListProtocol(BlackListName);
		String direction = defensepro.dp.getDpBlackListDirection(BlackListName);
		String action = defensepro.dp.getDpBlackListAction(BlackListName);

		boolean passed = true;
		if (Description != null) {
			if (!description.equals(Description)) {
				ListenerstManager.getInstance().report("Description: " + description + " but expected: " + Description, Reporter.FAIL);
				passed = false;
			}
		}
		if (SourceNetwork != null) {
			if (!sourceNetwork.equals(SourceNetwork)) {
				ListenerstManager.getInstance().report("SourceNetwork: " + sourceNetwork + " but expected: " + SourceNetwork, Reporter.FAIL);
				passed = false;
			}
		}
		if (SourcePort != null) {
			if (!sourcePort.equals(SourcePort)) {
				ListenerstManager.getInstance().report("SourcePort: " + sourcePort + " but expected: " + SourcePort, Reporter.FAIL);
				passed = false;
			}
		}
		if (DestinationNetwork != null) {
			if (!destinationNetwork.equals(DestinationNetwork)) {
				ListenerstManager.getInstance().report("DestinationNetwork: " + destinationNetwork + " but expected: " + DestinationNetwork, Reporter.FAIL);
				passed = false;
			}
		}
		if (DestinationPort != null) {
			if (!destinationPort.equals(DestinationPort)) {
				ListenerstManager.getInstance().report("DestinationPort: " + destinationPort + " but expected: " + DestinationPort, Reporter.FAIL);
				passed = false;
			}
		}
		if (PhysicalPorts != null) {
			if (!physicalPorts.equals(PhysicalPorts)) {
				ListenerstManager.getInstance().report("PhysicalPorts: " + physicalPorts + " but expected: " + PhysicalPorts, Reporter.FAIL);
				passed = false;
			}
		}
		if (VLANTag != null) {
			if (!vLANTag.equals(VLANTag)) {
				ListenerstManager.getInstance().report("VLANTag: " + vLANTag + " but expected: " + VLANTag, Reporter.FAIL);
				passed = false;
			}
		}
		if (Protocol != null) {
			if (!protocol.equals(Protocol)) {
				ListenerstManager.getInstance().report("Protocol: " + protocol + " but expected: " + Protocol, Reporter.FAIL);
				passed = false;
			}
		}
		if (Direction != null) {
			if (!direction.equals(Direction)) {
				ListenerstManager.getInstance().report("Direction: " + direction + " but expected: " + Direction, Reporter.FAIL);
				passed = false;
			}
		}
		if (Action != null) {
			if (!action.equals(Action)) {
				ListenerstManager.getInstance().report("Action: " + action + " but expected: " + Action, Reporter.FAIL);
				passed = false;
			}
		}

		if (passed) {
			if (Description != null)
				ListenerstManager.getInstance().report("Description: " + description + " expected: " + Description);
			if (SourceNetwork != null)
				ListenerstManager.getInstance().report("SourceNetwork: " + sourceNetwork + " expected: " + SourceNetwork);
			if (SourcePort != null)
				ListenerstManager.getInstance().report("SourcePort: " + sourcePort + " expected: " + SourcePort);
			if (DestinationNetwork != null)
				ListenerstManager.getInstance().report("DestinationNetwork: " + destinationNetwork + " expected: " + DestinationNetwork);
			if (DestinationPort != null)
				ListenerstManager.getInstance().report("DestinationPort: " + destinationPort + " expected: " + DestinationPort);
			if (PhysicalPorts != null)
				ListenerstManager.getInstance().report("PhysicalPorts: " + physicalPorts + " expected: " + PhysicalPorts);
			if (VLANTag != null)
				ListenerstManager.getInstance().report("VLANTag: " + vLANTag + " expected: " + VLANTag);
			if (Protocol != null)
				ListenerstManager.getInstance().report("Protocol: " + protocol + " expected: " + Protocol);
			if (Direction != null)
				ListenerstManager.getInstance().report("Direction: " + direction + " expected: " + Direction);
			if (Action != null)
				ListenerstManager.getInstance().report("Action: " + action + " expected: " + Action);
		}
	}

	@Before
	public void setUp() throws Exception {
		ListenerstManager.getInstance().startLevel("Setup");
		defensepro = DpRadwareTestCase.getDefenseProInstance();
		ListenerstManager.getInstance().report("in setup...");
		ListenerstManager.getInstance().stopLevel();
	}

	public void tearDown() {

	}

	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}

	public String getBlackListName() {
		return BlackListName;
	}

	public void setBlackListName(String blackListName) {
		BlackListName = blackListName;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getSourceNetwork() {
		return SourceNetwork;
	}

	public void setSourceNetwork(String sourceNetwork) {
		SourceNetwork = sourceNetwork;
	}

	public String getSourcePort() {
		return SourcePort;
	}

	public void setSourcePort(String sourcePort) {
		SourcePort = sourcePort;
	}

	public String getDestinationNetwork() {
		return DestinationNetwork;
	}

	public void setDestinationNetwork(String destinationNetwork) {
		DestinationNetwork = destinationNetwork;
	}

	public String getDestinationPort() {
		return DestinationPort;
	}

	public void setDestinationPort(String destinationPort) {
		DestinationPort = destinationPort;
	}

	public String getPhysicalPorts() {
		return PhysicalPorts;
	}

	public void setPhysicalPorts(String physicalPorts) {
		PhysicalPorts = physicalPorts;
	}

	public String getVLANTag() {
		return VLANTag;
	}

	public void setVLANTag(String vLANTag) {
		VLANTag = vLANTag;
	}

	public String getProtocol() {
		return Protocol;
	}

	public void setProtocol(String protocol) {
		Protocol = protocol;
	}

	public String getDirection() {
		return Direction;
	}

	public void setDirection(String direction) {
		Direction = direction;
	}

	public String getAction() {
		return Action;
	}

	public void setAction(String action) {
		Action = action;
	}

}
