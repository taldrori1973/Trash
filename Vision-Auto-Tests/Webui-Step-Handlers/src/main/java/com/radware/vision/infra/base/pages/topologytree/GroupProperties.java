package com.radware.vision.infra.base.pages.topologytree;

import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIDualList;
import com.radware.vision.infra.enums.DeviceType4Group;
import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.List;

public class GroupProperties extends DeviceProperties {

	public GroupProperties() {
		super("GroupAddOrEditScreen.xml");
	}

	public void openAddNewGroupDialog(){
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStringsVision.getAddNewGroupCommand());
		openPage();
		BasicOperationsHandler.delay(0.5);
	}

	public void openEditGroupDialog(){
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStringsVision.getEditGroupCommand());
		openPage();
	}

	public void setType(DeviceType4Group elementType) {
		WebUIDropdown deviceTypeCombo = (WebUIDropdown)container.getDropdown(typeComboName);
		deviceTypeCombo.selectOptionByText(elementType.getDeviceType());
	}

	public void addSelectedDevices(List<String> deviceNames) {
		if (deviceNames == null)
			return;
		WebUIDualList dualList = getDualList(DualListTypeEnum.TOPOLOGY_TREE_GROUPS);

		for (String deviceName : deviceNames) {
			dualList.moveRight(deviceName);
		}
	}

	public void editSelectedDevices(List<String> deviceNames) {
		if (deviceNames == null)
			return;
		WebUIDualList dualList = getDualList(DualListTypeEnum.TOPOLOGY_TREE_GROUPS);

		List<String> rightItems = dualList.getRightItems();
		for (int i = 0; i < rightItems.size(); i++) {
			dualList.moveLeft(rightItems.get(i));
		}

		for (String deviceName : deviceNames) {
			dualList.moveRight(deviceName);
		}
	}
}
