package com.radware.vision.tests.fileOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.vision.base.WebUITestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.File;

/**
 * Created by aviH on 8/10/2015.
 */
public class FileOperationsTests extends WebUITestBase {

    String filePath = System.getProperty("user.home") + File.separator + "Downloads" + File.separator;
    String serverFilePath = "/opt/radware";
    String fileName;
    String expectedValue;
    String findTimeOut;

    @Test
    @TestProperties(name = "Find File", paramsInclude = {"qcTestId", "filePath", "fileName", "findTimeOut"})
    public void findFileByPartialName() {
        try {
            if(FileUtils.findFileByPartialName(filePath, fileName, Long.parseLong(findTimeOut)*1000).equals("")){
                BaseTestUtils.report("Test has failed finding: " + fileName + " " + "file!", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + fileName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }
    @Test
    @TestProperties(name = "Validate File Content", paramsInclude = {"qcTestId", "filePath", "fileName", "expectedValue"})
    public void validateFileContentByPartialName() {
        try {
            fileName = filePath + File.separator + fileName;
            String actualContent = FileUtils.getFileContent(fileName);
            if (actualContent == null) {
                BaseTestUtils.report("Test has failed finding: " + fileName, Reporter.FAIL);
            } else {
                actualContent = actualContent.replace("\r\n", " ");
                actualContent = actualContent.replace("\n\r", " ");
                actualContent = actualContent.replace("\n", " ");
                actualContent = actualContent.replace("\r", " ");
                if (!actualContent.equals(expectedValue)) {
                    BaseTestUtils.report("Server File Validation Failed. Expected Content is: " + expectedValue + ", Actual Content is:" + actualContent, Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + fileName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Find Server File", paramsInclude = {"qcTestId", "serverFilePath", "fileName"})
    public void findServerFileByPartialName() {
        try {
            if (FileUtils.findServerFileByPartialName(getLinuxServerCredential(), serverFilePath, fileName) == null) {
                BaseTestUtils.report("Test has failed finding: " + fileName, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + fileName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Validate Server File Content", paramsInclude = {"qcTestId", "serverFilePat9h", "fileName", "expectedValue"})
    public void validateServerFileContentByPartialName() {
        try {
            String actualContent = FileUtils.getServerFileContent(getLinuxServerCredential(), serverFilePath, fileName);
            if (actualContent == null) {
                BaseTestUtils.report("Test has failed finding: " + fileName, Reporter.FAIL);
            } else {
                actualContent = actualContent.replace("\r", " ");
                actualContent = actualContent.replace("\n\r", " ");
                if (!actualContent.equals(expectedValue)) {
                    BaseTestUtils.report("Server File Validation Failed. Expected Content is: " + expectedValue + ", Actual Content is:" + actualContent, Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + fileName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete File", paramsInclude = {"qcTestId", "filePath", "fileName"})
    public void deleteFile() {
        try {
            FileUtils.deleteFile(filePath, fileName);
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + fileName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Directory Content", paramsInclude = {"qcTestId", "filePath"})
    public void deleteDirectoryContent() {
        try {
            FileUtils.deleteDirContent(filePath);
        } catch (Exception e) {
            BaseTestUtils.report("Test has failed finding: " + filePath + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getServerFilePath() { return serverFilePath; }
    public void setServerFilePath(String serverFilePath) { this.serverFilePath = serverFilePath; }

    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getExpectedValue() {
        return expectedValue;
    }
    public void setExpectedValue(String expectedValue) {
        this.expectedValue = expectedValue;
    }

    public String getFindTimeOut() {
        return findTimeOut;
    }
    @ParameterProperties(description = "Please, specify time out(in seconds).")
    public void setFindTimeOut(String findTimeOut) {
        this.findTimeOut = findTimeOut;
    }
}
