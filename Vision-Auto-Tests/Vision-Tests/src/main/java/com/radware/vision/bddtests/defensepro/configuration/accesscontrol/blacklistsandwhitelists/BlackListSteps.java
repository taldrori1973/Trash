package com.radware.vision.bddtests.defensepro.configuration.accesscontrol.blacklistsandwhitelists;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.accesscontrol.blacklistsandwhitelists.BlackListHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Map;

public class BlackListSteps extends VisionUITestBase {
    int rowsNum;

    public BlackListSteps() throws Exception {
    }

    @Given("^UI Open black list in DefensePro (\\d+)$")
    public void openBlackListForDevice(int deviceIndex) throws Exception {
        try {
            String deviceName = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,deviceIndex).getDeviceName();
            setDeviceName(deviceName);
            BlackListHandler.openBlackList();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to open black list: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^UI Get black list rows number$")
    public void getRowsNumber() throws Exception {
        try {
            rowsNum = BlackListHandler.getRowsNumberStartWith("");
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get black list from DP: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI verify black list rows number$")
    public void verifyRowsNumber() throws Exception {
        try {
            if (rowsNum != BlackListHandler.getRowsNumberStartWith("")) {
                BaseTestUtils.report("Black list table should not change for unlicensed DP's.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get black list from DP: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate black list rows number that its name start with \"(.*)\" equal to (\\d+)$")
    public void verifyRowsNumberEqual(String namePrefix, int num) throws Exception {
        BlackListHandler.verifyRowsNumberEqual(namePrefix, num);
    }

    @When("^UI Fill in the black list table in DefensePro (\\d+)$")
    public void createRows(int deviceIndex) throws Exception {
        String deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,deviceIndex).getDeviceIp();
        BlackListHandler.fillInBlackListTableRows(deviceIp);
    }

    @When("^fill black white list$")
    public void fillBlackWhiteList(Map<String,String> blackWhiteList) throws Throwable {
        BlackListHandler.fillBlackWhiteList(blackWhiteList);

    }

    @When("^fill device: \"(.*)\", Edit Treshold$")
    public void fillEditTresholdDevice(String device) throws Throwable {
        if (device != null) {
                WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("tree-select-", true).getBy()).click();
                WebElement deviceSelectionElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*/li[contains(@class,'rc-tree-select-tree-treenode-switcher-open')]//div[text()='" + device +"']").getBy());
                if (deviceSelectionElement == null)
                    throw new Exception("No deviceElement with name " + device);
                deviceSelectionElement.click();
//            WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("vdirect-tree-select-dropdown", true).getBy()).click();
        }
    }

}
