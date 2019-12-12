package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonApplicationServicesFieldActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.dataVerifyEnums.CertificateSubjectDefaultsFieldActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 1/7/2015.
 */
public class RBACAlteonApplicationServicesFieldVerifyTests extends RBACTestBase {

    CertificateSubjectDefaultsFieldActions certificateSubjectDefaultsFieldAction = CertificateSubjectDefaultsFieldActions.COUNTRY_NAME;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SSLCertificateSubjectDefaults Field Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "certificateSubjectDefaultsFieldAction", "deviceState", "expectedResult"})
    public void verifySSLCertificateSubjectDefaultsFieldAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("certificateSubjectDefaultsFieldAction", certificateSubjectDefaultsFieldAction.getTextValue().toString());

            if (!(RBACAlteonApplicationServicesFieldActionHandler.verifySSLCertificateRepositoryFieldAction(testProperties))) {
                report.report("The specified Field action is in an incorrect state: " + certificateSubjectDefaultsFieldAction.getTextValue() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SSLCertificateSubjectDefaults Field Action failed: " + certificateSubjectDefaultsFieldAction.getTextValue() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public CertificateSubjectDefaultsFieldActions getCertificateSubjectDefaultsFieldAction() {
        return certificateSubjectDefaultsFieldAction;
    }

    public void setCertificateSubjectDefaultsFieldAction(CertificateSubjectDefaultsFieldActions certificateSubjectDefaultsFieldAction) {
        this.certificateSubjectDefaultsFieldAction = certificateSubjectDefaultsFieldAction;
    }

}
