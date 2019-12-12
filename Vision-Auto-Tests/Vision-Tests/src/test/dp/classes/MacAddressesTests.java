package com.radware.vision.tests.dp.classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.macaddresses.MACAddresses;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class MacAddressesTests extends DpTestBase{

	
	private String GroupName;
	private String MACAddress;
	private String key;
	private String value;
	
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public String getMACAddress() {
		return MACAddress;
	}
	public void setMACAddress(String mACAddress) {
		MACAddress = mACAddress;
	}
	public String getKey() {
		return key;
	}

    @ParameterProperties(description = "Please, specify the column name to look for a <value> in.")
    public void setKey(String key) {
        this.key = key;
	}
	public String getValue() {
		return value;
	}

    @ParameterProperties(description = "Please, specify the <value> to look for.")
    public void setValue(String value) {
		this.value = value;
	}
	
	@Test
    @TestProperties(name = "Create MacAddress Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "GroupName", "MACAddress"})
    public void createMacAddressClass() {
		MACAddresses macAdress = dpUtils.dpProduct.mConfiguration().mClasses().mMACAddresses();
		macAdress.openPage();
		macAdress.addMACAddresses();
		macAdress.setMacGroupName(GroupName);
		macAdress.setMACAddress(MACAddress);
		macAdress.submit();
	}
	
	
	@Test
    @TestProperties(name = "Delete MacAddress Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "key", "value"})
    public void deleteMacAddressClass(){
		MACAddresses macAdress = dpUtils.dpProduct.mConfiguration().mClasses().mMACAddresses();
		macAdress.openPage();
		macAdress.deleteMACAddressesByKeyValue(key, value);
	}
}
