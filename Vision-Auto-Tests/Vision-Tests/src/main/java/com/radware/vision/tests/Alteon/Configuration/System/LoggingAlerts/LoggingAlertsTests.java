package com.radware.vision.tests.Alteon.Configuration.System.LoggingAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.configuration.system.loggingAndAlerts.LoggingAlertsEnums;
import com.radware.automation.webui.webpages.configuration.system.loggingAndAlerts.LoggingAlertsEnums.*;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.LoggingAlertsHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;
/**
 * Created by alexeys on 5/31/2015.
 */
public class LoggingAlertsTests extends AlteonTestBase {

    StatusState showSyslog = StatusState.ENABLE;
    StatusState auditTrail = StatusState.DISABLE;

    StatusState consoleChkBox, spanningTreeChkBox, virtualServicesChkBox, securityChkBox;
    StatusState managementChkBox, highAvailabilityChkBox, globalTrafficRedirectionChkBox;
    StatusState webChkBox, bgpChkBox, rateLimitChkBox, rmonChkBox;
    StatusState sshChkBox, ipv6ChkBox, applicationServicesChkBox;
    StatusState ntpChkBox, ospfChkBox, slbAttackChkBox;
    StatusState systemChkBox, vlanChkBox, filterChkBox;
    StatusState cliChkBox, ipChkBox, synAttackChkBox;

    ManagementNetworks ipVersionHost1 = ManagementNetworks.IPV4;
    ManagementNetworks ipVersionHost2 = ManagementNetworks.IPV4;
    ManagementNetworks ipVersionHost3 = ManagementNetworks.IPV4;
    ManagementNetworks ipVersionHost4 = ManagementNetworks.IPV4;
    ManagementNetworks ipVersionHost5 = ManagementNetworks.IPV4;

    SeverityList severityHost1;
    SeverityList severityHost2;
    SeverityList severityHost3;
    SeverityList severityHost4;
    SeverityList severityHost5;
    FacilityList facilityHost1;
    FacilityList facilityHost2;
    FacilityList facilityHost3;
    FacilityList facilityHost4;
    FacilityList facilityHost5;

    StatusState applicationDeliveryBoldChkBox;
    StatusState securityBoldChkBox;
    StatusState networkBoldChkBox;
    StatusState systemBoldChkBox;

    LoggingAlertsEnums.State emailLogState;
    SeverityList minimalSeverity;
    String destinationEmail;
    String originEmail;
    IpVersion ipVersion;
    String smtpHost;

    IOState sessionLogState;
    StatusState realServerLogState;
    StatusState natLogState;

    String ipAddressHost1;
    String ipAddressHost2;
    String ipAddressHost3;
    String ipAddressHost4;
    String ipAddressHost5;

    int detectionInterval;
    int throughputAlert;
    int sslCpsAlert;
    int compressionThroughputAlert;
    int apmAlert;
    int criticalForSessionTableUtilizations;
    int highForSessionTableUtilizations;

    int highSp, highMp;

    @Test
    @TestProperties(name = "Edit Syslog Settings Tab",
            paramsInclude = {"qcTestId", "showSyslog", "auditTrail","deviceName", "deviceIp", "parentTree",
                    "ipVersionHost1", "ipAddressHost1", "severityHost1", "facilityHost1",
                    "ipVersionHost2", "ipAddressHost2", "severityHost2", "facilityHost2",
                    "ipVersionHost3", "ipAddressHost3", "severityHost3", "facilityHost3",
                    "ipVersionHost4", "ipAddressHost4", "severityHost4", "facilityHost4",
                    "ipVersionHost5", "ipAddressHost5", "severityHost5", "facilityHost5",
                    "systemBoldChkBox", "networkBoldChkBox","applicationDeliveryBoldChkBox",
                    "securityBoldChkBox", "consoleChkBox", "spanningTreeChkBox",
                    "virtualServicesChkBox","securityChkBox", "systemChkBox",
                    "vlanChkBox", "filterChkBox", "managementChkBox",
                    "highAvailabilityChkBox", "globalTrafficRedirectionChkBox",
                    "cliChkBox", "ipChkBox", "synAttackChkBox", "sshChkBox",
                    "ipv6ChkBox", "applicationServicesChkBox", "ntpChkBox",
                    "ospfChkBox", "slbAttackChkBox", "webChkBox",
                    "bgpChkBox", "rateLimitChkBox", "rmonChkBox",
                    "emailLogState", "minimalSeverity", "destinationEmail", "originEmail",
                    "smtpHost", "ipVersion",
                    "sessionLogState", "realServerLogState", "natLogState",
                    "detectionInterval", "throughputAlert", "sslCpsAlert",
                    "compressionThroughputAlert", "apmAlert",
                    "criticalForSessionTableUtilizations", "highForSessionTableUtilizations",
                    "highSp", "highMp"})
    public void editSyslogSettingsTab() throws Exception {
        try {

            //========== Put parameters to all Logging and Alerts Page ==========//
            testProperties.put("showSyslog", showSyslog.getStatus());
            testProperties.put("auditTrail", auditTrail.getStatus());
            //==================================================================//

            //============= Set parameters to Syslog Settings Tab =============//
            testProperties.put("ipVersionHost1", ipVersionHost1.getNetwork());
            testProperties.put("ipAddressHost1", ipAddressHost1);
            testProperties.put("severityHost1", severityHost1.getSeverity());
            testProperties.put("facilityHost1", facilityHost1.getFacility());

            testProperties.put("ipVersionHost2", ipVersionHost2.getNetwork());
            testProperties.put("ipAddressHost2", ipAddressHost2);
            testProperties.put("severityHost2", severityHost2.getSeverity());
            testProperties.put("facilityHost2", facilityHost2.getFacility());

            testProperties.put("ipVersionHost3", ipVersionHost3.getNetwork());
            testProperties.put("ipAddressHost3", ipAddressHost3);
            testProperties.put("severityHost3", severityHost3.getSeverity());
            testProperties.put("facilityHost3", facilityHost3.getFacility());

            testProperties.put("ipVersionHost4", ipVersionHost4.getNetwork());
            testProperties.put("ipAddressHost4", ipAddressHost4);
            testProperties.put("severityHost4", severityHost4.getSeverity());
            testProperties.put("facilityHost4", facilityHost4.getFacility());

            testProperties.put("ipVersionHost5", ipVersionHost5.getNetwork());
            testProperties.put("ipAddressHost5", ipAddressHost5);
            testProperties.put("severityHost5", severityHost5.getSeverity());
            testProperties.put("facilityHost5", facilityHost5.getFacility());
            //==================================================================//


            //============== Set parameters to Logs and Traps Tab ==============//
            testProperties.put("systemBoldChkBox", systemBoldChkBox.getStatus());
            testProperties.put("networkBoldChkBox", networkBoldChkBox.getStatus());
            testProperties.put("applicationDeliveryBoldChkBox", applicationDeliveryBoldChkBox.getStatus());
            testProperties.put("securityBoldChkBox", securityBoldChkBox.getStatus());
            testProperties.put("consoleChkBox", consoleChkBox.getStatus());
            testProperties.put("spanningTreeChkBox", spanningTreeChkBox.getStatus());
            testProperties.put("virtualServicesChkBox", virtualServicesChkBox.getStatus());
            testProperties.put("securityChkBox", securityChkBox.getStatus());
            testProperties.put("systemChkBox", systemChkBox.getStatus());
            testProperties.put("vlanChkBox", vlanChkBox.getStatus());
            testProperties.put("filterChkBox", filterChkBox.getStatus());
            testProperties.put("managementChkBox", managementChkBox.getStatus());
            testProperties.put("highAvailabilityChkBox", highAvailabilityChkBox.getStatus());
            testProperties.put("globalTrafficRedirectionChkBox", globalTrafficRedirectionChkBox.getStatus());
            testProperties.put("cliChkBox", cliChkBox.getStatus());
            testProperties.put("ipChkBox", ipChkBox.getStatus());
            testProperties.put("synAttackChkBox", synAttackChkBox.getStatus());
            testProperties.put("sshChkBox", sshChkBox.getStatus());
            testProperties.put("ipv6ChkBox", ipv6ChkBox.getStatus());
            testProperties.put("applicationServicesChkBox", applicationServicesChkBox.getStatus());
            testProperties.put("ntpChkBox", ntpChkBox.getStatus());
            testProperties.put("ospfChkBox", ospfChkBox.getStatus());
            testProperties.put("slbAttackChkBox", slbAttackChkBox.getStatus());
            testProperties.put("webChkBox", webChkBox.getStatus());
            testProperties.put("bgpChkBox", bgpChkBox.getStatus());
            testProperties.put("rateLimitChkBox", rateLimitChkBox.getStatus());
            testProperties.put("rmonChkBox", rmonChkBox.getStatus());
            //==================================================================//

            //============== Set properties to Email Logs Tab ==============//
            testProperties.put("emailLogState", emailLogState.toString());
            testProperties.put("minimalSeverity", minimalSeverity.getSeverity());
            testProperties.put("destinationEmail", destinationEmail);
            testProperties.put("originEmail", originEmail);
            testProperties.put("smtpHost", smtpHost);
            testProperties.put("ipVersion", ipVersion.getIpVer());
            //=============================================================//

            //============== Set properties to Session Log Tab ==============//
            testProperties.put("sessionLogState", sessionLogState.getState());
            testProperties.put("realServerLogState", realServerLogState.getStatus());
            testProperties.put("natLogState", natLogState.getStatus());
            //===============================================================//

            //======= Set properties to License Alert Thresholds Tab =======//
            testProperties.put("licenseAlertVal0", getDetectionInterval());
            testProperties.put("licenseAlertVal1", getThroughputAlert());
            testProperties.put("licenseAlertVal2", getSslCpsAlert());
            testProperties.put("licenseAlertVal3", getCompressionThroughputAlert());
            testProperties.put("licenseAlertVal4", getApmAlert());
            testProperties.put("licenseAlertVal5", getCriticalForSessionTableUtilizations());
            testProperties.put("licenseAlertVal6", getHighForSessionTableUtilizations());

            //======== Set properties to CPU Utilization Alert Tab ========//
            testProperties.put("high1", getHighSp());
            testProperties.put("high2", getHighMp());
            //=============================================================//
            LoggingAlertsHandler.editLoggingAlertsSettings(testProperties);
            LoggingAlertsHandler.editSyslogSettings(testProperties);
            LoggingAlertsHandler.editLogsTraps(testProperties);
            LoggingAlertsHandler.editEmailLogs(testProperties);
            LoggingAlertsHandler.editSessionLog(testProperties);
            LoggingAlertsHandler.editLicenseAlertThresholds(testProperties);
            LoggingAlertsHandler.editCpuUtilizationAlert(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }

    }

    public StatusState getShowSyslog() {
        return showSyslog;
    }

    public void setShowSyslog(StatusState showSyslog) {
        this.showSyslog = showSyslog;
    }

    public StatusState getAuditTrail() {
        return auditTrail;
    }

    public void setAuditTrail(StatusState auditTrail) {
        this.auditTrail = auditTrail;
    }

    public ManagementNetworks getIpVersionHost1() {
        return ipVersionHost1;
    }

    public void setIpVersionHost1(ManagementNetworks ipVersionHost1) {
        this.ipVersionHost1 = ipVersionHost1;
    }

    public ManagementNetworks getIpVersionHost2() {
        return ipVersionHost2;
    }

    public void setIpVersionHost2(ManagementNetworks ipVersionHost2) {
        this.ipVersionHost2 = ipVersionHost2;
    }

    public ManagementNetworks getIpVersionHost3() {
        return ipVersionHost3;
    }

    public void setIpVersionHost3(ManagementNetworks ipVersionHost3) {
        this.ipVersionHost3 = ipVersionHost3;
    }

    public ManagementNetworks getIpVersionHost4() {
        return ipVersionHost4;
    }

    public void setIpVersionHost4(ManagementNetworks ipVersionHost4) {
        this.ipVersionHost4 = ipVersionHost4;
    }

    public ManagementNetworks getIpVersionHost5() {
        return ipVersionHost5;
    }

    public void setIpVersionHost5(ManagementNetworks ipVersionHost5) {
        this.ipVersionHost5 = ipVersionHost5;
    }

    public SeverityList getSeverityHost1() {
        return severityHost1;
    }

    public void setSeverityHost1(SeverityList severityHost1) {
        this.severityHost1 = severityHost1;
    }

    public SeverityList getSeverityHost2() {
        return severityHost2;
    }

    public void setSeverityHost2(SeverityList severityHost2) {
        this.severityHost2 = severityHost2;
    }

    public SeverityList getSeverityHost3() {
        return severityHost3;
    }

    public void setSeverityHost3(SeverityList severityHost3) {
        this.severityHost3 = severityHost3;
    }

    public SeverityList getSeverityHost4() {
        return severityHost4;
    }

    public void setSeverityHost4(SeverityList severityHost4) {
        this.severityHost4 = severityHost4;
    }

    public SeverityList getSeverityHost5() {
        return severityHost5;
    }

    public void setSeverityHost5(SeverityList severityHost5) {
        this.severityHost5 = severityHost5;
    }

    public FacilityList getFacilityHost1() {
        return facilityHost1;
    }

    public void setFacilityHost1(FacilityList facilityHost1) {
        this.facilityHost1 = facilityHost1;
    }

    public FacilityList getFacilityHost2() {
        return facilityHost2;
    }

    public void setFacilityHost2(FacilityList facilityHost2) {
        this.facilityHost2 = facilityHost2;
    }

    public FacilityList getFacilityHost3() {
        return facilityHost3;
    }

    public void setFacilityHost3(FacilityList facilityHost3) {
        this.facilityHost3 = facilityHost3;
    }

    public FacilityList getFacilityHost4() {
        return facilityHost4;
    }

    public void setFacilityHost4(FacilityList facilityHost4) {
        this.facilityHost4 = facilityHost4;
    }

    public FacilityList getFacilityHost5() {
        return facilityHost5;
    }

    public void setFacilityHost5(FacilityList facilityHost5) {
        this.facilityHost5 = facilityHost5;
    }

    public String getIpAddressHost1() {
        return ipAddressHost1;
    }

    public void setIpAddressHost1(String ipAddressHost1) {
        this.ipAddressHost1 = ipAddressHost1;
    }

    public String getIpAddressHost2() {
        return ipAddressHost2;
    }

    public void setIpAddressHost2(String ipAddressHost2) {
        this.ipAddressHost2 = ipAddressHost2;
    }

    public String getIpAddressHost3() {
        return ipAddressHost3;
    }

    public void setIpAddressHost3(String ipAddressHost3) {
        this.ipAddressHost3 = ipAddressHost3;
    }

    public String getIpAddressHost4() {
        return ipAddressHost4;
    }

    public void setIpAddressHost4(String ipAddressHost4) {
        this.ipAddressHost4 = ipAddressHost4;
    }

    public String getIpAddressHost5() {
        return ipAddressHost5;
    }

    public void setIpAddressHost5(String ipAddressHost5) {
        this.ipAddressHost5 = ipAddressHost5;
    }

    public StatusState getSystemBoldChkBox() {
        return systemBoldChkBox;
    }

    public void setSystemBoldChkBox(StatusState systemBoldChkBox) {
        this.systemBoldChkBox = systemBoldChkBox;
    }

    public StatusState getNetworkBoldChkBox() {
        return networkBoldChkBox;
    }

    public void setNetworkBoldChkBox(StatusState networkBoldChkBox) {
        this.networkBoldChkBox = networkBoldChkBox;
    }

    public StatusState getApplicationDeliveryBoldChkBox() {
        return applicationDeliveryBoldChkBox;
    }

    public void setApplicationDeliveryBoldChkBox(StatusState applicationDeliveryBoldChkBox) {
        this.applicationDeliveryBoldChkBox = applicationDeliveryBoldChkBox;
    }

    public StatusState getSecurityBoldChkBox() {
        return securityBoldChkBox;
    }

    public void setSecurityBoldChkBox(StatusState securityBoldChkBox) {
        this.securityBoldChkBox = securityBoldChkBox;
    }

    public StatusState getConsoleChkBox() {
        return consoleChkBox;
    }

    public void setConsoleChkBox(StatusState consoleChkBox) {
        this.consoleChkBox = consoleChkBox;
    }

    public StatusState getSpanningTreeChkBox() {
        return spanningTreeChkBox;
    }

    public void setSpanningTreeChkBox(StatusState spanningTreeChkBox) {
        this.spanningTreeChkBox = spanningTreeChkBox;
    }

    public StatusState getVirtualServicesChkBox() {
        return virtualServicesChkBox;
    }

    public void setVirtualServicesChkBox(StatusState virtualServicesChkBox) {
        this.virtualServicesChkBox = virtualServicesChkBox;
    }

    public StatusState getSecurityChkBox() {
        return securityChkBox;
    }

    public void setSecurityChkBox(StatusState securityChkBox) {
        this.securityChkBox = securityChkBox;
    }

    public StatusState getSystemChkBox() {
        return systemChkBox;
    }

    public void setSystemChkBox(StatusState systemChkBox) {
        this.systemChkBox = systemChkBox;
    }

    public StatusState getVlanChkBox() {
        return vlanChkBox;
    }

    public void setVlanChkBox(StatusState vlanChkBox) {
        this.vlanChkBox = vlanChkBox;
    }

    public StatusState getFilterChkBox() {
        return filterChkBox;
    }

    public void setFilterChkBox(StatusState filterChkBox) {
        this.filterChkBox = filterChkBox;
    }

    public StatusState getManagementChkBox() {
        return managementChkBox;
    }

    public void setManagementChkBox(StatusState managementChkBox) {
        this.managementChkBox = managementChkBox;
    }

    public StatusState getHighAvailabilityChkBox() {
        return highAvailabilityChkBox;
    }

    public void setHighAvailabilityChkBox(StatusState highAvailabilityChkBox) {
        this.highAvailabilityChkBox = highAvailabilityChkBox;
    }

    public StatusState getGlobalTrafficRedirectionChkBox() {
        return globalTrafficRedirectionChkBox;
    }

    public void setGlobalTrafficRedirectionChkBox(StatusState globalTrafficRedirectionChkBox) {
        this.globalTrafficRedirectionChkBox = globalTrafficRedirectionChkBox;
    }

    public StatusState getCliChkBox() {
        return cliChkBox;
    }

    public void setCliChkBox(StatusState cliChkBox) {
        this.cliChkBox = cliChkBox;
    }

    public StatusState getIpChkBox() {
        return ipChkBox;
    }

    public void setIpChkBox(StatusState ipChkBox) {
        this.ipChkBox = ipChkBox;
    }

    public StatusState getSynAttackChkBox() {
        return synAttackChkBox;
    }

    public void setSynAttackChkBox(StatusState synAttackChkBox) {
        this.synAttackChkBox = synAttackChkBox;
    }

    public StatusState getSshChkBox() {
        return sshChkBox;
    }

    public void setSshChkBox(StatusState sshChkBox) {
        this.sshChkBox = sshChkBox;
    }

    public StatusState getIpv6ChkBox() {
        return ipv6ChkBox;
    }

    public void setIpv6ChkBox(StatusState ipv6ChkBox) {
        this.ipv6ChkBox = ipv6ChkBox;
    }

    public StatusState getApplicationServicesChkBox() {
        return applicationServicesChkBox;
    }

    public void setApplicationServicesChkBox(StatusState applicationServicesChkBox) {
        this.applicationServicesChkBox = applicationServicesChkBox;
    }

    public StatusState getNtpChkBox() {
        return ntpChkBox;
    }

    public void setNtpChkBox(StatusState ntpChkBox) {
        this.ntpChkBox = ntpChkBox;
    }

    public StatusState getOspfChkBox() {
        return ospfChkBox;
    }

    public void setOspfChkBox(StatusState ospfChkBox) {
        this.ospfChkBox = ospfChkBox;
    }

    public StatusState getSlbAttackChkBox() {
        return slbAttackChkBox;
    }

    public void setSlbAttackChkBox(StatusState slbAttackChkBox) {
        this.slbAttackChkBox = slbAttackChkBox;
    }

    public StatusState getWebChkBox() {
        return webChkBox;
    }

    public void setWebChkBox(StatusState webChkBox) {
        this.webChkBox = webChkBox;
    }

    public StatusState getBgpChkBox() {
        return bgpChkBox;
    }

    public void setBgpChkBox(StatusState bgpChkBox) {
        this.bgpChkBox = bgpChkBox;
    }

    public StatusState getRateLimitChkBox() {
        return rateLimitChkBox;
    }

    public void setRateLimitChkBox(StatusState rateLimitChkBox) {
        this.rateLimitChkBox = rateLimitChkBox;
    }

    public StatusState getRmonChkBox() {
        return rmonChkBox;
    }

    public void setRmonChkBox(StatusState rmonChkBox) {
        this.rmonChkBox = rmonChkBox;
    }

    public LoggingAlertsEnums.State getEmailLogState() {
        return emailLogState;
    }

    public void setEmailLogState(LoggingAlertsEnums.State emailLogState) {
        this.emailLogState = emailLogState;
    }

    public SeverityList getMinimalSeverity() {
        return minimalSeverity;
    }

    public void setMinimalSeverity(SeverityList minimalSeverity) {
        this.minimalSeverity = minimalSeverity;
    }

    public String getDestinationEmail() {
        return destinationEmail;
    }

    public void setDestinationEmail(String destinationEmail) {
        this.destinationEmail = destinationEmail;
    }

    public String getOriginEmail() {
        return originEmail;
    }

    public void setOriginEmail(String originEmail) {
        this.originEmail = originEmail;
    }

    public IpVersion getIpVersion() {
        return ipVersion;
    }

    public void setIpVersion(IpVersion ipVersion) {
        this.ipVersion = ipVersion;
    }

    public String getSmtpHost() {
        return smtpHost;
    }

    public void setSmtpHost(String smtpHost) {
        this.smtpHost = smtpHost;
    }

    public IOState getSessionLogState() {
        return sessionLogState;
    }

    public void setSessionLogState(IOState sessionLogState) {
        this.sessionLogState = sessionLogState;
    }

    public StatusState getRealServerLogState() {
        return realServerLogState;
    }

    public void setRealServerLogState(StatusState realServerLogState) {
        this.realServerLogState = realServerLogState;
    }

    public StatusState getNatLogState() {
        return natLogState;
    }

    public void setNatLogState(StatusState natLogState) {
        this.natLogState = natLogState;
    }

    public String getDetectionInterval() {
        return String.valueOf(detectionInterval);
    }

    public void setDetectionInterval(String detectionInterval) {
        if (Integer.valueOf(StringUtils.fixNumeric(detectionInterval)) < 1) {
            this.detectionInterval = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(detectionInterval)) > 1440) {
            this.detectionInterval = 1440;
        } else {
            this.detectionInterval = Integer.valueOf(StringUtils.fixNumeric(detectionInterval));
        }
    }

    public String getThroughputAlert() {
        return String.valueOf(throughputAlert);
    }

    public void setThroughputAlert(String throughputAlert) {
        if (Integer.valueOf(StringUtils.fixNumeric(throughputAlert)) < 0) {
            this.throughputAlert = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(throughputAlert)) > 99) {
            this.throughputAlert = 99;
        } else {
            this.throughputAlert = Integer.valueOf(StringUtils.fixNumeric(throughputAlert));
        }
    }

    public String getSslCpsAlert() {
        return String.valueOf(sslCpsAlert);
    }

    public void setSslCpsAlert(String sslCpsAlert) {
        if (Integer.valueOf(StringUtils.fixNumeric(sslCpsAlert)) < 0) {
            this.sslCpsAlert = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(sslCpsAlert)) > 99) {
            this.sslCpsAlert = 99;
        } else {
            this.sslCpsAlert = Integer.valueOf(StringUtils.fixNumeric(sslCpsAlert));
        }
    }

    public String getCompressionThroughputAlert() {
        return String.valueOf(compressionThroughputAlert);
    }

    public void setCompressionThroughputAlert(String compressionThroughputAlert) {
        if (Integer.valueOf(StringUtils.fixNumeric(compressionThroughputAlert)) < 0) {
            this.compressionThroughputAlert = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(compressionThroughputAlert)) > 99) {
            this.compressionThroughputAlert = 99;
        } else {
            this.compressionThroughputAlert = Integer.valueOf(StringUtils.fixNumeric(compressionThroughputAlert));
        }
    }

    public String getApmAlert() {
        return String.valueOf(apmAlert);
    }

    public void setApmAlert(String apmAlert) {
        if (Integer.valueOf(StringUtils.fixNumeric(apmAlert)) < 0) {
            this.apmAlert = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(apmAlert)) > 99) {
            this.apmAlert = 99;
        } else {
            this.apmAlert = Integer.valueOf(StringUtils.fixNumeric(apmAlert));
        }
    }

    public String getCriticalForSessionTableUtilizations() {
        return String.valueOf(criticalForSessionTableUtilizations);
    }

    public void setCriticalForSessionTableUtilizations(String criticalForSessionTableUtilizations) {
        if (Integer.valueOf(StringUtils.fixNumeric(criticalForSessionTableUtilizations)) < 1) {
            this.criticalForSessionTableUtilizations = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(criticalForSessionTableUtilizations)) > 100) {
            this.criticalForSessionTableUtilizations = 100;
        } else {
            this.criticalForSessionTableUtilizations = Integer.valueOf(StringUtils.fixNumeric(criticalForSessionTableUtilizations));
        }
    }

    public String getHighForSessionTableUtilizations() {
        return String.valueOf(highForSessionTableUtilizations);
    }

    public void setHighForSessionTableUtilizations(String highForSessionTableUtilizations) {
        if (Integer.valueOf(StringUtils.fixNumeric(highForSessionTableUtilizations)) < 1) {
            this.highForSessionTableUtilizations = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(highForSessionTableUtilizations)) > 100) {
            this.highForSessionTableUtilizations = 100;
        } else {
            this.highForSessionTableUtilizations = Integer.valueOf(StringUtils.fixNumeric(highForSessionTableUtilizations));
        }
    }

    public String getHighSp() {
        return String.valueOf(highSp);
    }

    public void setHighSp(String highSp) {
        if (Integer.valueOf(StringUtils.fixNumeric(highSp)) < 0) {
            this.highSp = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(highSp)) > 99) {
            this.highSp = 99;
        } else {
            this.highSp = Integer.valueOf(StringUtils.fixNumeric(highSp));
        }
    }

    public String getHighMp() {
        return String.valueOf(highMp);
    }

    public void setHighMp(String highMp) {
        if (Integer.valueOf(StringUtils.fixNumeric(highMp)) < 0) {
            this.highMp = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(highMp)) > 99) {
            this.highMp = 99;
        } else {
            this.highMp = Integer.valueOf(StringUtils.fixNumeric(highMp));
        }
    }
}
