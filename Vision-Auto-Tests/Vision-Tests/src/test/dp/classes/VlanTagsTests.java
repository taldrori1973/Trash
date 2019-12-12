package com.radware.vision.tests.dp.classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.vlantags.VLANTags;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;


public class VlanTagsTests extends DpTestBase {

	public enum GroupMode {
		Discrete, Range
	}

	private String vlanTagsGroupName;
	private GroupMode groupMode;
	private String vlanTag;
	private String vlanTagFrom;
	private String vlanTagTo;

	
	@Test
    @TestProperties(name = "Add VLAN Tag", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName",
            "vlanTagsGroupName", "groupMode", "vlanTag", "vlanTagFrom",
			"vlanTagTo" })
	public void addVlanTag() {

		VLANTags vlanTags = dpUtils.dpProduct.mConfiguration().mClasses()
				.mVLANTags();
		vlanTags.openPage();
		vlanTags.addVLANTag();
		vlanTags.setVLANTagsGroupName(vlanTagsGroupName);
		vlanTags.selectGroupMode(groupMode.toString());
		if (groupMode.toString() == "Discrete") {
			vlanTags.setVLANTag(vlanTag);
		} else {
			vlanTags.setVLANTagFrom(vlanTagFrom);
			vlanTags.setVLANTagTo(vlanTagTo);
		}
		vlanTags.submit();

	}

	
	@Test
    @TestProperties(name = "Delete VLAN Tag", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "vlanTagsGroupName"})
    public void deleteVlanTag() {
		VLANTags vlanTags = dpUtils.dpProduct.mConfiguration().mClasses().mVLANTags();
		vlanTags.openPage();
		vlanTags.deleteVLANTagByKeyValue("Vlan Tags Group Name", vlanTagsGroupName);
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

	public GroupMode getGroupMode() {
		return groupMode;
	}

	public void setGroupMode(GroupMode groupMode) {
		this.groupMode = groupMode;
	}

	public String getVlanTagsGroupName() {
		return vlanTagsGroupName;
	}

	public void setVlanTagsGroupName(String vlanTagsGroupName) {
		this.vlanTagsGroupName = vlanTagsGroupName;
	}

}
