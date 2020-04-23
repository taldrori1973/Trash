package com.radware.vision.tests.BasicOperations.language;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.languagetranslator.enums.LanguageFileType;
import com.radware.automation.webui.languagetranslator.enums.LocalizationLanguages;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.LanguageEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.List;

/**
 * Created by urig on 5/21/2015.
 */
public class LanguageOperations extends WebUITestBase {

    LanguageEnum language = LanguageEnum.English;
    private LocalizationLanguages targetLanguage;
    private LanguageFileType fileType = LanguageFileType.screen;

    @Test
    @TestProperties(name = "Switch Displayed Language", paramsInclude = {"qcTestId", "language", "targetLanguage", "fileType"})
    public void switchDisplayedLanguage() {
        try {
            setLocalizationProperties();
            BasicOperationsHandler.openUserInfoPanel();
            WebElement languageMenuBar = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStrings.getLanguageMenuBar()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            ComponentLocator locator = new ComponentLocator(How.XPATH, ".//option");
            List<WebElement> languageDropdownList = WebUIUtils.fluentWaitMultiple(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false, languageMenuBar);
            languageDropdownList.get(language.ordinal()).click();
         } catch(Exception e) {
            BaseTestUtils.report("Failed to switch language: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set Target Language", paramsInclude = {"qcTestId", "targetLanguage", "fileType"})
    public void setTargetLanguage() {
        try {
            setLocalizationProperties();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to switch language: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void setLocalizationProperties() {
        WebUIUtils.localizationLanguage = targetLanguage;
        WebUIUtils.languageFileType = fileType;
    }

    public LanguageEnum getLanguage() {
        return language;
    }

    public void setLanguage(LanguageEnum language) {
        this.language = language;
    }

    public LocalizationLanguages getTargetLanguage() {
        return targetLanguage;
    }

    public void setTargetLanguage(LocalizationLanguages targetLanguage) {
        this.targetLanguage = targetLanguage;
    }

    public LanguageFileType getFileType() {
        return fileType;
    }

    public void setFileType(LanguageFileType fileType) {
        this.fileType = fileType;
    }
}
