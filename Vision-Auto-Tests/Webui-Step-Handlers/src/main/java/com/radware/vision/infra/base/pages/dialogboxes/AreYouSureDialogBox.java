package com.radware.vision.infra.base.pages.dialogboxes;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;


public class AreYouSureDialogBox {
    public WebUIWidget dialogBox = null;
    WebUIButton yesButton = null;
    WebUIButton noButton = null;
    public WebUIButton closeButton = null;


    public AreYouSureDialogBox() {
        try {
            ComponentLocator dialogBoxLocator = new ComponentLocator(How.CLASS_NAME, "DialogBox");
            dialogBox = new WebUIWidget(new WebUIComponent(dialogBoxLocator));
        } catch (Exception e) {
            RestTestBase.report.report("no Dialog Box found", Reporter.FAIL);
        }
    }


    public void yesButtonClick() {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            ComponentLocator yesButtonLocator = new ComponentLocator(How.ID, WebUIStrings.getYesDialogBox());
            yesButton = new WebUIButton(dialogBox.findInner(yesButtonLocator));
            yesButton.click();
        } catch (Exception e) {
            RestTestBase.report.report("no Button found", Reporter.FAIL);
        }
        finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    public void noButtonClick() {
        try {
            ComponentLocator noButtonLocator = new ComponentLocator(How.ID, WebUIStrings.getNoDialogBox());
            noButton = new WebUIButton(dialogBox.findInner(noButtonLocator));
            noButton.click();
        } catch (Exception e) {
            RestTestBase.report.report("no Button found", Reporter.FAIL);
        }
    }

    public void closeButtonClick() {
        try {
            ComponentLocator noButtonLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDialogBoxClose());
            closeButton = new WebUIButton(dialogBox.findInner(noButtonLocator));
            closeButton.click();
        } catch (Exception e) {
            RestTestBase.report.report("no Button found", Reporter.FAIL);
        }
    }

}
