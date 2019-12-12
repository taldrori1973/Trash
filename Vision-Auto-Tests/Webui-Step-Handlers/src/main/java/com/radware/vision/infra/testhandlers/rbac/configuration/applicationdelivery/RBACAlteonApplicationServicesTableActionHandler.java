package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.caching.Policy.Policy;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.caching.urlRuleLists.URLRuleLists;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.compression.browserExceptionsRuleList.BrowserExceptionsRuleList;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.compression.urlExceptionsRuleList.URLExceptionsRuleList;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.contentModificationRuleList.ContentModificationRuleList;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.sip.flexiRules.FlexiRules;
import com.radware.automation.webui.webpages.configuration.appDelivery.appServices.sip.mediaPortalNAT.MediaPortalNAT;
import com.radware.automation.webui.webpages.configuration.appDelivery.ssl.certificateRepository.CertificateRepository;
import com.radware.automation.webui.webpages.configuration.appDelivery.ssl.certificateRepository.certificateGroups.CertificateGroups;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.utils.enums.DeviceType;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonApplicationServicesTableActionHandler extends RBACHandlerBase {
    // HTTP Caching
    public static boolean verifyHTTPCachingPolicyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Policy policy = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mCaching().mPolicy();
        policy.openPage();

        WebUITable table = policy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpCachingPolicyTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHTTPCachingURLRuleListsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        URLRuleLists urlRuleLists = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mCaching().mURLRuleLists();
        urlRuleLists.openPage();

        WebUITable table = urlRuleLists.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpCachingURLRuleListsTableAction"), expectedResultRBAC);
        return result;
    }

    //HTTP Compression
    public static boolean verifyHTTPCompressionPolicyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.appDelivery.appServices.http.compression.policy.Policy policy = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mCompression().mPolicy();
        policy.openPage();

        WebUITable table = policy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpCompressionPolicyTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHTTPCompressionURLExceptionsRuleListTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        URLExceptionsRuleList urlExceptionsRuleList = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mCompression().mURLExceptionsRuleList();
        urlExceptionsRuleList.openPage();

        WebUITable table = urlExceptionsRuleList.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpCompressionURLExceptionsRuleListsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHTTPCompressionBrowserExceptionsRuleListTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        BrowserExceptionsRuleList browserExceptionsRuleList = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mCompression().mBrowserExceptionsRuleList();
        browserExceptionsRuleList.openPage();

        WebUITable table = browserExceptionsRuleList.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpCompressionBrowserExceptionsRuleListTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHttpContentModificationRuleListTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ContentModificationRuleList contentModificationRuleList = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mHTTP().mContentModificationRuleList();
        contentModificationRuleList.openPage();

        WebUITable table = contentModificationRuleList.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpContentModificationRuleListTableAction"), expectedResultRBAC);
        return result;
    }

    //SSL
    public static boolean verifySSLCertificateGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        WebUITable table = null;

        CertificateGroups certificateGroupsLinkProof = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mSSL().mCertificateRepository().mCertificateGroups();
        certificateGroupsLinkProof.openPage();
        table = certificateGroupsLinkProof.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslCertificateGroupsTableAction"), expectedResultRBAC);
        return result;
    }


    public static boolean verifySSLCertificateRepositoryTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        WebUITable table;

        if (DeviceType.Alteon.getDeviceType().contains(testProperties.get("deviceTypeCurrent"))) {
            CertificateRepository certificateRepositoryAlteon = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mSSL().mCertificateRepository();
            certificateRepositoryAlteon.openPage();
            table = certificateRepositoryAlteon.getTable();
        } else if (DeviceType.LinkProof.getDeviceType().contains(testProperties.get("deviceTypeCurrent"))) {
            CertificateRepository certificateRepositoryLinkProof = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mSSL().mCertificateRepository();
            certificateRepositoryLinkProof.openPage();
            table = certificateRepositoryLinkProof.getTable();
        } else {
            throw new IllegalArgumentException();
        }

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslCertificateRepositoryTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySSLPolicyClientAuthenticationPolicyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.appDelivery.appServices.ssl.sslPolicy.clientAuthenticationPolicy.ClientAuthenticationPolicy clientAuthenticationPolicy = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mSSL().mSSLPolicy().mClientAuthenticationPolicy();
        clientAuthenticationPolicy.openPage();

        WebUITable table = clientAuthenticationPolicy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslPolicyClientAuthenticationPolicyTableAction"), expectedResultRBAC);
        return result;
    }

    //SIP
    public static boolean verifySIPMediaPortalNATTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        MediaPortalNAT mediaPortalNAT = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mSIP().mMediaPortalNAT();
        mediaPortalNAT.openPage();

        WebUITable table = mediaPortalNAT.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sipMediaPortalNATTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySIPFlexiRulesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        FlexiRules flexiRules = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAppServices().mSIP().mFlexiRules();
        flexiRules.openPage();

        WebUITable table = flexiRules.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sipFlexiRulesTableAction"), expectedResultRBAC);
        return result;
    }

}
