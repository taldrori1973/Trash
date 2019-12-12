package com.radware.vision.infra.base.pages.system.generalsettings.display;

import com.radware.automation.webui.widgets.api.Dropdown;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.generalsettings.enums.GeneralSettingsEnum;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by vadyms on 5/20/2015.
 */
public class Display extends WebUIVisionBasePage {

    public Display display;

    public Display() {
        super("Display", "MgtServer.Display.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getDisplayNode());
    }

    public void setLanguage(GeneralSettingsEnum.Language language) {
        Dropdown langDropdown = container.getDropdown("Default Display Language");
        langDropdown.selectOptionByValue(language.toString());

    }

    public void setTimeFormat(GeneralSettingsEnum.TimeFormat timeFormat) {
        Dropdown timeFormatDropdown = container.getDropdown("Time Format");
        timeFormatDropdown.selectOptionByValue(timeFormat.getFormat());

    }

    public String getTimeFormat() {
        Dropdown timeFormatDropdown = container.getDropdown("Time Format");
        return timeFormatDropdown.getValueByAttribute();

    }

    public Display getDisplay() {
        if (this.display != null)
            return this.display;
        else
            return new Display();
    }


}
