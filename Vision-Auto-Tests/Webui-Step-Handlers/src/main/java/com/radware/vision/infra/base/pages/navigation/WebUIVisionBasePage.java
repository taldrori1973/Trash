package com.radware.vision.infra.base.pages.navigation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.utils.navtree.NavigationWidget;
import com.radware.automation.webui.webpages.WebUIPage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDualList;
import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class WebUIVisionBasePage extends WebUIPage {

    private static WebUIVisionBasePage currentPage = new WebUIVisionBasePage();
    private How pageLocatorHow;
    private String pageLocatorContent;


    protected WebUIVisionBasePage() {
        WebUIUtils.lastDeviceDriverId = WebUIUtils.selectedDeviceDriverId;
        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;

    }

    public WebUIVisionBasePage(String pageName, String deviceDriverXmlFile) {
        WebUIUtils.lastDeviceDriverId = WebUIUtils.selectedDeviceDriverId;
        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;
        setPageName(pageName);
        setXmlFile(deviceDriverXmlFile);
        loadPageElements(true);

        currentPage.setContainer(container);
        currentPage.setPageName(pageName);
        currentPage.setXmlFile(deviceDriverXmlFile);

        //if someone calls the constructor it means its a xml page
        VisionDebugIdsManager.resetAllNodes();
    }

    public WebUIVisionBasePage(String pageName, String deviceDriverXmlFile, boolean cleanExistingContainer) {
        WebUIUtils.lastDeviceDriverId = WebUIUtils.selectedDeviceDriverId;
        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;
        setPageName(pageName);
        setXmlFile(deviceDriverXmlFile);
        loadPageElements(cleanExistingContainer);

        currentPage.setContainer(container);
        currentPage.setPageName(pageName);
        currentPage.setXmlFile(deviceDriverXmlFile);

        //if someone calls the constructor it means its a xml page
        VisionDebugIdsManager.resetAllNodes();

    }

    /**
     * Prevent currentPage to be null , so it can be used also for data debug id's
     *
     * @return
     */
    public static WebUIVisionBasePage getCurrentPage() {
        return currentPage == null ? currentPage = new WebUIVisionBasePage() : currentPage;
    }

    public static WebUIVisionBasePage navigateToPage(String path) {

        WebUIPage targetPage = new WebUIVisionBasePage();
        String[] pathMenu = path.split("->");
        if (pathMenu[0].equalsIgnoreCase("security monitoring")) {
            NavigationWidget.securityMonitoringNavigate(Arrays.asList(pathMenu));
        } else {
            navigation.treePath.clearPath();
            for (String pathNode : pathMenu) {
                navigation.treePath.addToPath(pathNode);
            }

            try {
                targetPage.setXmlFile(""); // set to empty after each page open
                silentPopupclose();
                closeTabs();
                //Open the page and update the container
                targetPage.navigateToPage();
                targetPage.loadPageElements();
                clearNavigationPath();
                WebUIUtils.isTriggerLoadingEvent = true;
                ReportWebDriverEventListener.waitForLoading(WebUIUtils.getDriver());
            } catch (Exception e) {
                BaseTestUtils.report("Could Not Navigate To " + path + System.lineSeparator() + "Cause : " + e.getMessage(), Reporter.FAIL);
            }
        }
        //new page , reset the path
        VisionDebugIdsManager.resetAllNodes();
        return currentPage = (WebUIVisionBasePage) targetPage;
    }

    public static void navigateFromHomePage(String pageName) throws Exception {
        VisionDebugIdsManager.setTab("HomePage");
        VisionDebugIdsManager.setLabel(pageName);
//        WebElement widgetTitleElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@data-debug-id='card_'][.//div[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() +  "']]//div/span").getBy());
//        String newPrefixPath;
//        try
//        {
//            newPrefixPath = widgetTitleElement.getText();
//        }catch (Exception e)
//        {
//            if (widgetTitleElement == null)
//                throw new Exception("no title Element for " + pageName);
//            throw e;
//        }
        // fixed the element path
        int lastIndexOfDotInPageName = pageName.lastIndexOf(".");
        if (lastIndexOfDotInPageName != -1)
        {
            String newPrefixPath = pageName.substring(0, lastIndexOfDotInPageName);
            BasicOperationsHandler.clickButton(pageName, "");
            VisionDebugIdsManager.setTab(newPrefixPath);
            VisionDebugIdsManager.setSubTab(pageName.substring(lastIndexOfDotInPageName+1));
        }
        else
            {
                throw new Exception("The page name is " + pageName + ", but it should be with title like 'title.pageName'");
            }
    }

    public WebUIVisionBasePage openPage() {
        ComponentLocator locator = new ComponentLocator(pageLocatorHow, pageLocatorContent);
        if (pageLocatorContent.endsWith("_Tab")) {
            try {
                WebUIUtils.setIsTriggerPopupSearchEvent(false);
                WebUIComponent buttonComponent = new WebUIComponent(locator);
                buttonComponent.click();
            } catch (Exception e) {
                e.printStackTrace();

            } finally {
                WebUIUtils.setIsTriggerPopupSearchEvent(true);
            }
        } else {
            WebUIButton openPageButton = new WebUIButton(new WebUIComponent(locator));
            openPageButton.click();
        }

        return this;
    }

    public WebUIDualList getDualList(DualListTypeEnum dualListType) {
        return (WebUIDualList) container.getDualListById(dualListType.getDualListId());
    }

    public WebUIDualList getDualList(String dualListName) {
        return (WebUIDualList) container.getDualList(dualListName);
    }

    public void addSelectedDevices(DualListTypeEnum dualListType, List<String> deviceNames) {
        if (deviceNames == null) return;
        WebUIDualList devices = getDualList(dualListType);
        for (String deviceName : deviceNames) {
            devices.moveRight(deviceName);
        }
    }

    public void moveAllDevicesLeft(DualListTypeEnum dualListType) {
        WebUIDualList devices = getDualList(dualListType);
        List<String> rightItems = devices.getRightItems();
        for (int i = 0; i < rightItems.size(); i++) {
            devices.moveLeft(rightItems.get(i));
        }
    }

    public boolean validateSelectAllDevices(DualListTypeEnum dualListType) {
        WebUIDualList devices = getDualList(dualListType);
        List<String> leftItems = devices.getLeftItems();
        if (leftItems.size() > 2) return false;
        else return true;
    }

    public void removeSelectedDevices(DualListTypeEnum dualListType, List<String> deviceNames) {
        if (deviceNames == null) return;
        WebUIDualList devices = getDualList(dualListType);
        for (String deviceName : deviceNames) {
            devices.moveLeft(deviceName);
        }
    }



    private static void clickOnLine(String secondLevelFullPath){
        VisionDebugIdsManager.setLabel(secondLevelFullPath);
        WebElement itr = WebUIUtils.fluentWaitDisplayed(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (itr.getAttribute("class").toLowerCase().contains("collapse")) {
            WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        }else{
            WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
    }

    private static void clickOnMainMenu(String status){

        VisionDebugIdsManager.setLabel("Menu Bar");
        WebElement iter = WebUIUtils.fluentWaitDisplayed(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (iter.getAttribute("data-debug-id").contains(status)) { // check if main menu is open
            WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
    }

    public static WebUIVisionBasePage navigateToPageMenu(String path) {

        String secondLevelFullPath ="";
        WebUIPage targetPage = new WebUIVisionBasePage();
        String[] pathMenu = path.split("->");

        //open main menu
        clickOnMainMenu("collapse");

        for (int i = 0; i <= pathMenu.length - 1; i++) {

            if (i == 0) {

                secondLevelFullPath = pathMenu[i];
                clickOnLine(secondLevelFullPath);

            } else if (i >= 1) {

                secondLevelFullPath += "." + pathMenu[i];
                clickOnLine(secondLevelFullPath);
            }
        }
//            if (pathMenu.length -1 > 1) {
//                for (int j = 2; j <= pathMenu.length - 1; j++) {
//                    secondLevelFullPath += "." + pathMenu[j];
//                    VisionDebugIdsManager.setLabel(secondLevelFullPath);
//                    WebElement itr = WebUIUtils.fluentWaitDisplayed(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
//                    if (itr.getAttribute("class").toLowerCase().contains("collapse")) {
//                        WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
//                    }
//                }
//
//            }

//close main menu
        clickOnMainMenu("expand");

  //      WebUIUtils.fluentWaitClick(By.id(UpperBarItems.ScheduledTaskTab.getMenuIds()), WebUIUtils.SHORT_WAIT_TIME, false);

        return currentPage = (WebUIVisionBasePage) targetPage;
    }

    public How getPageLocatorHow() {
        return pageLocatorHow;
    }

    public void setPageLocatorHow(How pageLocatorHow) {
        this.pageLocatorHow = pageLocatorHow;
    }

    public String getPageLocatorContent() {
        return pageLocatorContent;
    }

    public void setPageLocatorContent(String pageLocatorContent) {
        this.pageLocatorContent = pageLocatorContent;
    }

}
