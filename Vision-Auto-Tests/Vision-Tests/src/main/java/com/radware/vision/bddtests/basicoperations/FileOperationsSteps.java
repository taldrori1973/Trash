package com.radware.vision.bddtests.basicoperations;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.infra.testhandlers.baseoperations.FileOperationsHandler;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class FileOperationsSteps {


    /**
     *
     * @param fileName
     */
    @When("^Delete downloaded file with name \"(.*)\"$")
    public void deletedFile(String fileName) {
        FileOperationsHandler.deleteDownloadedFile(fileName);
    }

    /**
     *
     * @param fileName
     */
    @Then("^Validate Existence downloaded file with name \"(.*)\"$")
    public void existenceFile(String fileName) {
        FileOperationsHandler.validateDownloadedFileExistence(fileName);
    }

    /**
     *
     * @param fileName
     * @param expectedSize
     */
    @Then("^Validate downloaded file size with name \"(.*)\" equal to (\\d+)$")
    public void validateDownloadedFileSize(String fileName, long expectedSize) {
        FileOperationsHandler.validateDownloadedFileSize(fileName,expectedSize);
    }


    @And("^scroll Into View to label \"([^\"]*)\"(?: with params \"([^\"]*)\")?$")
    public void scrollIntoViewToLabel(String label, String params){
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        WebUIUtils.scrollIntoView(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
    }
}
