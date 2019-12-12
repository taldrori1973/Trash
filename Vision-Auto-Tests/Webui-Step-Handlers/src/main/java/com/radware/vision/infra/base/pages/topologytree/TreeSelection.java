package com.radware.vision.infra.base.pages.topologytree;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import org.openqa.selenium.support.How;

import static com.radware.vision.infra.base.pages.topologytree.TreeSelection.TreeSelectionMenu.*;

public class TreeSelection {

    public enum TreeSelectionMenu {
		TREE_SELECTION_MENU("gwt-debug-treeSelectionMenu"),
        SITES("gwt-debug-sites_menu"),
        PHYSICAL_CONTAINERS("gwt-debug-physical_menu"),
        GROUPS("gwt-debug-groups_menu");

		String id;
		TreeSelectionMenu(String id) { this.id = id;}

		public String getId() { return id; }
	}

	public static String getPhysicalContainers() { return TreeSelectionMenu.PHYSICAL_CONTAINERS.getId(); }

	public void openTreeSelectionMenu() {
		ComponentLocator deviceTreeSelectionLocator = new ComponentLocator(How.ID, TREE_SELECTION_MENU.getId());
		WebUIUtils.fluentWaitClick(deviceTreeSelectionLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
	}

	public void openSitesAndClustersTree() {
		selectTreeSelection(SITES);
	}

	public void openPhysicalContainersTree() { selectTreeSelection(PHYSICAL_CONTAINERS); }

	public void openGroupsTree() {
		selectTreeSelection(GROUPS);
	}

	private void selectTreeSelection(TreeSelectionMenu option) {
		openTreeSelectionMenu();
		ComponentLocator deviceTreeSelectionLocator2 = new ComponentLocator(How.ID, option.getId());
		WebUIUtils.fluentWaitClick(deviceTreeSelectionLocator2.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
	}
}
