package com.radware.vision.infra.base.pages.system.generalsettings.basicparameters;

import com.radware.automation.webui.widgets.impl.WebUIVerticalTab;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 11/24/2014.
 */
public class BasicParameters extends WebUIVisionBasePage {
    private AttackDescriptionsFile attackDescriptionsFile;

    public BasicParameters() {
        super("Basic Parameters", "MgtServer.MC.Overview.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getBasicParametersItem());
    }


    public class AttackDescriptionsFile {
        private AttackDescriptionsFile() {
        }

        public String getAttackDescriptionsFileLastUpdate() {
            switchToAttackDescriptionsFileTab();
            String attackDescriptionsFileLastUpdate = container.getTextField("Attack Descriptions File Last Update").getValue().toString();
            return attackDescriptionsFileLastUpdate;
        }
    }

    public AttackDescriptionsFile getAttackDescriptionsFile() {
        if (this.attackDescriptionsFile != null)
            return this.attackDescriptionsFile;
        else
            return new AttackDescriptionsFile();
    }

    private void switchToAttackDescriptionsFileTab() {
//        ComponentLocator locator = new ComponentLocator(How.ID , "gwt-debug-MgtServer.MC.AttackDescriptionLastUpdate_Tab");
//        (new WebUIComponent(locator)).getWebElement().click();
        WebUIVerticalTab tab = (WebUIVerticalTab) container.getVerticalTab("Attack Descriptions File");
        String classValue = tab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            tab.click();
    }
//    public AttackDescriptionsFile mAttackDescriptionsFile() {
//        if(attackDescriptionsFile == null)
//            attackDescriptionsFile = new AttackDescriptionsFile(getContainer());
//
//        return attackDescriptionsFile;
//    }
//    public void openTabAttackDescriptionsFile() {
//        VerticalTab verticalTab = container.getVerticalTab("Attack Descriptions File");
//        verticalTab.click();
//    }
//
//    public void openTabSoftware() {
//        VerticalTab verticalTab = container.getVerticalTab("Software");
//        verticalTab.click();
//    }
//
//    public void openTabAttackHardware() {
//        VerticalTab verticalTab = container.getVerticalTab("Hardware");
//        verticalTab.click();
//    }
//
}
