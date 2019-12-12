package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonApplicationServicesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ContentClassesTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ImportBaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonApplicationServicesTableActionTests extends RBACTestBase {

    BaseTableActions httpCachingPolicyTableAction = BaseTableActions.NEW;
    ContentClassesTableActions httpCachingURLRuleListsTableAction = ContentClassesTableActions.NEW;
    BaseTableActions httpCompressionPolicyTableAction = BaseTableActions.NEW;
    ContentClassesTableActions httpCompressionURLExceptionsRuleListsTableAction = ContentClassesTableActions.NEW;
    ContentClassesTableActions httpCompressionBrowserExceptionsRuleListTableAction = ContentClassesTableActions.NEW;
    ContentClassesTableActions httpContentModificationRuleListTableAction = ContentClassesTableActions.NEW;

    BaseTableActions sslCertificateGroupsTableAction = BaseTableActions.NEW;
    ImportBaseTableActions sslCertificateRepositoryTableAction = ImportBaseTableActions.NEW;
    BaseTableActions sslPolicyClientAuthenticationPolicyTableAction = BaseTableActions.NEW;
    BaseTableActions sipMediaPortalNATTableAction = BaseTableActions.NEW;
    BaseTableActions sipFlexiRulesTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify HttpCachingPolicy Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpCachingPolicyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpCachingPolicyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpCachingPolicyTableAction", httpCachingPolicyTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHTTPCachingPolicyTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpCachingPolicyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpCachingPolicy Disabled Table Action failed: " + httpCachingPolicyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HttpCachingURLRuleLists Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpCachingURLRuleListsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpCachingURLRuleListsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpCachingURLRuleListsTableAction", httpCachingURLRuleListsTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHTTPCachingURLRuleListsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpCachingURLRuleListsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpCachingURLRuleLists Disabled Table Action failed: " + httpCachingURLRuleListsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HttpCompressionPolicy Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpCompressionPolicyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpCompressionPolicyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpCompressionPolicyTableAction", httpCompressionPolicyTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHTTPCompressionPolicyTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpCompressionPolicyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpCompressionPolicy Disabled Table Action failed: " + httpCompressionPolicyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HttpCompressionURLExceptionsRuleLists Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpCompressionURLExceptionsRuleListsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpCompressionURLExceptionsRuleListDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpCompressionURLExceptionsRuleListsTableAction", httpCompressionURLExceptionsRuleListsTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHTTPCompressionURLExceptionsRuleListTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpCompressionURLExceptionsRuleListsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpCompressionURLExceptionsRuleLists Disabled Table Action failed: " + httpCompressionURLExceptionsRuleListsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HttpCompressionBrowserExceptionsRuleList Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpCompressionBrowserExceptionsRuleListTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpCompressionBrowserExceptionsRuleListDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpCompressionBrowserExceptionsRuleListTableAction", httpCompressionBrowserExceptionsRuleListTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHTTPCompressionBrowserExceptionsRuleListTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpCompressionBrowserExceptionsRuleListTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpCompressionBrowserExceptionsRuleList Disabled Table Action failed: " + httpCompressionBrowserExceptionsRuleListTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HttpContentModificationRuleList Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpContentModificationRuleListTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHttpContentModificationRuleListDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpContentModificationRuleListTableAction", httpContentModificationRuleListTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifyHttpContentModificationRuleListTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + httpContentModificationRuleListTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify HttpContentModificationRuleList Disabled Table Action failed: " + httpContentModificationRuleListTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    //========== SSL ===========
    @Test
    @TestProperties(name = "verify SSLCertificateGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "sslCertificateGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLCertificateGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslCertificateGroupsTableAction", sslCertificateGroupsTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifySSLCertificateGroupsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sslCertificateGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SSLCertificateGroups Disabled Table Action failed: " + sslCertificateGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SSLCertificateRepository Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "sslCertificateRepositoryTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLCertificateRepositoryDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslCertificateRepositoryTableAction", sslCertificateRepositoryTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifySSLCertificateRepositoryTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sslCertificateRepositoryTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SSLCertificateRepository Disabled Table Action failed: " + sslCertificateRepositoryTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SSLClientAuthenticationPolicy Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "sslPolicyClientAuthenticationPolicyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLClientAuthenticationPolicyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslPolicyClientAuthenticationPolicyTableAction", sslPolicyClientAuthenticationPolicyTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifySSLPolicyClientAuthenticationPolicyTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sslPolicyClientAuthenticationPolicyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SSLClientAuthenticationPolicy Disabled Table Action failed: " + sslPolicyClientAuthenticationPolicyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    //=========== SIP ===================
    @Test
    @TestProperties(name = "verify SIPMediaPortalNAT Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "sipMediaPortalNATTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySIPMediaPortalNATDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sipMediaPortalNATTableAction", sipMediaPortalNATTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifySIPMediaPortalNATTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sipMediaPortalNATTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SIPMediaPortalNAT Disabled Table Action failed: " + sipMediaPortalNATTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SIPFlexiRules Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "sipFlexiRulesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySIPFlexiRulesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sipFlexiRulesTableAction", sipFlexiRulesTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationServicesTableActionHandler.verifySIPFlexiRulesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sipFlexiRulesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SIPFlexiRules Disabled Table Action failed: " + sipFlexiRulesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public ImportBaseTableActions getSslCertificateRepositoryTableAction() {
        return sslCertificateRepositoryTableAction;
    }

    public void setSslCertificateRepositoryTableAction(ImportBaseTableActions sslCertificateRepositoryTableAction) {
        this.sslCertificateRepositoryTableAction = sslCertificateRepositoryTableAction;
    }

    public BaseTableActions getHttpCachingPolicyTableAction() {
        return httpCachingPolicyTableAction;
    }

    public void setHttpCachingPolicyTableAction(BaseTableActions httpCachingPolicyTableAction) {
        this.httpCachingPolicyTableAction = httpCachingPolicyTableAction;
    }

    public ContentClassesTableActions getHttpCachingURLRuleListsTableAction() {
        return httpCachingURLRuleListsTableAction;
    }

    public void setHttpCachingURLRuleListsTableAction(ContentClassesTableActions httpCachingURLRuleListsTableAction) {
        this.httpCachingURLRuleListsTableAction = httpCachingURLRuleListsTableAction;
    }

    public BaseTableActions getHttpCompressionPolicyTableAction() {
        return httpCompressionPolicyTableAction;
    }

    public void setHttpCompressionPolicyTableAction(BaseTableActions httpCompressionPolicyTableAction) {
        this.httpCompressionPolicyTableAction = httpCompressionPolicyTableAction;
    }

    public ContentClassesTableActions getHttpCompressionURLExceptionsRuleListsTableAction() {
        return httpCompressionURLExceptionsRuleListsTableAction;
    }

    public void setHttpCompressionURLExceptionsRuleListsTableAction(ContentClassesTableActions httpCompressionURLExceptionsRuleListsTableAction) {
        this.httpCompressionURLExceptionsRuleListsTableAction = httpCompressionURLExceptionsRuleListsTableAction;
    }

    public ContentClassesTableActions getHttpCompressionBrowserExceptionsRuleListTableAction() {
        return httpCompressionBrowserExceptionsRuleListTableAction;
    }

    public void setHttpCompressionBrowserExceptionsRuleListTableAction(ContentClassesTableActions httpCompressionBrowserExceptionsRuleListTableAction) {
        this.httpCompressionBrowserExceptionsRuleListTableAction = httpCompressionBrowserExceptionsRuleListTableAction;
    }

    public ContentClassesTableActions getHttpContentModificationRuleListTableAction() {
        return httpContentModificationRuleListTableAction;
    }

    public void setHttpContentModificationRuleListTableAction(ContentClassesTableActions httpContentModificationRuleListTableAction) {
        this.httpContentModificationRuleListTableAction = httpContentModificationRuleListTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public BaseTableActions getSslCertificateGroupsTableAction() {
        return sslCertificateGroupsTableAction;
    }

    public void setSslCertificateGroupsTableAction(BaseTableActions sslCertificateGroupsTableAction) {
        this.sslCertificateGroupsTableAction = sslCertificateGroupsTableAction;
    }

    public BaseTableActions getSslPolicyClientAuthenticationPolicyTableAction() {
        return sslPolicyClientAuthenticationPolicyTableAction;
    }

    public void setSslPolicyClientAuthenticationPolicyTableAction(BaseTableActions sslPolicyClientAuthenticationPolicyTableAction) {
        this.sslPolicyClientAuthenticationPolicyTableAction = sslPolicyClientAuthenticationPolicyTableAction;
    }

    public BaseTableActions getSipMediaPortalNATTableAction() {
        return sipMediaPortalNATTableAction;
    }

    public void setSipMediaPortalNATTableAction(BaseTableActions sipMediaPortalNATTableAction) {
        this.sipMediaPortalNATTableAction = sipMediaPortalNATTableAction;
    }

    public BaseTableActions getSipFlexiRulesTableAction() {
        return sipFlexiRulesTableAction;
    }

    public void setSipFlexiRulesTableAction(BaseTableActions sipFlexiRulesTableAction) {
        this.sipFlexiRulesTableAction = sipFlexiRulesTableAction;
    }
}

