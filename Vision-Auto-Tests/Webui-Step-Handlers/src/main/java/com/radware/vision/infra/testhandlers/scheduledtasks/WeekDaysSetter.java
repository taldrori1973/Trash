package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class WeekDaysSetter{
	
	public List<String> weekDaysAll = Arrays.asList(new String[]{"Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"});
    public WebUICheckbox weekDayCheckBox;

    public void checkWeekDays(List<String> weekDays) {
		for(int i = 0;i < weekDays.size();i++)
		{
			ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getWeekDay(weekDays.get(i)));
            weekDayCheckBox = new WebUICheckbox(locator);
            weekDayCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            weekDayCheckBox.check();
		}
	}
	
	public void uncheckAllWeekDays() {
		for(int i = 0;i < weekDaysAll.size();i++)
		{
			ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getWeekDay(weekDaysAll.get(i)));
            weekDayCheckBox = new WebUICheckbox(locator);
            weekDayCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            weekDayCheckBox.uncheck();
		}
	}
	
}

