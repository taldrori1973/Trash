package com.radware.vision.infra.enums;

public enum DualListTypeEnum {

	TOPOLOGY_TREE_GROUPS("members"),
	ALERT_FILTER_DEVICES("deviceOrmIds"),
	ALERT_FILTER_GROUPS("logicalGroupOrmIds"),
	SCHEDULE_TASKS_DEVICES("devicesList"),
	SCHEDULE_TASKS_GROUPS("groupNames"),
	TEMPLATE_DEVICES("deviceIpAddresses"),
	TEMPLATE_GROUPS("groupNames");

	String dualListId;

	private DualListTypeEnum(String dualListId) {
		this.dualListId = dualListId;
	}
	
	public String getDualListId() {
		return this.dualListId;
	}
}
