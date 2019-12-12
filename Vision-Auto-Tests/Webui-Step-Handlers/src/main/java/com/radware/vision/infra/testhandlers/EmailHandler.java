package com.radware.vision.infra.testhandlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.mailservice.MailServiceBindUtils;
import com.radware.automation.tools.mailservice.enums.EmailStatus;
import com.radware.automation.tools.mailservice.enums.MessagePropertyType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.automation.tools.basetest.Reporter;
import microsoft.exchange.webservices.data.core.enumeration.service.ConflictResolutionMode;
import microsoft.exchange.webservices.data.core.exception.service.local.ServiceLocalException;
import microsoft.exchange.webservices.data.core.service.item.EmailMessage;
import microsoft.exchange.webservices.data.property.complex.Attachment;
import microsoft.exchange.webservices.data.property.complex.FileAttachment;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.*;

import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;


public class EmailHandler {

    public static int DEFAULT_WAIT_TIME_FOR_UNREAD_MAIL = 30;
    private final String RADWARE_EMAIL_URL = "https://webmail.radware.com/ews/Exchange.asmx";
    private MailServiceBindUtils msEmail;
    private String userName;
    private String password;

    public EmailHandler() {
        this("VisionQA3@radware.com", "radwareAuto3");
    }

    public EmailHandler(String userName, String password) {
        this.userName = userName;
        this.password = password;
        this.msEmail = MailServiceBindUtils.createInstance(userName, password, RADWARE_EMAIL_URL, userName);
    }

    /**
     * @param sender
     * @param subject
     * @param messageBody
     * @param fileExtension
     * @param waitForLastUnreadEmailInSeconds default is 30
     * @return in case every thing matches returns true else false
     */

    public boolean verifyLastUnreadEmail(String sender, String subject, String messageBody, String fileExtension, int waitForLastUnreadEmailInSeconds) throws ServiceLocalException, InterruptedException {


        EmailMessage lastEmail = msEmail.getLastEmail();

        //wait's until gets new unread email
        LocalDateTime waitTime = LocalDateTime.now().plusSeconds(waitForLastUnreadEmailInSeconds);
        while (lastEmail == null && waitTime.isAfter(LocalDateTime.now())
                || (lastEmail.getIsRead() && waitTime.isAfter(LocalDateTime.now()))) {
            BasicOperationsHandler.delay(3);
            lastEmail = msEmail.getLastEmail();
        }
        try {
            if (lastEmail == null) {
                return false;
            }

            if (lastEmail.getIsRead()) {
                BaseTestUtils.report("Last Email Received In " + lastEmail.getDateTimeReceived().toString(), Reporter.FAIL);
                return false;
            } else {
                String actual = "";
                if(sender != null)
                {
                    actual = msEmail.getPropertyContent(lastEmail, MessagePropertyType.SENDER_NAME).toString();
                    if (!sender.equals(actual)) {
                        BaseTestUtils.report("Last Unread Message Sender's Is Equal To :" + actual + " but the Expected is: " + sender, Reporter.FAIL);
                        return false;
                    }
                }
                actual = msEmail.getPropertyContent(lastEmail, MessagePropertyType.SUBJECT).toString();
                if (!subject.equals(actual)) {
                    BaseTestUtils.report("Last Unread Message Subject's Is Equal To :" + actual + " but the Expected is: " + subject, Reporter.FAIL);
                    return false;
                }
                if(messageBody != null && !messageBody.equals("")) {
                    actual = msEmail.getMessageContent(lastEmail);
                    if (!messageBody.equals(actual)) {
                        BaseTestUtils.report("Last Unread Message Body's Is Equal To :" + actual + " but the Expected is: " + messageBody, Reporter.FAIL);
                        return false;
                    }
                }

                if (fileExtension != null && !fileExtension.equals("")) {
                    Attachment attachedFile;
                    attachedFile = msEmail.getEmailAttachments(lastEmail).get(0);
                    actual = attachedFile.getContentType();
                    if (!actual.contains(fileExtension)) {
                        BaseTestUtils.report("Last Unread Message Attached File Content Type Is Equal To :" + actual + " but the Expected is: " + fileExtension, Reporter.FAIL);
                        return false;
                    }
                }
            }

            updateStatus(lastEmail, EmailStatus.READ);


        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return true;
    }

    private void updateStatus(EmailMessage lastEmail, EmailStatus emailStatus) throws Exception {
        lastEmail.setIsRead(emailStatus == EmailStatus.READ ? true : false);
        lastEmail.update(ConflictResolutionMode.AlwaysOverwrite);
    }


    public void validateLastEmailFileContent(EmailStatus emailStatus, String filePrefix, List<Map<String, String>> expected) throws Exception {
        List<EmailMessage> lastEmails = msEmail.getEmailMessages();
        EmailMessage lastReadMessage = null;
        boolean read = emailStatus == EmailStatus.READ ? true : false;
        for (int i = 0; i < lastEmails.size(); i++) {
            if (lastEmails.get(i).getIsRead() == read) {
                lastReadMessage = lastEmails.get(i);
                break;
            }
        }
        if (lastReadMessage == null) {
            addErrorMessage("There is not match email with status " + emailStatus);
            return;
        }
        updateStatus(lastReadMessage, EmailStatus.READ);

        if (lastReadMessage.getHasAttachments()) {
            for (int i = 0; i < lastReadMessage.getAttachments().getCount(); i++) {
                Attachment currentAttachment = lastReadMessage.getAttachments().getPropertyAtIndex(i);
                if (currentAttachment.getName().startsWith(filePrefix)) {
                    FileAttachment fileAttachment = (FileAttachment) currentAttachment;
                    String filePath = new File(".").getCanonicalPath() + File.separator + fileAttachment.getName();
                    try (BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(filePath))) {
                        fileAttachment.load(bufferedOutputStream);

                        List<String> actualLines = Files.readAllLines(Paths.get(filePath));


                        if (actualLines.size() > 0) {
                            //Rows number validation
                            if (expected.get(0).keySet().contains("rowsNumber")) {
                                if (!(Math.abs(actualLines.size() - 1 - Integer.valueOf(expected.get(0).get("rowsNumber"))) <= Integer.valueOf(expected.get(0).getOrDefault("offset", "0"))))
                                    addErrorMessage("Expected : " + expected + "***** Actual rows number :  " + (actualLines.size() - 1));
                            } else {
                                //data validation
                                List<Map<String, String>> actual = new ArrayList<>();
                                List<String> keys = Arrays.asList(actualLines.get(0).split(","));
                                actualLines.stream().skip(1).forEach(line -> {
                                    List<String> columns = Arrays.asList(line.split(","));
                                    Map<String, String> temp = new HashMap();
                                    for (int i1 = 0; i1 < columns.size(); i1++) {
                                        temp.put(keys.get(i1), columns.get(i1));
                                    }
                                    actual.add(temp);
                                });

                                for (int j = 0; j < expected.size(); j++) {
                                    if (!actual.contains(expected.get(j)))
                                        addErrorMessage("Row --- > " + expected.get(j) + " ---> Does not exists in the CSV file \"" + filePrefix + "\"");
                                }
                            }
                        } else {
                            addErrorMessage("The File " + fileAttachment.getName() + "is empty");
                        }
                    }
                    Files.delete(Paths.get(filePath));
                    break;
                } else {
                    addErrorMessage("There is no such file prefix " + filePrefix);
                }
            }

        }
    }
}


