package com.radware.vision.infra.testhandlers.alteon.configuration.system;

import com.radware.automation.webui.webpages.configuration.system.loggingAndAlerts.LoggingAlerts;
import com.radware.automation.webui.webpages.configuration.system.loggingAndAlerts.LoggingAlertsEnums;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by alexeys on 5/31/2015.
 */
public class LoggingAlertsHandler extends BaseHandler {

    private static LoggingAlerts loggingAlerts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLoggingAlerts();

    public static void editLoggingAlertsSettings(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        loggingAlerts.openPage();
        loggingAlerts.setShowSyslog(LoggingAlertsEnums.StatusState.getEnum(testProperties.get("showSyslog")));
        loggingAlerts.setAuditTrial(LoggingAlertsEnums.StatusState.getEnum(testProperties.get("auditTrial")));
    }

    public static void editSyslogSettings(HashMap<String, String> testProperties) {
        //LoggingAlerts loggingAlerts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLoggingAlerts();

//        loggingAlerts.setSyslogSettingsTab();
        for (int i = 1; i <= 5; i++) {
           /* if (testProperties.get("ipVersionHost" + i).isEmpty() || testProperties.get("ipAddressHost" + i).isEmpty()
                    || testProperties.get("severityHost" + i).isEmpty() || testProperties.get("facilityHost" + 1).isEmpty()) {
                continue;
            }*/
            loggingAlerts.setIpVer(LoggingAlertsEnums.IpVersion.getEnum(testProperties.get("ipVersionHost" + i)), i);
            if (LoggingAlertsEnums.IpVersion.getEnum(testProperties.get("ipVersionHost" + i)).equals(LoggingAlertsEnums.IpVersion.IPV4)) {
                loggingAlerts.setIpAddress(testProperties.get("ipAddressHost" + i), i);
            } else {
                loggingAlerts.setIpAddressV6(testProperties.get("ipAddressHost" + i), i);
            }
            loggingAlerts.setSeverity(LoggingAlertsEnums.SeverityList.getEnum(testProperties.get("severityHost" + i)), i);
            loggingAlerts.setFacility(LoggingAlertsEnums.FacilityList.getEnum(testProperties.get("facilityHost" + i)), i);
        }
       loggingAlerts.submit();
    }

    public static void editLogsTraps(HashMap<String, String> testProperties) {
        loggingAlerts.setLogsTrapsTab();
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("systemBoldChkBox")), "LoggingandAlerts.system.Field_0");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("networkBoldChkBox")), "LoggingandAlerts.system.Network");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("applicationDeliveryBoldChkBox")), "LoggingandAlerts.system.ApplicationDelivery");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("securityBoldChkBox")), "LoggingandAlerts.system.Security");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("consoleChkBox")), "agNewCfgSyslogTrapConsole");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("spanningTreeChkBox")), "agNewCfgSyslogTrapStp");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("virtualServicesChkBox")), "agNewCfgSyslogTrapSlb");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("securityChkBox")), "agNewCfgSyslogTrapSecurity");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("systemChkBox")), "agNewCfgSyslogTrapSystem");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("vlanChkBox")), "agNewCfgSyslogTrapVlan");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("filterChkBox")), "agNewCfgSyslogTrapFilter");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("managementChkBox")), "agNewCfgSyslogTrapMgmt");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("highAvailabilityChkBox")), "agNewCfgSyslogTrapVrrp");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("globalTrafficRedirectionChkBox")), "agNewCfgSyslogTrapGslb");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("cliChkBox")), "agNewCfgSyslogTrapCli");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("ipChkBox")), "agNewCfgSyslogTrapIp");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("synAttackChkBox")), "agNewCfgSyslogTrapSynAtk");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("sshChkBox")), "agNewCfgSyslogTrapSsh");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("ipv6ChkBox")), "agNewCfgSyslogTrapIpv6");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("applicationServicesChkBox")), "agNewCfgSyslogTrapAppSvc");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("ntpChkBox")), "agNewCfgSyslogTrapNtp");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("ospfChkBox")), "agNewCfgSyslogTrapOspf");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("slbAttackChkBox")), "agNewCfgSyslogTrapSlbAtk");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("webChkBox")), "agNewCfgSyslogTrapWeb");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("bgpChkBox")), "agNewCfgSyslogTrapBgp");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("rateLimitChkBox")), "agNewCfgSyslogTrapTcpLim");
        loggingAlerts.setCheckBoxState(LoggingAlertsEnums.
                StatusState.getEnum(testProperties.get("rmonChkBox")), "agNewCfgSyslogTrapRmon");
    }


    public static void editEmailLogs(HashMap<String, String> testProperties) {
        loggingAlerts.setEmailLogsTab();
        loggingAlerts.setEmailLog(LoggingAlertsEnums.State.getEnum(testProperties.get("emailLogState")));
        if (LoggingAlertsEnums.State.getEnum(testProperties.get("emailLogState")).equals(LoggingAlertsEnums.State.DISABLED)) {
            loggingAlerts.setSmtpHost(testProperties.get("smtpHost"), 1);
        } else {
            loggingAlerts.setMinimalSeverity(LoggingAlertsEnums.SeverityList.getEnum(testProperties.get("emailLogSeverity")));
            loggingAlerts.setDestinationEmail(testProperties.get("destinationEmail"));
            loggingAlerts.setOriginEmail(testProperties.get("originEmail"));
            loggingAlerts.setSmtpHost(testProperties.get("smtpHost"), 2);
        }
        loggingAlerts.setIpVersion(LoggingAlertsEnums.IpVersion.getEnum(testProperties.get("ipVersion")));
        loggingAlerts.submit();
    }

    public static void editSessionLog(HashMap<String, String> testProperties) {
        loggingAlerts.setSessionLogTab();
        loggingAlerts.setSessionLog(LoggingAlertsEnums.IOState.getEnum(testProperties.get("sessionLogState")));
        if (LoggingAlertsEnums.IOState.getEnum(testProperties.get("sessionLogState")).equals(LoggingAlertsEnums.IOState.ON)) {
            loggingAlerts.setRealServerDataLog(LoggingAlertsEnums.StatusState.getEnum(testProperties.get("realServerLogState")));
            loggingAlerts.setNatDataLog(LoggingAlertsEnums.StatusState.getEnum(testProperties.get("natLogState")));
        }
        loggingAlerts.submit();
    }

    public static void editLicenseAlertThresholds(HashMap<String, String> testProperties) {
        loggingAlerts.setLicenseAlertThresholdsTab();
        for (int i = 0; i < 6; i++) {
            loggingAlerts.setValuesLicenseAlertThreshold(testProperties.get("licenseAlertVal" + i), i);
        }
        loggingAlerts.submit();
    }

    public static void editCpuUtilizationAlert(HashMap<String, String> testProperties) {
        loggingAlerts.setCpuUtilizationAlertTab();
        for (int i = 1; i < 3; i++) {
            loggingAlerts.setCpuUtilizationAlert(testProperties.get("high" + i), i);
        }
        loggingAlerts.submit();
    }
}
