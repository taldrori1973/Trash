package com.radware.vision.infra.base.pages.navigation;

import com.radware.automation.tools.utils.PropertiesFilesUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class HomePage {

    public static List<String> path = new ArrayList<>(); // list of item path
    public static Map<String, String> constants; //constant that you want to use it found in resources/constant/constant params

    static {
        try {
            constants = PropertiesFilesUtils.mapAllPropertyFiles("constants");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void navigateFromHomePage(String pathText) throws Exception {
        expandMenu(pathText);
        for (String item : path) {
            openItem(item);
        }
        VisionDebugIdsManager.setLabel(path.isEmpty() ? "" : path.get(path.size() - 1).trim());
        if (getTitledItem(WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy())) == null) //if the element is the navigator
            VisionDebugIdsManager.setTab(getHomePagePath(path.get(path.size() - 1).trim()));
    }

    public static void expandMenu(String pathText) throws Exception {
        path.clear();
        path.addAll(Arrays.asList(pathText.split("->")));
        if (path.isEmpty()) throw new Exception("The path is empty!!");
        VisionDebugIdsManager.setTab("HomePage");
        expandMenu();
    }

    private static String getHomePagePath(String tab) {
        switch (tab.toLowerCase()) {
            case "adc reports":
            case "ams reports":
                return "Reports";
        }
        return tab;
    }

    // after this method the menuBar must be expanded
    private static void expandMenu() throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel("trigger");
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("type").equalsIgnoreCase("collapsed"))
            BasicOperationsHandler.clickButton("trigger", "");
    }

    public static void clickItemInHomePage(String label, String value) throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setTab("HomePage");
        BasicOperationsHandler.clickButton(label, value);
    }

    private static void openItem(String item) throws Exception {
        VisionDebugIdsManager.setLabel(item);
        WebElement itemElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (itemElement != null) {
            WebElement titledItem = getTitledItem(itemElement);
            if (titledItem == null || titledItem.getAttribute("aria-expanded").equalsIgnoreCase("false"))
                BasicOperationsHandler.clickButton(item, "");
        } else throw new Exception("The element of " + item + " isn't found");
    }

    //here I validate if item's parent is title or not (if it has children)
    private static WebElement getTitledItem(WebElement itemElement) {
        WebElement itemParentElement = itemElement.findElement(By.xpath("./.."));
        if (itemParentElement.getAttribute("class").equals("ant-menu-submenu-title"))
            return itemParentElement;
        return null;

    }

    public static String validateExistNavigator(String pathText) throws Exception {
        expandMenu(pathText);
        for (String item : path) {
            VisionDebugIdsManager.setLabel(item);
            WebElement itemElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.SHORT_WAIT_TIME);
            if (itemElement == null) {
                navigateFromHomePage("HOME");
                return "The Navigator " + item + " should be exist, But it doesn't";
            }
            WebElement titledItem = getTitledItem(itemElement);
            if (titledItem == null || titledItem.getAttribute("aria-expanded").equalsIgnoreCase("false"))
                itemElement.click();
        }
        navigateFromHomePage("HOME");
        return "";
    }
}
