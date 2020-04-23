package com.radware.vision.tests.localization.alteon;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.languagetranslator.enums.LanguageFileType;
import com.radware.automation.webui.languagetranslator.enums.LocalizationLanguages;
import com.radware.automation.webui.localization.enums.widgetIdEnums.AlteonNavigationTabs;
import com.radware.automation.webui.localization.enums.widgetIdEnums.visionnavigation.NavigationIdTexts;
import com.radware.automation.webui.localization.impl.LocalizationNavigationParsing;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.tests.localization.Utils.LocalizationUtils;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by StanislavA on 5/27/2015.
 */
public class AlteonLocalizationTests extends WebUITestBase {

    private String xmlFileName;
    private LocalizationLanguages language;
    private LanguageFileType fileType = LanguageFileType.screen;
    private AlteonNavigationTabs alteonNavigationTab = AlteonNavigationTabs.CONFIGURATION;
    public TopologyTreeTabs parentTree;

    @Test
    @TestProperties(name = "validate alteon Navigation Tree Texts", paramsInclude = {"qcTestId", "language", "fileType", "alteonNavigationTab", "deviceName", "parentTree"})
    public void validateAlteonNavigationTreeTexts() {
        StringBuilder result = new StringBuilder();
        try {
            List<String> ids = new ArrayList<String>();
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), String.valueOf(parentTree), String.valueOf(state), true);
            ids = ((NavigationIdTexts) alteonNavigationTab.getTabElement()).getIds();
            setMenuTab(alteonNavigationTab);

            LocalizationNavigationParsing localizationNavigationParsing = new LocalizationNavigationParsing();
            result = localizationNavigationParsing.navigateSystemMenu(ids);

            if (result.length() != 0) {
                BaseTestUtils.report("Those texts are not translated correctly:" + result.toString(), Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Page labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void setMenuTab(AlteonNavigationTabs tab) {
        if (tab.equals(AlteonNavigationTabs.CONFIGURATION)) {
            LocalizationUtils.clickOnTab(AlteonNavigationTabs.MONITORING.getTabId());
        }
        LocalizationUtils.clickOnTab(tab.getTabId());
    }

    public String getXmlFileName() {
        return xmlFileName;
    }

    public void setXmlFileName(String xmlFileName) {
        this.xmlFileName = xmlFileName;
    }

    public LocalizationLanguages getLanguage() {
        return language;
    }

    public void setLanguage(LocalizationLanguages language) {
        this.language = language;
    }

    public LanguageFileType getFileType() {
        return fileType;
    }

    public void setFileType(LanguageFileType fileType) {
        this.fileType = fileType;
    }

    public AlteonNavigationTabs getAlteonNavigationTab() {
        return alteonNavigationTab;
    }

    public void setAlteonNavigationTab(AlteonNavigationTabs alteonNavigationTab) {
        this.alteonNavigationTab = alteonNavigationTab;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }
}
