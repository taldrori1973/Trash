package com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.accesscontrol.blacklistsandwhitelists;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.blackandwhitelists.blacklist.BlackList;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.restcommands.mgmtcommands.tree.DeviceCommands;
import com.radware.utils.device.DeviceTableUtils;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Map;


public class BlackListHandler extends BaseHandler {

    static final int BLACK_LIST_CAPACITY = 4900;

    public static void openBlackList() {
        BlackList blackList = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mBlackList();
        blackList.openPage();
    }

    public static void verifyRowsNumberEqual(String namePrefix, int num) {
        try {
            if (num != BlackListHandler.getRowsNumberStartWith(namePrefix)) {
                BaseTestUtils.report("ips numbers not equal to " + num, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify black list rows number that its name start with " + namePrefix + ": " + e.getMessage(), Reporter.FAIL);
        }
    }


    public static int getRowsNumberStartWith(String namePrefix) throws Exception {
        //set the name search box
        ClickOperationsHandler.setTextToElement(WebElementType.Id, "gwt-debug-rsNewBlackListName_SearchControl", namePrefix, true);
        //wait for page to load
        BasicOperationsHandler.delay(5);
        String totalRowsText = ClickOperationsHandler.getTextFromElement(".//*[@id='gwt-debug-BlackList']//div[@id='gwt-debug-totalRows']");
        if (totalRowsText.equals("There is no data to display.")) {
            return 0;
        }
        String totalRows = totalRowsText.split(" ")[6];
        return Integer.parseInt(totalRows);
    }

    public static void fillInBlackListTableRows(String deviceIp) {
        try {
            int rowsNum = BlackListHandler.getRowsNumberStartWith("");
            DeviceCommands deviceCommands = new DeviceCommands(restTestBase.getVisionRestClient());
            deviceCommands.lockDeviceByManagementIp(deviceIp);
            String namesGroup = "rsNewBlackListName,rsNewBlackListState,rsNewBlackListProtocol,rsNewBlackListDirection,rsNewBlackListExpirationHour,rsNewBlackListExpirationMinute,rsNewBlackListDynamicState,rsNewBlackListOriginatedIP,rsNewBlackListAction,rsNewBlackListReportAction,rsNewBlackListPacketReport";
            String valuesGroup = "";
            if (rowsNum < BLACK_LIST_CAPACITY) {
                int rowsToFill = BLACK_LIST_CAPACITY - rowsNum;
                for (int i = 0; i < rowsToFill; i++) {
                    valuesGroup = i + ",1,0,1,0,0,2,0.0.0.0,1,1,2";
                    try {
                        DeviceTableUtils.createTableRowWithName(restTestBase.getVisionRestClient(), deviceIp, "rsNewBlackListTable", namesGroup, valuesGroup, String.valueOf(i));
                    } catch (Exception e) {
                        //Check if black list contains entry with this key if yes skip to next entry
                        if (e.getMessage().contains("Message: M_00386: An entry with same values in the following fields already exists.") || e.getMessage().contains("M_00386: An entry with same key already exists.")) {
                            rowsToFill++;
                            continue;
                        } else {
                            throw new Exception(e.getMessage());
                        }
                    }
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create black list table rows: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void deleteBlackListTableRows(String deviceIp, int rowsNumber) {
        try {
            DeviceCommands deviceCommands = new DeviceCommands(restTestBase.getVisionRestClient());
            deviceCommands.lockDeviceByManagementIp(deviceIp);
            for (int i = 0; i < rowsNumber; i++) {
                DeviceTableUtils.deleteTableRow(restTestBase.getVisionRestClient(), deviceIp, "rsNewBlackListTable", String.valueOf(i));
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete black list table rows: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void fillBlackWhiteList(Map<String, String> blackWhiteList) throws Exception {
        selectDevices(blackWhiteList.get("devices"));
        if (blackWhiteList.getOrDefault("Run Under Attack", "true").equalsIgnoreCase("false"))
            BasicOperationsHandler.clickButton("runUnderAttack");

        BasicOperationsHandler.setTextField("blackWhiteListPrefix", blackWhiteList.getOrDefault("Entry prefix", ""));
        BasicOperationsHandler.setTextField("blackWhiteListSourceIP", blackWhiteList.getOrDefault("Source IP", ""));
        BasicOperationsHandler.setTextField("blackWhiteListSourcePort", blackWhiteList.getOrDefault("Source Port", ""));
        BasicOperationsHandler.setTextField("blackWhiteListDestinationIP", blackWhiteList.getOrDefault("Destination IP", ""));
        BasicOperationsHandler.setTextField("blackWhiteListDestinationPort", blackWhiteList.getOrDefault("Destination Port", ""));
        WebElement blackOrWhiteDropBoxElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*/label[@data-debug-id='tableColor_Label']/../..//span[contains(@class,'rc-tree-select rc-tree-select-')]").getBy());
        if (blackOrWhiteDropBoxElement != null) {
            if (!blackOrWhiteDropBoxElement.getAttribute("class").contains("rc-tree-select rc-tree-select-open rc-tree-select-focused rc-tree-select-enabled"))
                blackOrWhiteDropBoxElement.click();
        }
        if (blackWhiteList.get("Black or White List").contains("white"))
            WebUIUtils.fluentWaitClick(new ComponentLocator(How.XPATH, "//*/div[contains(@data-debug-id,'tableColor_option_White')]").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        else
            WebUIUtils.fluentWaitClick(new ComponentLocator(How.XPATH, "//*/div[contains(@data-debug-id,'tableColor_option_Black')]").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        if (blackOrWhiteDropBoxElement != null)
            WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByDbgId("RunnableStarter_ActionButton").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        Thread.sleep(20 * 1000);
        VisionDebugIdsManager.setLabel("task successful");
        WebElement successfulTask = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.MAX_RENDER_WAIT_TIME);
        if (successfulTask != null) {
            if (!successfulTask.isDisplayed() || !successfulTask.getText().contains("Task completed successfully."))
                BaseTestUtils.report("Failed to execute script ", Reporter.FAIL);
        } else {
            BaseTestUtils.report("Failed to execute script ", Reporter.FAIL);
        }
        BasicOperationsHandler.clickButton("Dismiss");

    }

    public static void selectDevices(String devices) throws Exception {

        if (devices != null) {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("vdirect-tree-select-dropdown", true).getBy()).getAttribute("class").contains("closed"))
                WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("vdirect-tree-select-dropdown", true).getBy()).click();
            String devicesArray[] = devices.split(",");
            for (String device : devicesArray) {
                WebElement deviceSelectionElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*/li[contains(@class,'rc-tree-select-tree-treenode-switcher-open')]//div[text()='" + device + "']").getBy());
                if (deviceSelectionElement == null)
                    throw new Exception("No deviceElement with name " + device);
                deviceSelectionElement.click();
            }
            WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("vdirect-tree-select-dropdown", true).getBy()).click();
        }
    }


}
