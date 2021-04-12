package com.radware.vision.bddtests;

import com.radware.automation.webui.utils.multitab.BrowserMultiTabManager;
import com.radware.automation.webui.utils.multitab.TabInfo;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import cucumber.api.java.en.Then;

public class BrowserTabsSteps extends VisionUITestBase {


    BrowserMultiTabManager multiTabsManager=BrowserMultiTabManager.getInstance();

    public BrowserTabsSteps() throws Exception {
    }


    /**
     *Duplicate tab number Index and open the new tab
     * @param index the index of the tab to duplicate , start from 1
     */
    @Then("^Browser Duplicate Tab Number (\\d+)$")
    public void browserDuplicateCurrentTab(int index){

       TabInfo tabToDuplicate=multiTabsManager.getTab(index);
       multiTabsManager.createTab(tabToDuplicate.getUrl());
    }

    /**
     * Switch between current tab and tab number Index
     * @param index The Index of the tab to switch to
     */
    @Then("^Browser Switch to Tab Number (\\d+)$")
    public void brwoserSwitchToTabNumber(int index)  {

    multiTabsManager.switchTab(index);
    BasicOperationsHandler.delay(1);
    }

}
