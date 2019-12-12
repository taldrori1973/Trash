package com.radware.vision.tests.Alteon.Configuration.System.users;

import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Users.RemoteAuthenticationHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;

import java.util.HashMap;

/**
 * Created by matthewt on 6/3/2015.
 */
public class RemoteAuthenticationTests extends AlteonTestBase {

    /**
     * ******parameters of  RADIUS vertical tab********
     */
    String ipAdress;
    String ipAdress2;
    String primaryServerSecret;
    String secondaryServerSecret;
    String port;
    String DHCPtimeOut;
    String retries;
    public GeneralEnums.State radiusState = GeneralEnums.State.DISABLE;
    public GeneralEnums.State allowLocalUserFallback;
    public GeneralEnums.IpVersion ipVersion;
    public GeneralEnums.IpVersion ipVersion2;

    /**
     * ******parameters of TACACS+ vertical tab********
     */
    String TACipAdress;
    String TACipAdress2;
    String TACprimaryServerSecret;
    String TACsecondaryServerSecret;
    String TACport;
    String TACDHCPtimeOut;
    String TACretries;
    public GeneralEnums.State TACState = GeneralEnums.State.DISABLE;
    public GeneralEnums.State TACallowLocalUserFallback;
    public GeneralEnums.IpVersion TACipVersion;
    public GeneralEnums.IpVersion TACipVersion2;
    public GeneralEnums.State TACCommandAuth;
    public GeneralEnums.State TACCommandLog;
    public GeneralEnums.State TACNewPrivilegeLevelMapping;

    BaseTableActions localUsersTableAction = BaseTableActions.NEW;

    @Test
    @TestProperties(name = "Edit Remote Authentication", paramsInclude =
            {"qcTestId", "deviceIp", "deviceName", "parentTree", "clickOnTableRow",
                    "deviceState", "radiusState", "ipVersion", "ipAdress",
                    "ipVersion2", "ipAdress2", "port", "DHCPtimeOut", "retries",
                    "primaryServerSecret", "secondaryServerSecret", "allowLocalUserFallback",

                    "TACState", "TACipVersion", "TACipAdress", "TACipVersion2", "TACipAdress2",
                    "TACport", "TACDHCPtimeOut", "TACretries", "TACprimaryServerSecret",
                    "TACsecondaryServerSecret", "TACCommandAuth", "TACCommandLog",
                    "TACNewPrivilegeLevelMapping", "TACallowLocalUserFallback"})
    public void editRemoteAuthentication() {

        try {

            /**
             * *********************Set parameters to RADIUS vertical tab **********************************************
             * **/

            testProperties.put("ipVersion", ipVersion.toString());
            testProperties.put("ipAdress", ipAdress.toString());
            testProperties.put("ipVersion2", ipVersion2.toString());
            testProperties.put("ipAdress2", ipAdress2.toString());
            testProperties.put("port", port.toString());
            testProperties.put("DHCPtimeOut", DHCPtimeOut.toString());
            testProperties.put("retries", retries.toString());
            testProperties.put("primaryServerSecret", primaryServerSecret.toString());
            testProperties.put("secondaryServerSecret", secondaryServerSecret.toString());
            testProperties.put("allowLocalUserFallback", allowLocalUserFallback.toString());
            /**
             * *********************Set parameters to TACACS+ vertical tab **********************************************
             * **/
            testProperties.put("TACipVersion", TACipVersion.toString());
            testProperties.put("TACipAdress", TACipAdress.toString());
            testProperties.put("TACipVersion2", TACipVersion2.toString());
            testProperties.put("TACipAdress2", TACipAdress2.toString());
            testProperties.put("TACport", TACport);
            testProperties.put("TACDHCPtimeOut", TACDHCPtimeOut);
            testProperties.put("TACretries", TACretries);
            testProperties.put("TACprimaryServerSecret", TACprimaryServerSecret);
            testProperties.put("TACsecondaryServerSecret", TACsecondaryServerSecret);
            testProperties.put("TACCommandAuth", TACCommandAuth.toString());
            testProperties.put("TACCommandLog", TACCommandLog.toString());
            testProperties.put("TACNewPrivilegeLevelMapping", TACNewPrivilegeLevelMapping.toString());
            testProperties.put("TACallowLocalUserFallback", TACallowLocalUserFallback.toString());
            //==========================================================================================

            RemoteAuthenticationHandler.DefinitionRemoteAuthenticationRADIUS(testProperties, radiusState);
            RemoteAuthenticationHandler.DefinitionRemoteAuthenticationTACACS(testProperties, TACState);

        } catch (Exception e) {
            report.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String getIpAdress() {
        return ipAdress;
    }

    public void setIpAdress(String ipAdress) {
        this.ipAdress = ipAdress;
    }

    public String getIpAdress2() {
        return ipAdress2;
    }

    public void setIpAdress2(String ipAdress2) {
        this.ipAdress2 = ipAdress2;
    }

    public String getPrimaryServerSecret() {
        return primaryServerSecret;
    }

    @ParameterProperties(description = "Max number of characters: 32")
    public void setPrimaryServerSecret(String primaryServerSecret) {
        this.primaryServerSecret = primaryServerSecret;
    }

    public String getSecondaryServerSecret() {
        return secondaryServerSecret;
    }

    @ParameterProperties(description = "Max number of characters: 32")
    public void setSecondaryServerSecret(String secondaryServerSecret) {
        this.secondaryServerSecret = secondaryServerSecret;
    }

    public String getPort() {
        return port;
    }

    @ParameterProperties(description = "Valid range: 1500...3000")
    public void setPort(String port) {
        if (Integer.parseInt(port) > 1500 && Integer.parseInt(port) < 3000) {
            this.port = port;
        } else if (Integer.parseInt(port) < 1500) {
            this.port = "1500";
        } else if (Integer.parseInt(port) > 3000) {
            this.port = "3000";
        }

    }

    public String getDHCPtimeOut() {
        return DHCPtimeOut;
    }

    @ParameterProperties(description = "Valid range: 1...10")
    public void setDHCPtimeOut(String DHCPtimeOut) {
        if (Integer.parseInt(DHCPtimeOut) > 1 && Integer.parseInt(DHCPtimeOut) < 10) {
            this.DHCPtimeOut = DHCPtimeOut;
        } else if (Integer.parseInt(DHCPtimeOut) < 1) {
            this.DHCPtimeOut = "1";
        } else if (Integer.parseInt(DHCPtimeOut) > 10) {
            this.DHCPtimeOut = "10";
        }

    }

    public String getRetries() {
        return retries;
    }

    @ParameterProperties(description = "Valid range: 1...3")
    public void setRetries(String retries) {
        if (Integer.parseInt(retries) > 1 && Integer.parseInt(retries) < 3) {
            this.retries = retries;
        } else if (Integer.parseInt(retries) < 1) {
            this.retries = "1";
        } else if (Integer.parseInt(retries) > 3) {
            this.retries = "3";
        }

    }

    public GeneralEnums.State getRadiusState() {
        return radiusState;
    }

    public void setRadiusState(GeneralEnums.State radiusState) {
        this.radiusState = radiusState;
    }

    public GeneralEnums.State getAllowLocalUserFallback() {
        return allowLocalUserFallback;
    }

    public void setAllowLocalUserFallback(GeneralEnums.State allowLocalUserFallback) {
        this.allowLocalUserFallback = allowLocalUserFallback;
    }

    public GeneralEnums.IpVersion getIpVersion() {
        return ipVersion;
    }

    public void setIpVersion(GeneralEnums.IpVersion ipVersion) {
        this.ipVersion = ipVersion;
    }

    public GeneralEnums.IpVersion getIpVersion2() {
        return ipVersion2;
    }

    public void setIpVersion2(GeneralEnums.IpVersion ipVersion2) {
        this.ipVersion2 = ipVersion2;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public BaseTableActions getLocalUsersTableAction() {
        return localUsersTableAction;
    }

    public void setLocalUsersTableAction(BaseTableActions localUsersTableAction) {
        this.localUsersTableAction = localUsersTableAction;
    }

    /**
     * *******************getters & setters of TACACS+ vertical tab*************************
     */

    public String getTACipAdress() {
        return TACipAdress;
    }

    public void setTACipAdress(String TACipAdress) {
        this.TACipAdress = TACipAdress;
    }

    public String getTACipAdress2() {
        return TACipAdress2;
    }

    public void setTACipAdress2(String TACipAdress2) {
        this.TACipAdress2 = TACipAdress2;
    }

    public String getTACprimaryServerSecret() {
        return TACprimaryServerSecret;
    }

    @ParameterProperties(description = "Max number of characters: 32")
    public void setTACprimaryServerSecret(String TACprimaryServerSecret) {
        this.TACprimaryServerSecret = TACprimaryServerSecret;
    }

    public String getTACsecondaryServerSecret() {
        return TACsecondaryServerSecret;
    }

    @ParameterProperties(description = "Max number of characters: 32")
    public void setTACsecondaryServerSecret(String TACsecondaryServerSecret) {
        this.TACsecondaryServerSecret = TACsecondaryServerSecret;
    }

    public String getTACport() {
        return TACport;
    }

    @ParameterProperties(description = "Valid range: 1...65000")
    public void setTACport(String TACport) {

        if (Integer.parseInt(TACport) > 1 && Integer.parseInt(TACport) < 65000) {
            this.TACport = TACport;
        } else if (Integer.parseInt(TACport) < 1) {
            this.TACport = "1";
        } else if (Integer.parseInt(TACport) > 65000) {
            this.TACport = "65000";
        }

    }

    public String getTACDHCPtimeOut() {
        return TACDHCPtimeOut;
    }

    @ParameterProperties(description = "Valid range: 1...15")
    public void setTACDHCPtimeOut(String TACDHCPtimeOut) {

        if (Integer.parseInt(TACDHCPtimeOut) > 1 && Integer.parseInt(TACDHCPtimeOut) < 15) {
            this.TACDHCPtimeOut = TACDHCPtimeOut;
        } else if (Integer.parseInt(TACDHCPtimeOut) < 1) {
            this.TACDHCPtimeOut = "1";
        } else if (Integer.parseInt(TACDHCPtimeOut) > 15) {
            this.TACDHCPtimeOut = "15";
        }

    }

    public String getTACretries() {
        return TACretries;
    }

    @ParameterProperties(description = "Valid range: 1...3")
    public void setTACretries(String TACretries) {

        if (Integer.parseInt(TACretries) > 1 && Integer.parseInt(TACretries) < 3) {
            this.TACretries = TACretries;
        } else if (Integer.parseInt(TACretries) < 1) {
            this.TACretries = "1";
        } else if (Integer.parseInt(TACretries) > 3) {
            this.TACretries = "3";
        }

    }

    public GeneralEnums.State getTACState() {
        return TACState;
    }

    public void setTACState(GeneralEnums.State TACState) {
        this.TACState = TACState;
    }

    public GeneralEnums.State getTACallowLocalUserFallback() {
        return TACallowLocalUserFallback;
    }

    public void setTACallowLocalUserFallback(GeneralEnums.State TACallowLocalUserFallback) {
        this.TACallowLocalUserFallback = TACallowLocalUserFallback;
    }

    public GeneralEnums.IpVersion getTACipVersion() {
        return TACipVersion;
    }

    public void setTACipVersion(GeneralEnums.IpVersion TACipVersion) {
        this.TACipVersion = TACipVersion;
    }

    public GeneralEnums.IpVersion getTACipVersion2() {
        return TACipVersion2;
    }

    public void setTACipVersion2(GeneralEnums.IpVersion TACipVersion2) {
        this.TACipVersion2 = TACipVersion2;
    }

    public GeneralEnums.State getTACCommandAuth() {
        return TACCommandAuth;
    }

    public void setTACCommandAuth(GeneralEnums.State TACCommandAuth) {
        this.TACCommandAuth = TACCommandAuth;
    }

    public GeneralEnums.State getTACCommandLog() {
        return TACCommandLog;
    }

    public void setTACCommandLog(GeneralEnums.State TACCommandLog) {
        this.TACCommandLog = TACCommandLog;
    }

    public GeneralEnums.State getTACNewPrivilegeLevelMapping() {
        return TACNewPrivilegeLevelMapping;
    }

    public void setTACNewPrivilegeLevelMapping(GeneralEnums.State TACNewPrivilegeLevelMapping) {
        this.TACNewPrivilegeLevelMapping = TACNewPrivilegeLevelMapping;
    }
}
