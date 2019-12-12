package com.radware.vision.infra.base.pages.defensepro.dpOperations;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.devicecontrolbar.ImportOperation;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 3/24/2015.
 */
public class UpdateSecuritySignatures extends DpOperationsBase {

    public UpdateSecuritySignatures() {
        super();
    }

    public void setUpdateSource(String updateSource) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getUpdateSecuritySignaturesSource(updateSource));
        (new WebUIComponent(locator)).click();
    }

    public void setSignatureType(String signatureType) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getUpdateSecuritySignatureType(signatureType));
        (new WebUIComponent(locator)).click();
    }

    public void updateFromClient(String fileName) throws Exception {
        ImportOperation uploadFromClient = new ImportOperation();
        uploadFromClient.importFromClient(fileName, true);
    }
}
