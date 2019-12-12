package com.radware.vision.infra.testhandlers.toolbox;

import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.widgets.WidgetType;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.toolbox.advanced.appshapes.AppShapes;
import com.radware.vision.infra.base.pages.toolbox.advanced.appshapes.CreateByType;
import com.radware.vision.infra.enums.ToolboxGroupsEnum;
import com.radware.vision.infra.utils.GeneralUtils;

import java.util.*;

public class ToolboxAdvancedHandler {

    public static void selectAdvancedOperatorToolbox(ToolboxGroupsEnum groupName) {
            ToolboxHandler.selectCategoryFromAdvanced(groupName);
    }


    public static void addAppShapes(List<Map<String, String>> data) throws Exception {
        WebUIVisionBasePage page = new AppShapes();
        page.getContainer().getTable("AppShape Instances").addRow();
        page = new CreateByType();
        List<String> tableKeys = new ArrayList<>(data.get(0).keySet());
        WebUIWidget widget = null;
        String value = "";
        String currentTab = "Citrix XenDesktop Instance";

        String appShapeType = data.get(0).get("AppShape Type");

        for (String key : tableKeys) {

            //update the page according to the requested AppShape type
            if (!key.equals("AppShape Type") && !key.equals("Device Name") && !page.getPageName().equals(appShapeType))
                page = new WebUIVisionBasePage(appShapeType, AppShapes.AppShapesTree.getEnumInstance(appShapeType).getXmlFileName(), false);

            //Switch to to the right tab
            if (key.equals("Instance Name") || key.equals("StoreFront Virtual Address") || key.equals("DDC Virtual Address")) {
                currentTab = switchToTab(page, currentTab, "Citrix XenDesktop Instance");
            }
            if (key.contains("Citrix StoreFront Servers") || key.contains("Citrix DDC Servers")) {
                currentTab = switchToTab(page, currentTab, "Application Servers");
            }

            if (key.contains("SLB Metric") || key.contains("Health Check")) {
                currentTab = currentTab = switchToTab(page, currentTab, "Load Balancing Settings");
            }

            if (key.equals("Compression") || key.equals("Connection Management")) {
                currentTab = switchToTab(page, currentTab, "HTTP");
            }

            if (key.equals("SSL Acceleration")) {
                currentTab = switchToTab(page, currentTab, "SSL");
            }


            if (key.contains("->")) {
                if (key.contains("Address") || key.contains("Port")) {
                    String tableName = key.split("->")[0];
                    page.getContainer().getTable(tableName).addRow();
                    if (key.contains("Citrix StoreFront Servers")) {
                        if (tableKeys.contains("Citrix StoreFront Servers->Address")) {
                            widget = (WebUIWidget) page.getContainer().getWidgetByType("Address", WidgetType.TextField);
                            UIUtils.setValueToWidget(widget, data.get(0).get("Citrix StoreFront Servers->Address"));
                            tableKeys.set(tableKeys.indexOf("Citrix StoreFront Servers->Address"), "");

                        }
                        if (tableKeys.contains("Citrix StoreFront Servers->Port")) {
                            widget = (WebUIWidget) page.getContainer().getWidgetByType("Port", WidgetType.TextField);
                            UIUtils.setValueToWidget(widget, data.get(0).get("Citrix StoreFront Servers->Port"));
                            tableKeys.set(tableKeys.indexOf("Citrix StoreFront Servers->Port"), "");
                        }
                    }

                    if (key.contains("Citrix DDC Servers")) {
                        if (tableKeys.contains("Citrix DDC Servers->Address")) {
                            widget = (WebUIWidget) page.getContainer().getWidgetByType("Address", WidgetType.TextField);
                            UIUtils.setValueToWidget(widget, data.get(0).get("Citrix DDC Servers->Address"));
                            tableKeys.set(tableKeys.indexOf("Citrix DDC Servers->Address"), "");

                        }
                        if (tableKeys.contains("Citrix DDC Servers->Port")) {
                            widget = (WebUIWidget) page.getContainer().getWidgetByType("Port", WidgetType.TextField);
                            UIUtils.setValueToWidget(widget, data.get(0).get("Citrix DDC Servers->Port"));
                            tableKeys.set(tableKeys.indexOf("Citrix DDC Servers->Port"), "");
                        }
                    }
                    GeneralUtils.submitAndWait(0);
                }
                if (key.contains("SLB Metric") || key.contains("Health Check")) {

                    if (tableKeys.contains("StoreFront->SLB Metric")) {
                        widget = (WebUIWidget) page.getContainer().getWidgets("SLB Metric", Collections.singletonList(WidgetType.Dropdown)).get(0);
                        UIUtils.setValueToWidget(widget, data.get(0).get("StoreFront->SLB Metric"));
                        tableKeys.set(tableKeys.indexOf("StoreFront->SLB Metric"), "");

                    }

                    if (tableKeys.contains("StoreFront->Health Check")) {
                        widget = (WebUIWidget) page.getContainer().getWidgets("Health Check", Collections.singletonList(WidgetType.Dropdown)).get(0);
                        UIUtils.setValueToWidget(widget, data.get(0).get("StoreFront->Health Check"));
                        tableKeys.set(tableKeys.indexOf("StoreFront->Health Check"), "");

                    }


                    if (tableKeys.contains("DDC->SLB Metric")) {
                        widget = (WebUIWidget) page.getContainer().getWidgets("SLB Metric", Collections.singletonList(WidgetType.Dropdown)).get(1);
                        UIUtils.setValueToWidget(widget, data.get(0).get("DDC->SLB Metric"));
                        tableKeys.set(tableKeys.indexOf("DDC->SLB Metric"), "");

                    }

                    if (tableKeys.contains("DDC->Health Check")) {
                        widget = (WebUIWidget) page.getContainer().getWidgets("Health Check", Collections.singletonList(WidgetType.Dropdown)).get(1);
                        UIUtils.setValueToWidget(widget, data.get(0).get("DDC->Health Check"));
                        tableKeys.set(tableKeys.indexOf("DDC->Health Check"), "");

                    }
                }

            } else {

                if (!key.equals("")) {
                    widget = (WebUIWidget) page.getContainer().getWidget(key);
                    value = data.get(0).get(key);
                    UIUtils.setValueToWidget(widget, value);
                }
            }


        }

        GeneralUtils.submitAndWait(10);

    }

    private static String switchToTab(WebUIVisionBasePage page, String currentTab, String tabToSwitchTo) {

        if (currentTab.equals(tabToSwitchTo)) return currentTab;
        page.getContainer().getWidget(tabToSwitchTo).click();

        return tabToSwitchTo;
    }

    /**
     * check for appShape existence
     *
     * @param appShapeType the type of app shape we are looking for
     * @param deviceName   the device name
     * @return -1 if the row does not exist else the number of the row
     */
    public static int AppShapeExist(String appShapeType, String deviceName) {

        WebUITable appShapeTable = new AppShapes().getTable();
        return appShapeTable.findRowByKeysValues(Arrays.asList("AppShape Type", "Name"), Arrays.asList(appShapeType, deviceName));

    }

    public static void deleteAppShape(String appShapeType, String deviceName) {

        WebUITable appShapeTable = new AppShapes().getTable();
        appShapeTable.deleteRowByKeysValues(Arrays.asList("AppShape Type", "Name"), Arrays.asList(appShapeType, deviceName));

    }
}
