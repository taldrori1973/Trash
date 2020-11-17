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
import java.util.*;

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
//        expandMenu();
    }

    private static String getHomePagePath(String tab) {
        switch (tab.toLowerCase()) {
            case "adc reports":
            case "ams reports":
                return "Reports";
            case "ams new reports":
            case "adc new reports":
                return "NEW REPORTS";
            case "automation":
                return "Automation.Toolbox";
            case "home":return "HomePage";
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
            WebElement navigatorParentElement = getTitledItem(itemElement);
            if (navigatorParentElement == null || navigatorParentElement.findElement(By.xpath("/.//ancestor::li")).getAttribute("class").contains("collapsed"))
                BasicOperationsHandler.clickButton(item, "");
        } else throw new Exception("The element of " + item + " isn't found");
    }

    //here I validate if item's parent is title or not (if it has children, if it isn't a navigator)
    // we returned its parent and if it isn't a navigator returned null
    private static WebElement getTitledItem(WebElement itemElement) {
        WebElement itemParentElement = itemElement.findElement(By.xpath("./.."));
        if (itemParentElement.getAttribute("class").contains("sub-menu-children"))
            return itemParentElement;
        return null;

    }

    public static String validateExistNavigator(String pathText) throws Exception {
        expandMenu(pathText);
        for (String item : path) {
            VisionDebugIdsManager.setLabel(item);
            WebElement itemElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.SHORT_WAIT_TIME);
            if (itemElement == null) {
                navigateFromHomePage("VISION SETTINGS");
                return "The Navigator " + item + " should be exist, But it doesn't";
            }
            if(itemElement.findElement(By.xpath("./..")).getAttribute("class").contains("sub-menu-children")){
                if (itemElement.findElement(By.xpath("./../..")).getAttribute("class").contains("sub-menu-collapsed")){
                    BasicOperationsHandler.clickButton(item, "");
                }
            }
        }
        navigateFromHomePage("VISION SETTINGS");
        return "";
    }

    public static boolean isNavigationDisabled(String path) throws Exception {

        expandMenu(path);
        if (HomePage.path.size() > 1)
            for (int i = 0; i < HomePage.path.size() - 1; i++) openItem(HomePage.path.get(i));

        path = HomePage.path.get(HomePage.path.size() - 1);
        VisionDebugIdsManager.setLabel(path);
        WebElement webElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (!Objects.isNull(webElement)) {
            List<WebElement> elements = webElement.findElements(By.tagName("div"));
            if (!Objects.isNull(elements) && !elements.isEmpty()) {
                WebElement elementToTest = elements.get(0);
                String isDisabled = elementToTest.getAttribute("disabled");
                if (isDisabled == null) return false;
                return Boolean.parseBoolean(isDisabled);
            } else throw new Exception("no sub elements was found for " + path);
        } else throw new Exception("The element of " + path + " isn't found");
    }
}
