package com.radware.vision.tests.dp.classes.cliclasses;

import jsystem.extensions.analyzers.tabletext.GetTableColumn;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;

import org.apache.commons.lang.ArrayUtils;
import org.junit.Before;
import org.junit.Test;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

public class CliPhysicalPortsTests extends SystemTestCase4 {

	DefenseProProduct defensepro;

	private String physicalPortsGroupName;
	private String inboundPort;

	@Test
	@TestProperties(name = "Verify Physical Ports Class - Cli", paramsInclude = {
			"qcTestId", "physicalPortsGroupName", "inboundPort" })
	public void verifyPhysicalPortsClass() throws Exception {

		boolean passed = true;

		String gnCH = "Group Name";
		String ipCH = "Inbound Port";

		defensepro.classes.getClassesModifyPhysicalPortGroups();

		GetTableColumn tcgn = new GetTableColumn(gnCH);
		GetTableColumn tcip = new GetTableColumn(ipCH);

		defensepro.classes.analyze(tcgn);
		defensepro.classes.analyze(tcip);

		String[] gcgn = tcgn.getColumn();

		int indexOfEntry = ArrayUtils.indexOf(gcgn, physicalPortsGroupName);

		if (!(indexOfEntry == -1)) {

			String gcip = tcip.getColumn()[indexOfEntry];

			if (inboundPort != null) {
				if (!inboundPort.toString().equals(gcip.toString())) {
					ListenerstManager.getInstance().report(
							"FAIL : Inbound Port: " + inboundPort + " but Actual: "
									+ gcip.toString(), Reporter.FAIL);
					passed = false;
				}
			}
			if (passed) {
				if (inboundPort != null)
					ListenerstManager.getInstance().report(
							"Pass : Vlan Tag : " + inboundPort + " Actual: "
									+ gcip.toString());
			}
		} else {
			ListenerstManager.getInstance().report("FAIL : Entry Not Found ",
					Reporter.FAIL);
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

	public String getPhysicalPortsGroupName() {
		return physicalPortsGroupName;
	}

	public void setPhysicalPortsGroupName(String physicalPortsGroupName) {
		this.physicalPortsGroupName = physicalPortsGroupName;
	}

	public String getInboundPort() {
		return inboundPort;
	}

	public void setInboundPort(String inboundPort) {
		this.inboundPort = inboundPort;
	}

}
