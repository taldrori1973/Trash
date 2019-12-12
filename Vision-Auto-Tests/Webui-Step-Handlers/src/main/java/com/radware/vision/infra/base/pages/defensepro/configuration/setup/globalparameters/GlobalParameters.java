package com.radware.vision.infra.base.pages.defensepro.configuration.setup.globalparameters;

import com.radware.automation.webui.widgets.api.TextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsDp;
import org.openqa.selenium.support.How;

/**
 * Created by moaada on 7/25/2017.
 */
public class GlobalParameters extends WebUIVisionBasePage {


    private GlobalParameters globalParameters;
    private TextField locationTextField;


    public GlobalParameters() {

        super("Global Parameters", "GlobalParameters.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsDp.getGlobalParameters());
    }

    public String getLocation() {

        locationTextField = container.getTextField("Location");
        return locationTextField.getValue();

    }

    public void setLocation(String location) throws TargetWebElementNotFoundException {

        locationTextField = container.getTextField("Location");
        locationTextField.replaceContent(location);
    }

    public GlobalParameters getGlobalParameters() {
        return globalParameters != null ? globalParameters : new GlobalParameters();
    }


}
