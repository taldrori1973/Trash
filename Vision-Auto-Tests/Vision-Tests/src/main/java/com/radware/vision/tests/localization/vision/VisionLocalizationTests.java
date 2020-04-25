package com.radware.vision.tests.localization.vision;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.languagetranslator.AppShapeScreenSubFolderFactory;
import com.radware.automation.webui.languagetranslator.enums.AppShapeScreenSubFolder;
import com.radware.automation.webui.languagetranslator.enums.DeviceOperations;
import com.radware.automation.webui.languagetranslator.enums.LanguageFileType;
import com.radware.automation.webui.languagetranslator.enums.ResourceType;
import com.radware.automation.webui.localization.enums.widgetIdEnums.VisionNavigationTabs;
import com.radware.automation.webui.localization.enums.widgetIdEnums.visionnavigation.NavigationIdTexts;
import com.radware.automation.webui.localization.impl.DevicePropertySet;
import com.radware.automation.webui.localization.impl.LocalizationDevicePropertiesParsing;
import com.radware.automation.webui.localization.impl.LocalizationNavigationParsing;
import com.radware.automation.webui.localization.impl.LocalizationPageParsing;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.localization.deviceproperties.DevicePropertiesValidation;
import com.radware.vision.tests.localization.Utils.LocalizationUtils;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by urig on 5/17/2015.
 */
public class VisionLocalizationTests extends WebUITestBase{

    String xmlFileName;
    String ignoredDropDownElementIds;
    String ignoredElementItems;
    VisionNavigationTabs visionSettingsTab = VisionNavigationTabs.SYSTEM;
    boolean verboseMode = false;
    AppShapeScreenSubFolder subFolder;
    DeviceOperations deviceOperation = DeviceOperations.SELECT_AN_OPERATION;

    @Override
    public void uiInit() throws Exception {
        super.uiInit();
        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;
      }

    @Test
    @TestProperties(name = "validate Page Labels", paramsInclude = {"qcTestId", "xmlFileName", "ignoredDropDownElementIds", "ignoredElementItems", "verboseMode"})
    public void validateScreenLabels() {
        StringBuilder result = new StringBuilder();
        WebUIUtils.resourceType = ResourceType.VisionDeviceDriverLocation;
        WebUIUtils.screenSubFolder = null;
        List<String> xmlFileNamesList = Arrays.asList(xmlFileName.split(","));
        try {
            LocalizationPageParsing parser = new LocalizationPageParsing(xmlFileNamesList, ignoredDropDownElementIds == null ? "" : ignoredDropDownElementIds, ignoredElementItems == null ? "" : ignoredElementItems, verboseMode);
            result = parser.testPageTexts();
            if (result.length() != 0) {
                String msgPrefix = verboseMode ? "The following elements were tested for translation: " : "Those labels are not translated correctly: ";
                BaseTestUtils.report(msgPrefix + "\n" + result.toString(), !verboseMode ? Reporter.FAIL : Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Page labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Vision Navigation Tree Texts", paramsInclude = {"qcTestId", "visionSettingsTab"})
    public void validateVisionNavigationTreeTexts() {
        StringBuilder result = new StringBuilder();
        try {
            List<String> ids = new ArrayList<String>();
            BasicOperationsHandler.settings();
            ids = ((NavigationIdTexts) visionSettingsTab.getTabElement()).getIds();
            LocalizationUtils.clickOnTab(visionSettingsTab.getTabId());

            LocalizationNavigationParsing localizationNavigationParsing = new LocalizationNavigationParsing();
            result = localizationNavigationParsing.navigateSystemMenu(ids);

            if (result.length() != 0) {
                BaseTestUtils.report("Those texts are not translated correctly:" + result.toString(), Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Page labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate AppShape Screen Labels", paramsInclude = {"qcTestId", "xmlFileName", "ignoredDropDownElementIds", "verboseMode", "subFolder"})
    public void validateAppShapeScreenLabels() {
        StringBuilder result = new StringBuilder();
        try {
            initAppShapeLocalizationProperties(subFolder);
            List<String> xmlFileNamesList = Arrays.asList(xmlFileName.split(","));
            LocalizationPageParsing parser = new LocalizationPageParsing(xmlFileNamesList, ignoredDropDownElementIds == null ? "" : ignoredDropDownElementIds, ignoredElementItems == null ? "" : ignoredElementItems, verboseMode);
            result = parser.testPageTexts();
            if (result.length() != 0) {
                String msgPrefix = verboseMode ? "The following elements were tested for translation: " : "Those labels are not translated correctly: ";
                BaseTestUtils.report(msgPrefix + "\n" + result.toString(), !verboseMode ? Reporter.FAIL : Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Page labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Device Operation Labels", paramsInclude = {"qcTestId", "deviceOperation", "ignoredDropDownElementIds", "verboseMode"})
    public void validateDeviceOperationLabels() {
        StringBuilder result = new StringBuilder();
        WebUIUtils.resourceType = ResourceType.VisionDeviceDriverLocation;
        try {
            WebUIUtils.languageFileType = LanguageFileType.operations;
            List<String> xmlFileNamesList = Arrays.asList(xmlFileName.split(","));
            LocalizationPageParsing parser = new LocalizationPageParsing(xmlFileNamesList, ignoredDropDownElementIds == null ? "" : ignoredDropDownElementIds, ignoredElementItems == null ? "" : ignoredElementItems, verboseMode);
            if (!deviceOperation.getDeviceOperationId().equals("")) {
                result = parser.testElementTexts(deviceOperation);
            } else {
                BaseTestUtils.report("Element labels validation has Failed : no Operation was selected" + result.toString(), Reporter.FAIL);
            }
            if (result.length() != 0) {
                String msgPrefix = verboseMode ? "The following element was tested for translation: " : "Those labels are not translated correctly: ";
                BaseTestUtils.report(msgPrefix + "\n" + result.toString(), !verboseMode ? Reporter.FAIL : Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Element labels validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Device Properties", paramsInclude = {"qcTestId", "ignoredDropDownElementIds", "verboseMode", "deviceName"})
    public void validateDeviceProperties() {
        setFrameworkLocalizationProperties();
        List<DevicePropertySet> propsList = DevicePropertiesValidation.validateDeviceProperties(getDeviceName());
        StringBuilder result = new StringBuilder();

        try {
            LocalizationDevicePropertiesParsing devicePropertiesParsing = new LocalizationDevicePropertiesParsing();

            result = devicePropertiesParsing.testDeviceProperties(propsList, null, ignoredDropDownElementIds == null ? "" : ignoredDropDownElementIds, ignoredElementItems == null ? "" : ignoredElementItems, verboseMode);
            if (result.length() != 0) {
                String msgPrefix = verboseMode ? "The following elements were tested for translation: " : "Those labels are not translated correctly: ";
                BaseTestUtils.report(msgPrefix + "\n" + result.toString(), !verboseMode ? Reporter.FAIL : Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report("deviceProperties validation has Failed :" + result.toString() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void initAppShapeLocalizationProperties(AppShapeScreenSubFolder subFolder) {
        AppShapeScreenSubFolderFactory appShapeScreenSubFolderFactory = new AppShapeScreenSubFolderFactory();
        WebUIUtils.resourceType = ResourceType.AppShapeDeviceDriverLocation;
        WebUIUtils.screenSubFolder = appShapeScreenSubFolderFactory.getAppShapeScreenSubFolder(subFolder);
    }

    public void setFrameworkLocalizationProperties() {
        WebUIUtils.resourceType = ResourceType.FrameworkDeviceDriverLocalization;
    }

    public ResourceType getFrameworkLocalizationProperties() {
        return ResourceType.FrameworkDeviceDriverLocalization;
    }

    public String getIgnoredElementItems() {
        return ignoredElementItems;
    }

    public void setIgnoredElementItems(String ignoredElementItems) {
        this.ignoredElementItems = ignoredElementItems;
    }

    public DeviceOperations getDeviceOperation() {
        return deviceOperation;
    }

    public void setDeviceOperation(DeviceOperations deviceOperation) {
        this.deviceOperation = deviceOperation;
    }

    public AppShapeScreenSubFolder getSubFolder() {
        return subFolder;
    }

    public void setSubFolder(AppShapeScreenSubFolder subFolder) {
        this.subFolder = subFolder;
    }

    public void clickMenuTab(VisionNavigationTabs tab) {
        LocalizationUtils.clickOnTab(tab.getTabId());
    }

    public VisionNavigationTabs getVisionSettingsTab() {
        return visionSettingsTab;
    }

    public void setVisionSettingsTab(VisionNavigationTabs visionSettingsTab) {
        this.visionSettingsTab = visionSettingsTab;
    }

    public String getXmlFileName() {
        return xmlFileName;
    }

    @ParameterProperties(description = "Please supply a list of all device driver files for your test page, seperated by comma ','")
    public void setXmlFileName(String xmlFileName) {
        this.xmlFileName = xmlFileName;
    }

    public String getIgnoredDropDownElementIds() {
        return ignoredDropDownElementIds;
    }

    public void setIgnoredDropDownElementIds(String ignoredDropDownElementIds) {
        this.ignoredDropDownElementIds = ignoredDropDownElementIds;
    }

    public boolean getVerboseMode() {
        return verboseMode;
    }

    public void setVerboseMode(boolean verboseMode) {
        this.verboseMode = verboseMode;
    }
}
