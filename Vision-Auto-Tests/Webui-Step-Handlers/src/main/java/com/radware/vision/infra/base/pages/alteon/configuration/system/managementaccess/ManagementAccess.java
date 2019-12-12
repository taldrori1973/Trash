package com.radware.vision.infra.base.pages.alteon.configuration.system.managementaccess;

import com.radware.automation.webui.widgets.api.TextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by moaada on 7/26/2017.
 */
public class ManagementAccess extends WebUIVisionBasePage {


    private ManagementAccess managementAccess;

    public ManagementAccess() {
        super("Management Access", "ManagementAccess.System.xml");
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getManagementAccessNode());
    }


    public ManagementAccess getManagementAccess() {
        return managementAccess != null ? managementAccess : new ManagementAccess();
    }

    public String getIdleTimeout() {
        TextField timeout = container.getTextField("Idle Timeout");
        return timeout.getValue();

    }

    public void setIdleTimeOut(String value) throws TargetWebElementNotFoundException {

        TextField timeout = container.getTextField("Idle Timeout");
        timeout.replaceContent(value);
    }


}
