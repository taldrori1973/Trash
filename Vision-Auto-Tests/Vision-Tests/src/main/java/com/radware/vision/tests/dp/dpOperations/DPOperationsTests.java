package com.radware.vision.tests.dp.dpOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.DefencePro.dpOperations.DPOperationsHandler;
import com.radware.vision.infra.testhandlers.DefencePro.enums.SignatureTypes;
import com.radware.vision.infra.testhandlers.DefencePro.enums.UpdateFromSource;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import testhandlers.Device;

import java.awt.*;
import java.util.HashMap;

import static com.radware.vision.infra.testhandlers.DefencePro.dpOperations.DPOperationsHandler.printYellowMessage;

/**
 * Created by stanislava on 3/18/2015.
 */
public class DPOperationsTests extends RBACTestBase {
    String fileName;
    String fileNameForSecuritySignature;
    String saveAsFileName;
    ExportPolicyDownloadTo uploadFrom = ExportPolicyDownloadTo.Client;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    DeviceState deviceState = DeviceState.Lock;
    boolean includePrivateKeys = false;
    HashMap<String, String> testProperties = new HashMap<String, String>();
    String fileDownloadPath = fixFileDownloadPath();
    String scalarNamesList;
    String scalarValuesToVerify;
    SignatureTypes signatureType = SignatureTypes.RADWARE_SIGNATURES;
    UpdateFromSource updateFromSource = UpdateFromSource.UPDATE_FROM_RADWARE;
    String messageToVerify;
    String timePeriodToVerify;

    @Test
    @TestProperties(name = "import configuration File", paramsInclude = {"qcTestId", "parentTree", "deviceName", "deviceState", "uploadFrom", "fileName",
            "fileDownloadPath", "scalarNamesList", "scalarValuesToVerify"})
    public void importConfigurationFile() throws AWTException {
        try {
            setTestPropertiesBase();
            testProperties.put("fileName", fileName);
            testProperties.put("uploadFrom", uploadFrom.getDownloadTo());
            testProperties.put("scalarNamesList", scalarNamesList);
            testProperties.put("scalarValuesToVerify", scalarValuesToVerify);
            testProperties.put("fileDownloadPath", fixFileDownloadPath());

            DPOperationsHandler.importConfigurationFile(getVisionRestClient(), testProperties);
            printYellowMessage();
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("import configuration File operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "export configuration File", paramsInclude = {"qcTestId", "parentTree", "deviceName", "deviceState", "uploadFrom", "includePrivateKeys", "saveAsFileName", "fileDownloadPath"})
    public void exportConfigurationFile() throws AWTException {
        try {
            setTestPropertiesBase();
            RBACHandlerBase.expectedResultRBAC = true;
            testProperties.put("uploadFrom", uploadFrom.getDownloadTo());
            testProperties.put("includePrivateKeys", String.valueOf(includePrivateKeys));
            testProperties.put("saveAsFileName", saveAsFileName);
            testProperties.put("fileDownloadPath", fixFileDownloadPath());

            if (!DPOperationsHandler.exportConfigurationFile(testProperties)) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("export configuration File operation may have been executed incorrectly :", Reporter.FAIL);
            }
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("export configuration File operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "export LogSupport File", paramsInclude = {"qcTestId", "parentTree", "deviceName", "deviceState", "fileDownloadPath", "messageToVerify"})
    public void exportLogSupportFile() throws AWTException {
        try {
            setTestPropertiesBase();
            RBACHandlerBase.expectedResultRBAC = true;
            testProperties.put("fileDownloadPath", fixFileDownloadPath());
            testProperties.put("messageToVerify", messageToVerify);
            //CliConnectionImpl cli = WebUITestBase.getRestTestBase().getRootServerCli();
            if (!DPOperationsHandler.exportLogSupportFile(testProperties, WebUITestBase.getRestTestBase().getRadwareServerCli())) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("export LogSupport File operation may have been executed incorrectly :", Reporter.FAIL);
            }
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("export LogSupport File operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "export TechnicalSupport File", paramsInclude = {"qcTestId", "parentTree", "deviceName", "deviceState", "fileDownloadPath"})
    public void exportTechnicalSupportFile() throws AWTException {
        try {
            setTestPropertiesBase();
            RBACHandlerBase.expectedResultRBAC = true;
            testProperties.put("fileDownloadPath", fixFileDownloadPath());

            if (!DPOperationsHandler.exportTechnicalSupportFile(testProperties, WebUITestBase.getRestTestBase().getRadwareServerCli())) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("export TechnicalSupport File operation may have been executed incorrectly :", Reporter.FAIL);
            }
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("export TechnicalSupport File operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "update Security Signatures", paramsInclude = {"qcTestId", "signatureType", "updateFromSource", "parentTree", "deviceName",
            "deviceState", "fileDownloadPath", "fileNameForSecuritySignature"})
    public void updateSecuritySignatures() throws AWTException {
        try {
            setTestPropertiesBase();
            RBACHandlerBase.expectedResultRBAC = true;
            testProperties.put("signatureType", signatureType.getType());
            testProperties.put("updateFromSource", updateFromSource.getSource());
            testProperties.put("fileDownloadPath", fileDownloadPath);
            testProperties.put("fileName", fileNameForSecuritySignature);

            if (!DPOperationsHandler.updateSecuritySignatures(getVisionRestClient(), testProperties)) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("update Security Signatures operation may have been executed incorrectly :", Reporter.FAIL);
            }
            printYellowMessage();
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("update Security Signatures operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    //=========== Set BASE Properties ======================
    public void setTestPropertiesBase() throws Exception {
        WebUIUtils.widgetsContainer = null;
        if (deviceIp == null) {
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
        } else {
            updateNavigationParser(deviceIp);
        }
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("deviceState", String.valueOf(deviceState));
        RBACHandlerBase.expectedResultRBAC = expectedResult;
    }
    //======================================================

    private String fixFileDownloadPath() {
        if (FileUtils.isLinux()) {
            return "/var/lib/jenkins/Downloads/";
        } else {
            return System.getProperty("user.home").concat(FileUtils.getFileSeparator()).concat("Downloads").concat(FileUtils.getFileSeparator());
        }
    }

    public String getFileNameForSecuritySignature() {
        return fileNameForSecuritySignature;
    }

    @ParameterProperties(description = "Please provide the <fileName> - leave Empty to select default file")
    public void setFileNameForSecuritySignature(String fileNameForSecuritySignature) {
        this.fileNameForSecuritySignature = fileNameForSecuritySignature;
    }

    public String getTimePeriodToVerify() {
        return timePeriodToVerify;
    }

    @ParameterProperties(description = "Specify time Period to verify last RSA signature update (in seconds)! for RSA only !")
    public void setTimePeriodToVerify(String timePeriodToVerify) {
        this.timePeriodToVerify = timePeriodToVerify;
    }

    public String getMessageToVerify() {
        return messageToVerify;
    }

    @ParameterProperties(description = "Please, provide a <message> to look for in Exported log file.")
    public void setMessageToVerify(String messageToVerify) {
        this.messageToVerify = messageToVerify;
    }

    public UpdateFromSource getUpdateFromSource() {
        return updateFromSource;
    }

    public void setUpdateFromSource(UpdateFromSource updateFromSource) {
        this.updateFromSource = updateFromSource;
    }

    public SignatureTypes getSignatureType() {
        return signatureType;
    }

    public void setSignatureType(SignatureTypes signatureType) {
        this.signatureType = signatureType;
    }

    public String getScalarNamesList() {
        return scalarNamesList;
    }

    @ParameterProperties(description = "Specify list of Scalars You want to validate. Fields must be separated by <,>.")
    public void setScalarNamesList(String scalarNamesList) {
        this.scalarNamesList = scalarNamesList;
    }

    public String getScalarValuesToVerify() {
        return scalarValuesToVerify;
    }

    @ParameterProperties(description = "Specify list of Expected Values according to Scalars order. Fields must be separated by <,>.")
    public void setScalarValuesToVerify(String scalarValuesToVerify) {
        this.scalarValuesToVerify = scalarValuesToVerify;
    }

    public String getFileDownloadPath() {
        return fileDownloadPath;
    }

    @ParameterProperties(description = "Path, the file is going to be saved at!(in the following format <C:\\Users\\stanislava\\Downloads\\>)")
    public void setFileDownloadPath(String fileDownloadPath) {
        this.fileDownloadPath = fileDownloadPath;
    }


    public String getFileName() {
        return fileName;
    }

    @ParameterProperties(description = "Please provide the <fileName> (f.e. <testFileName.txt>)")
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public ExportPolicyDownloadTo getUploadFrom() {
        return uploadFrom;
    }

    @ParameterProperties(description = "Please specify the <uploadFrom> target")
    public void setUploadFrom(ExportPolicyDownloadTo uploadFrom) {
        this.uploadFrom = uploadFrom;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }

    public boolean isIncludePrivateKeys() {
        return includePrivateKeys;
    }

    public void setIncludePrivateKeys(boolean includePrivateKeys) {
        this.includePrivateKeys = includePrivateKeys;
    }

    public String getSaveAsFileName() {
        return saveAsFileName;
    }

    @ParameterProperties(description = "Please provide save as <fileName> to save on the server side (f.e. <testFileName.txt>)")
    public void setSaveAsFileName(String saveAsFileName) {
        this.saveAsFileName = saveAsFileName;
    }
}
