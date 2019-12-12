package com.radware.vision.infra.base.pages.scheduledtasks;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.List;

public class ScheduledTasks extends WebUIVisionBasePage {
	
	String tasksTableLable = "Scheduled Tasks";
	
	public ScheduledTasks() {
		super("Scheduled Tasks", "Scheduler.ScheduledTasks.xml");
	}
	
	public TaskEntity addTask() {
		WebUITable usersTable = (WebUITable)container.getTable(tasksTableLable);
		usersTable.waitForLoadingLabel();
		usersTable.addRow();
		return new TaskEntity(getXmlFile());
	}
	public TaskEntity editTask(String columnName, String columnValue) {
		WebUITable usersTable = (WebUITable)container.getTable(tasksTableLable);
		usersTable.waitForLoadingLabel();
		usersTable.editRowByKeyValue(columnName, columnValue);
		return new TaskEntity(getXmlFile());
	}
	public void deleteTask(String columnName, String columnValue) {
		WebUITable tasksTable = (WebUITable)container.getTable(tasksTableLable);
		tasksTable.waitForLoadingLabel();
		tasksTable.deleteRowByKeyValue(columnName, columnValue);
	}

    public void deleteAllTasksInner(List<Integer> taskRowsToDelete) {
        WebUITable tasksTable = (WebUITable) container.getTable(tasksTableLable);
        tasksTable.waitForLoadingLabel();
        tasksTable.deleteSelectedRows(taskRowsToDelete);
    }

    public void runNowTask(String columnName, String columnValue) {
		WebUITable tasksTable = (WebUITable)container.getTable(tasksTableLable);
		tasksTable.clickRowByKeyValue(columnName, columnValue);
		runNowButtonClick();
	}

	public void selectTaskByName(String columnName, String columnValue) {
		WebUITable tasksTable = (WebUITable)container.getTable(tasksTableLable);
		tasksTable.clickRowByKeyValue(columnName, columnValue);
	}

	public WebUITable getTaskTable() {
		WebUITable table = (WebUITable)container.getTable(tasksTableLable);
		return table;
	}
	public void runNowButtonClick(){
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getRunNowSchedulerButton());
		(new WebUIComponent(locator)).click();
	}
	
	
}
