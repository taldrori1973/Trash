package com.radware.vision.bddtests.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.mailservice.enums.EmailStatus;
import com.radware.vision.infra.testhandlers.EmailHandler;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;

import java.util.List;

import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;

public class EmailSteps {


    /**
     * by default will connect to VisionQA3@radware.com
     */

    @Then("^Verify Last Unread Email$")
    public void verifyEmailReceivedFromWithSubjectMessageBodyAttachedFileExtensionWaitForUnreadEmail(List<EmailInputs> emailInputs) throws Exception {
        EmailHandler emailHandler = new EmailHandler();

        for (int i = 0; i < emailInputs.size(); i++) {
            if (emailInputs.get(i).email != null)
                emailHandler = new EmailHandler(emailInputs.get(i).email, emailInputs.get(i).password);
            try {
                if (!emailHandler.verifyLastUnreadEmail(emailInputs.get(i).sender, emailInputs.get(i).subject, emailInputs.get(i).body, emailInputs.get(i).fileExtension, emailInputs.get(i).waitForUnreadEmail)) {
                    BaseTestUtils.report("Email Did Not Receive from " + emailInputs.get(i).sender, Reporter.FAIL);
                }
            } catch (Exception e) {
                addErrorMessage("In Email " + emailInputs.get(i).email + ": " + e.getMessage());
            }
            emailHandler = new EmailHandler();
        }
        reportErrors();
    }

    /**
     * if @emailAndPass equal to null validation will be done with -->VisionQA3@radware.com
     * <p>
     * Uses:
     * <p>
     * 1- Validate if specif row exist-->Given A table or rows and header, will check if that row exist in the csv file
     * <p>
     * 2- Validate rows number -->
     * |rowsNumber|offset|
     * |      10  |  2   |
     * offset is optional
     *
     * @param emailStatus
     * @param emailAndPass   optional value. it should be like this --> automation@radware.com|1234
     * @param fileNamePrefix
     * @param dataTable
     */

    @Then("^Verify Last (READ|UNREAD) Email(?: \"(.*)\")? file prefix \"(.*)\"$")
    public void verifyLastEmailFileContent(EmailStatus emailStatus, String emailAndPass, String fileNamePrefix, DataTable dataTable) {
        EmailHandler emailHandler = new EmailHandler();
        if (emailAndPass != null && !emailAndPass.isEmpty()) {
            emailHandler = new EmailHandler(emailAndPass.split("|")[0], emailAndPass.split("|")[1]);
        }
        try {
            emailHandler.validateLastEmailFileContent(emailStatus, fileNamePrefix, dataTable.asMaps(String.class, String.class));
            reportErrors();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    private class EmailInputs {
        String email, password, sender, subject, body, fileExtension;
        int waitForUnreadEmail;
    }


}
