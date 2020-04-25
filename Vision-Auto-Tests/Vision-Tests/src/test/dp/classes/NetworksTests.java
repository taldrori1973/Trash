package com.radware.vision.tests.dp.classes;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.dp.configuration.classes.networks.Networks;
import com.radware.automation.webui.webpages.dp.configuration.classes.networks.networksnonscreen.NetworkInnerTable;
import com.radware.automation.webui.widgets.impl.table.WebUIRowValues;
import com.radware.products.defensepro.defensepro.DefenseProEnums.PolicyNetworkMode;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;


public class NetworksTests extends DpTestBase {

    enum IpVersion {IPv6, IPv4}

    String networkName;

    PolicyNetworkMode entryType;
    IpVersion ipVersion;
    String networkAddress;
    String mask;
    String fromIP;
    String toIP;
    boolean useValidation = true;


    public String getNetworkName() {
        return networkName;
    }

    public void setNetworkName(String networkName) {
        this.networkName = networkName;
    }

    @Test
    @TestProperties(name = "Verify Network Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "networkName", "entryType", "ipVersion", "networkAddress", "mask", "fromIP", "toIP"})
    public void verifyNetworkClass() throws InterruptedException {
        Networks networks = dpUtils.dpProduct.mConfiguration().mClasses().mNetworks();
        networks.openPage();

        NetworkInnerTable networkInnerTable = (NetworkInnerTable) networks.mNetworkInnerTable().open();
        networkInnerTable.editNetworkGroup("Network Name", networkName);
        List<WebUIRowValues> entities = networkInnerTable.getNetworkGroupItems();
        WebUIRowValues expectedNetworkGroupItem = new WebUIRowValues(Arrays.asList(new String[]{(getDeviceName() != null ? getDeviceName() : ""), (networkName != null ? networkName : ""),
                (entryType.toString() != null ? entryType.toString() : ""), (ipVersion.toString() != null ? ipVersion.toString() : ""), (networkAddress != null ? networkAddress : ""),
                (mask != null ? mask : ""), (fromIP != null ? fromIP : ""), (toIP != null ? toIP : "")}));
        if (!entities.contains(expectedNetworkGroupItem)) {
            BaseTestUtils.report("Expected: \n" + expectedNetworkGroupItem.toString() + "\n" + "Actual items: \n" + outputNetworkClassItems(entities), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Create network Class", paramsInclude = {"qcTestId", "defenceProVersion", "defenceProVersion", "deviceName", "networkName", "entryType", "ipVersion", "networkAddress", "mask", "fromIP", "toIP", "useValidation"})
    public void createNetworkClass() throws InterruptedException {
        Networks networks = dpUtils.dpProduct.mConfiguration().mClasses().mNetworks();
        networks.openPage();
        networks.addNetwork();
        networks.setNetworkName(networkName);

        NetworkInnerTable networkInnerTable = (NetworkInnerTable) networks.mNetworkInnerTable().open();
        networkInnerTable.addNetworkGroup();

        if (ipVersion != null) {
            networkInnerTable.selectNetworkType(ipVersion.toString());
        }

        if (entryType != null) {
            if (entryType.equals(PolicyNetworkMode.IP_Mask)) {
                networkInnerTable.selectEntryType("IP Mask");
            }
            if (entryType.equals(PolicyNetworkMode.IP_Range)) {
                networkInnerTable.selectEntryType("IP Range");
            }
        }

        if (entryType.equals(PolicyNetworkMode.IP_Range)) {
            if (fromIP != null) {
                networkInnerTable.setFromIP(fromIP, ipVersion.name());
            }
            if (toIP != null) {
                networkInnerTable.setToIP(toIP, ipVersion.name());
            }
        }
        if (entryType.equals(PolicyNetworkMode.IP_Mask)) {
            if (networkAddress != null) {
                networkInnerTable.setNetworkAddress(networkAddress);
            }
            if (mask != null) {
                try {
                    networkInnerTable.setMask("Prefix", mask/*, ipVersion.name().equals(ipVersion.IPv4.name()) ? "Prefix32" : "Prefix128"*/);
                }
                catch (Exception e) {
                    networkInnerTable.setMask("Mask", mask/*, ipVersion.name().equals(ipVersion.IPv4.name()) ? "Prefix32" : "Prefix128"*/);
                }
            }
        }

        networkInnerTable.submit();
        WebUIDriver.getListenerManager().getWebUIDriverEventListener().afterClickOn(null, WebUIUtils.getDriver());
        BasicOperationsHandler.delay(2);
        networks.submit();
        BasicOperationsHandler.delay(3);

        if (useValidation) {
            updatePolicies();
            WebUIRowValues expectedNetworkGroupItem = new WebUIRowValues(Arrays.asList(new String[]{(getDeviceName() != null ? getDeviceName() : ""), (networkName != null ? networkName : ""),
                    (entryType.toString() != null ? entryType.toString() : ""), (ipVersion.toString() != null ? ipVersion.toString() : ""), (networkAddress != null ? networkAddress : ""),
                    (mask != null ? mask : ""), (fromIP != null ? fromIP : ""), (toIP != null ? toIP : "")}));
            List<WebUIRowValues> networkGroupItems = networkInnerTable.getNetworkGroupItems();
            if (!networkGroupItems.contains(expectedNetworkGroupItem)) {
                BaseTestUtils.report("Expected: \n" + expectedNetworkGroupItem.toString() + "\n" + "Actual items: \n" + outputNetworkClassItems(networkGroupItems), Reporter.FAIL);
            }
        }

    }

    @Test
    @TestProperties(name = "Delete network Class", paramsInclude = {"qcTestID", "defenceProVersion", "deviceName", "networkName"})
    public void deleteNetworkClass() {
        Networks networks = dpUtils.dpProduct.mConfiguration().mClasses().mNetworks();
        networks.openPage();
        networks.deleteNetworkByKeyValue("Network Name", networkName);
    }

    private String outputNetworkClassItems(List<WebUIRowValues> items) {
        StringBuilder output = new StringBuilder();
        for (WebUIRowValues item : items) {
            output.append(item.toString()).append("\n");
        }
        return output.toString();
    }

    public boolean isUseValidation() {
        return useValidation;
    }

    public void setUseValidation(boolean useValidation) {
        this.useValidation = useValidation;
    }

    public PolicyNetworkMode getEntryType() {
        return entryType;
    }

    public void setEntryType(PolicyNetworkMode entryType) {
        this.entryType = entryType;
    }

    public IpVersion getIpVersion() {
        return ipVersion;
    }

    public void setIpVersion(IpVersion ipVersion) {
        this.ipVersion = ipVersion;
    }

    public String getNetworkAddress() {
        return networkAddress;
    }

    public void setNetworkAddress(String networkAddress) {
        this.networkAddress = networkAddress;
    }

    public String getMask() {
        return mask;
    }

    public void setMask(String mask) {
        this.mask = mask;
    }

    public String getFromIP() {
        return fromIP;
    }

    public void setFromIP(String fromIP) {
        this.fromIP = fromIP;
    }

    public String getToIP() {
        return toIP;
    }

    public void setToIP(String toIP) {
        this.toIP = toIP;
    }

}
