package com.radware.vision.tests.localization.dp;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.languagetranslator.enums.LanguageFileType;
import com.radware.automation.webui.languagetranslator.enums.LocalizationLanguages;
import com.radware.automation.webui.localization.enums.widgetIdEnums.DpNavigationTabs;
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
public class DPLocalizationTests extends WebUITestBase {

    private String xmlFileName;
    private LocalizationLanguages language;
    private LanguageFileType fileType = LanguageFileType.screen;
    private DpNavigationTabs dpNavigationTab = DpNavigationTabs.CONFIGURATION;
    public TopologyTreeTabs parentTree;

    @Test
    @TestProperties(name = "validate DefensePro Navigation Tree Texts", paramsInclude = {"qcTestId", "language", "fileType", "dpNavigationTab", "deviceName", "parentTree"})
    public void validateDefenseProNavigationTreeTexts() {
        StringBuilder result = new StringBuilder();
        try {
            List<String> ids = new ArrayList<String>();
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), String.valueOf(parentTree), String.valueOf(state), true);
            ids = ((NavigationIdTexts) dpNavigationTab.getTabElement()).getIds();
            setMenuTab(dpNavigationTab);
            LocalizationNavigationParsing localizationNavigationParsing = new LocalizationNavigationParsing();
            result = localizationNavigationParsing.navigateSystemMenu(ids);

            if (result.length() != 0) {
                BaseTestUtils.report("Those texts are not translated correctly:" + result.toString(), Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Page labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void setMenuTab(DpNavigationTabs tab) {
        if (tab.equals(DpNavigationTabs.CONFIGURATION)) {
            LocalizationUtils.clickOnTab(DpNavigationTabs.MONITORING.getTabId());
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

    public DpNavigationTabs getDpNavigationTab() {
        return dpNavigationTab;
    }

    public void setDpNavigationTab(DpNavigationTabs dpNavigationTab) {
        this.dpNavigationTab = dpNavigationTab;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }
}
