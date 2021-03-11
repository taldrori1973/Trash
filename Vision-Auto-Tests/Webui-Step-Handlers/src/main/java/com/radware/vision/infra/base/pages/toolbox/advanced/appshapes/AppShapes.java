package com.radware.vision.infra.base.pages.toolbox.advanced.appshapes;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.enums.enumsutils.Element;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.infra.utils.ReportsUtils;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class AppShapes extends WebUIVisionBasePage {

    public final static String TABLE_ADD = "gwt-debug-appShapeTable_NEW";

    public AppShapes() {
        super("AppShapes", "AppShape.AppShapeService.xml", false);
        clickOnAppShapes();
        getPageName();
    }

    public void clickOnAppShapes() {
        ComponentLocator appShapesTreeNode = new ComponentLocator(How.XPATH, GeneralUtils.buildGenericXpath(WebElementType.Id, AppShapesTree.APPSHAPES.getElementId(), OperatorsEnum.EQUALS));
        WebElement appShapesNode;
        if ((appShapesNode = WebUIUtils.fluentWait(appShapesTreeNode.getBy(), WebUIUtils.DEFAULT_WAIT_TIME)) == null) {
            ReportsUtils.reportAndTakeScreenShot("AppShapes does not exist in current page, please make to navigate to the right page", Reporter.FAIL);
        } else {
            ClickOperationsHandler.clickWebElement(appShapesNode);
        }

    }

    public WebUITable getTable() {
        clickOnAppShapes();
        return (WebUITable) container.getTable("AppShape Instances");

    }

    public enum AppShapesTree implements Element {

        APPSHAPES("gwt-debug-AppShapesNode-content", "", ""),
        COMMON_WEB_APPLICATION("gwt-debug-Common Web Application-content", "Common Web Application", "Common_Web_Application"),
        CIRTIX_XENDESKTOP("gwt-debug-Citrix XenDesktop-content", "Citrix XenDesktop", "CitrixXenDesktop.xml"),
        DEFENSE_SSL("gwt-debug-Defense SSL-content", "Defense SSL", "DefenseSSL"),
        MICROSOFT_EXCHANGE_2010("gwt-debug-Microsoft Exchange 2010-content", "Microsoft Exchange 2010", ""),
        MICROSOFT_EXCHANGE_2013("gwt-debug-Microsoft Exchange 2013-content", "Microsoft Exchange 2013", ""),
        MICROSOFT_LYNC_EXTERNAL("gwt-debug-Microsoft Lync External-content", "Microsoft Lync External", ""),
        MICROSOFT_LYNC_INTERNAL("gwt-debug-Microsoft Lync Internal-content", "Microsoft Lync Internal", ""),
        ORACLE_E_BUSINESS("gwt-debug-Oracle E Business-content", "Oracle E Business", ""),
        ORACLE_SOA_SUITE_11G("gwt-debug-Oracle SOA Suite 11g-content", "Oracle SOA Suite 11g", ""),
        ORACLE_WEBLOGIC_12C("gwt-debug-Oracle WebLogic 12c-content", "Oracle WebLogic 12c", ""),
        SHAREPOINT_2010("gwt-debug-SharePoint 2010-content", "SharePoint 2010", ""),
        SHAREPOINT_2013("gwt-debug-SharePoint 2013-content", "SharePoint 2013", ""),
        VMWARE_VIEW_5DOT1("gwt-debug-VMware View 5.1-content", "VMware View 5.1", ""),
        ZIMBRA("gwt-debug-Zimbra-content", "Zimbra", "");

        public String elementId;
        public String elementName;
        public String xmlFileName;

        AppShapesTree(String elementId, String elementName, String xmlFileName) {
            this.elementId = elementId;
            this.elementName = elementName;
            this.xmlFileName = xmlFileName;
        }

        public static AppShapesTree getEnumInstance(String appShapeTypeName) throws Exception {

            for (AppShapesTree instance : AppShapesTree.values()) {

                if (instance.getElementName().equals(appShapeTypeName)) return instance;
            }

            throw new Exception("Could not get the AppShapeTree enum instance , there is no name equal to :" + appShapeTypeName);
        }

        public String getXmlFileName() {
            return xmlFileName;
        }

        @Override
        public String getElementName() {
            return elementName;
        }

        @Override
        public String getElementId() {
            return elementId;
        }
    }

}
