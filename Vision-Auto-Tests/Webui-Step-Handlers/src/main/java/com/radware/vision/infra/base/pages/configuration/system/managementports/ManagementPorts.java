package com.radware.vision.infra.base.pages.configuration.system.managementports;

import com.radware.automation.webui.widgets.impl.WebUIVerticalTab;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 9/4/2014.
 */
public class ManagementPorts extends WebUIVisionBasePage {
    String tableLabel = "Global State of Management Port";
    public ExternalMonitoring externalMonitoring;
    public ManagementPorts() {
        super("Management Ports", "ManagementPorts.System.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getManagementPortsNode());
    }

    private void switchToPortSettingsTab() {
        WebUIVerticalTab tab = (WebUIVerticalTab)container.getVerticalTab("Port Settings");
        String classValue = tab.getWebElement().getAttribute("class");
        if(!(classValue.contains("selected")))
            tab.click();
    }
    private void switchToGatewayHealthCheckTab() {
        WebUIVerticalTab tab = (WebUIVerticalTab)container.getVerticalTab("Gateway Health Check");
        String classValue = tab.getWebElement().getAttribute("class");
        if(!(classValue.contains("selected")))
            tab.click();
    }
    private void switchToPhysicalPropertiesTab() {
        WebUIVerticalTab tab = (WebUIVerticalTab)container.getVerticalTab("Physical Properties");
        String classValue = tab.getWebElement().getAttribute("class");
        if(!(classValue.contains("selected")))
            tab.click();
    }
    private void switchToExternalMonitoringTab() {
        WebUIVerticalTab tab = (WebUIVerticalTab)container.getVerticalTab("External Monitoring ");
        String classValue = tab.getWebElement().getAttribute("class");
        if(!(classValue.contains("selected")))
            tab.click();
    }

    public class PortSettings {
        private PortSettings() {
        }
    }
    public class GatewayHealthCheck {
        private GatewayHealthCheck() {
        }
    }
    public class PhysicalProperties {
        private PhysicalProperties() {
        }
    }
    public class ExternalMonitoring {
        private ExternalMonitoring() {
        }
        public WebUITable getExternalMonitoringTable() {
            switchToExternalMonitoringTab();
            WebUITable table = (WebUITable)container.getTableById("agNewCfgHcTcpPortTable");
            return table;
        }
    }
    public ExternalMonitoring getExternalMonitoring() {
        if (this.externalMonitoring != null)
            return this.externalMonitoring;
        else
            return new ExternalMonitoring();
    }

}
