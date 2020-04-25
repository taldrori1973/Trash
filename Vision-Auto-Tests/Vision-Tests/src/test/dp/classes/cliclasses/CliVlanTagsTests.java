package com.radware.vision.tests.dp.classes.cliclasses;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.extensions.analyzers.tabletext.GetTableColumn;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.apache.commons.lang.ArrayUtils;
import org.junit.Before;
import org.junit.Test;

public class CliVlanTagsTests extends SystemTestCase4 {

	public enum GroupMode {
		Discrete, Range
	}

	private String vlanTagsGroupName;
	private GroupMode groupMode;
	private String vlanTag;
	private String vlanTagFrom;
	private String vlanTagTo;

	DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify Vlan Tags - Cli", paramsInclude = {
			"qcTestId", "vlanTagsGroupName", "groupMode", "vlanTag",
			"vlanTagFrom", "vlanTagTo" })
	public void CliVlanTagsTest() throws Exception {

		boolean passed = true;

		String gnCH = "Group Name";
		String vtCH = "VLAN Tag";
		String vtrfCH = "VLAN Tag Range From";
		String vtrtCH = "VLAN Tag Range To";

		defensepro.classes.getClassesModifyVlanTagGroups();

		GetTableColumn tcgn = new GetTableColumn(gnCH);
		GetTableColumn tcvt = new GetTableColumn(vtCH);
		GetTableColumn tcvtrf = new GetTableColumn(vtrfCH);
		GetTableColumn tcvtrt = new GetTableColumn(vtrtCH);

		defensepro.classes.analyze(tcgn);
		defensepro.classes.analyze(tcvt);
		defensepro.classes.analyze(tcvtrf);
		defensepro.classes.analyze(tcvtrt);

		String[] gcgn = tcgn.getColumn();

		int indexOfEntry = ArrayUtils.indexOf(gcgn, vlanTagsGroupName);

		if (!(indexOfEntry == -1)) {

			if (groupMode != null) {

				String gcvt = tcvt.getColumn()[indexOfEntry];
				String gcvtrf = tcvtrf.getColumn()[indexOfEntry];
				String gcvtrt = tcvtrt.getColumn()[indexOfEntry];

				if (groupMode.equals(GroupMode.Discrete)) {

					if (vlanTag != null) {
						if (!vlanTag.toString().equals(gcvt.toString())) {
							ListenerstManager.getInstance().report(
									"FAIL : vlan Tag: " + vlanTag
											+ " but Actual: "
											+ gcvt.toString(), Reporter.FAIL);
							passed = false;
						}
					}

				}
				if (groupMode.equals(GroupMode.Range)) {

					if (vlanTagFrom != null) {
						if (!vlanTagFrom.toString().equals(gcvtrf.toString())) {
							ListenerstManager.getInstance().report(
									"FAIL : vlan Tag From: " + vlanTagFrom
											+ " but Actual: "
											+ gcvtrf.toString(), Reporter.FAIL);
							passed = false;
						}
					}
					if (vlanTagTo != null) {
						if (!vlanTagTo.toString().equals(gcvtrt.toString())) {
							ListenerstManager.getInstance().report(
									"FAIL : vlan Tag To: " + vlanTagTo
											+ " but Actual: "
											+ gcvtrt.toString(), Reporter.FAIL);
							passed = false;
						}
					}

				}

				if (passed) {
					if (vlanTag != null && groupMode.equals(GroupMode.Discrete))
						ListenerstManager.getInstance().report(
								"Pass : Vlan Tag : " + vlanTag + " Actual: "
										+ gcvt.toString());
					if (vlanTagFrom != null
							&& groupMode.equals(GroupMode.Range))
						ListenerstManager.getInstance().report(
								"Pass : Vlan Tag From : " + vlanTagFrom
										+ " Actual: " + gcvtrf.toString());
					if (vlanTagTo != null && groupMode.equals(GroupMode.Range))
						ListenerstManager.getInstance().report(
								"Pass : Vlan Tag To : " + vlanTagTo
										+ " Actual: " + gcvtrt.toString());
				}

			} else {
				ListenerstManager.getInstance().report("FAIL : GroupMode is Empty Please fill ",
						Reporter.FAIL);
			}

		}

		else {
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

	public String getVlanTagsGroupName() {
		return vlanTagsGroupName;
	}

	public void setVlanTagsGroupName(String vlanTagsGroupName) {
		this.vlanTagsGroupName = vlanTagsGroupName;
	}

	public GroupMode getGroupMode() {
		return groupMode;
	}

	public void setGroupMode(GroupMode groupMode) {
		this.groupMode = groupMode;
	}

	public String getVlanTag() {
		return vlanTag;
	}

	public void setVlanTag(String vlanTag) {
		this.vlanTag = vlanTag;
	}

	public String getVlanTagFrom() {
		return vlanTagFrom;
	}

	public void setVlanTagFrom(String vlanTagFrom) {
		this.vlanTagFrom = vlanTagFrom;
	}

	public String getVlanTagTo() {
		return vlanTagTo;
	}

	public void setVlanTagTo(String vlanTagTo) {
		this.vlanTagTo = vlanTagTo;
	}



}
