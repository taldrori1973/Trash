package com.radware.vision.infra.base.pages.defensepro;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.table.WebUICell;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.utils.enums.DeviceType;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;

public class DpClusterInformationTable extends WebUITable {

	WebUITable dpClusterInfoTable;
	
	public DpClusterInformationTable() {
		init();
	}
	
	public List<DpClusterEntity> getDpClusters() {
		WebUITable dpClusterSummaryTable = new WebUITable();
        dpClusterSummaryTable.setWaitForTableToLoad(false);
		dpClusterSummaryTable.setLocator(new ComponentLocator(How.ID, "gwt-debug-clusterTable"));
        dpClusterSummaryTable.find();
        dpClusterSummaryTable.setRawId("clusterTable");
        WebElement element = WebUIUtils.fluentWait(dpClusterSummaryTable.getLocator().getBy(), WebUIUtils.DEFAULT_WAIT_TIME);
        dpClusterSummaryTable.setWebElement(element);
		dpClusterSummaryTable.analyzeTable("div");
		List<DpClusterEntity> dpClusterEntities = new ArrayList<DpClusterEntity>();
		int rowCount = dpClusterSummaryTable.getRowsNumber();
		for (int i = 0; i < rowCount; i++) {
			try {
				WebUICell lockState = (WebUICell)dpClusterSummaryTable.cell(i, 0);
				WebUICell deviceType = (WebUICell)dpClusterSummaryTable.cell(i, 1);
				WebUICell deviceName = (WebUICell)dpClusterSummaryTable.cell(i, 2);
				WebUICell ipAddress = (WebUICell)dpClusterSummaryTable.cell(i, 3);
				WebUICell lockedBy = (WebUICell)dpClusterSummaryTable.cell(i, 4);
                WebUICell status = (WebUICell)dpClusterSummaryTable.cell(i, 5);
				WebUICell haStatus = (WebUICell)dpClusterSummaryTable.cell(i, 6);
				DpClusterEntity dpClusterEntity = 
						new DpClusterEntity(lockState.getInnerText(),
								DeviceType.valueOf(deviceType.getInnerText()),
								deviceName.getInnerText(),
								ipAddress.getInnerText(), 
								lockedBy.getInnerText(),
								HAStatus.valueOf(haStatus.getInnerText()),
                                DeviceStatus.valueOf(status.getInnerText()));
				dpClusterEntities.add(dpClusterEntity);
			} catch (Exception e) {
				throw new IllegalStateException("Failed to add table columns - " + e.getMessage() + "\n" + e.getCause(), e);
			}
		}
		return dpClusterEntities;
	} 
	
	private void init() {
		dpClusterInfoTable = new WebUITable();
		dpClusterInfoTable.setLocator(new ComponentLocator(How.ID, "gwt-debug-clusterTable"));
		dpClusterInfoTable.find();
	}
}
