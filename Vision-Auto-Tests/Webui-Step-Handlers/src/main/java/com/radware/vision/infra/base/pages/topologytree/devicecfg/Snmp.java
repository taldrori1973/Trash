package com.radware.vision.infra.base.pages.topologytree.devicecfg;

import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.restcore.utils.enums.DeviceType;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;

public class Snmp extends DeviceProperties{
	String mgmtIpBoxName = "Management IP";
	String snmpReadCommunityBoxName = "SNMP Read Community";
	String snmpWriteCommunityBoxName = "SNMP Write Community";
	String snmpV2ReadCommunity = "snmpV2ReadCommunity";
	String snmpV2WriteCommunity = "snmpV2WriteCommunity";
	String snmpV1ReadCommunity = "snmpV1ReadCommunity";
	String snmpV1WriteCommunity = "snmpV1WriteCommunity";
	String snmpVersionComboName = "SNMP Version";
	String userNameBoxName = "User Name";
	String useAuthenticationCheckName = "Use Authentication";
	String authenticationProtocolBoxName = "Authentication Protocol";
	String authenticationPasswordBoxName = "Authentication Password";
	String usePrivacyCheckName = "Use Privacy";
	String privacyPasswordBoxName = "Privacy Password";
	
	public Snmp(String deviceDriveFilename) {
		super(deviceDriveFilename);
	}
	public void setManagementIp(String mgmtName){
		WebUITextField mgmtIpTextBox = (WebUITextField)container.getIpv4TextField(mgmtIpBoxName);
		mgmtIpTextBox.type(mgmtName);
	}
	public void setType(DeviceType elementType) {
		WebUIDropdown snmpVersionCombo = (WebUIDropdown)container.getDropdown(snmpVersionComboName);
		snmpVersionCombo.selectOptionByText(elementType.getDeviceType());
	}
	public void setSnmpV1ReadCommunity(String snmpCommunity){
		WebUITextField snmpReadTextBox = (WebUITextField)container.getTextField(snmpReadCommunityBoxName, snmpV1ReadCommunity);
		snmpReadTextBox.type(snmpCommunity);
	}
	public void setSnmpV1WriteCommunity(String snmpCommunity){
		WebUITextField snmpWriteTextBox = (WebUITextField)container.getTextField(snmpWriteCommunityBoxName, snmpV1WriteCommunity);
		snmpWriteTextBox.type(snmpCommunity);
	}
	public void setSnmpV2ReadCommunity(String snmpCommunity){
		WebUITextField snmpReadTextBox = (WebUITextField)container.getTextField(snmpReadCommunityBoxName,snmpV2ReadCommunity);
		snmpReadTextBox.type(snmpCommunity);
	}
	public void setSnmpV2WriteCommunity(String snmpCommunity){
		WebUITextField snmpWriteTextBox = (WebUITextField)container.getTextField(snmpWriteCommunityBoxName,snmpV2WriteCommunity);
		snmpWriteTextBox.type(snmpCommunity);
	}
	public void setSnmpUserName(String userName){
		WebUITextField snmpUserNameTextBox = (WebUITextField)container.getTextField(userNameBoxName);
		snmpUserNameTextBox.type(userName);
	}
	public void setUseAuthentication(boolean check) {
		WebUICheckbox useAuthenticationCheckBox = (WebUICheckbox)container.getCheckbox(useAuthenticationCheckName);
		if (check) {
			useAuthenticationCheckBox.check();
		} else {
			useAuthenticationCheckBox.uncheck();
		}
	}
	public void setSnmpVersion(String snmpVersion) {
		WebUIDropdown snmpVersionCombo = (WebUIDropdown)container.getDropdown(snmpVersionComboName);
		snmpVersionCombo.selectOptionByText(snmpVersion);
	}
	public void setAuthenticationProtocol(String authenticationProtocol) {
		WebUIDropdown authenticationProtocolCombo = (WebUIDropdown)container.getDropdown(authenticationProtocolBoxName);
		authenticationProtocolCombo.selectOptionByText(authenticationProtocol);
	}
	public void setAuthenticationPassword(String authenticationPassword){
		WebUITextField authenticationPasswordTextBox = (WebUITextField)container.getPasswordTextField(authenticationPasswordBoxName);
		authenticationPasswordTextBox.type(authenticationPassword);
	}
	public void setUsePrivacy(boolean check) {
		WebUICheckbox usePrivacyCheckBox = (WebUICheckbox)container.getCheckbox(usePrivacyCheckName);
		if (check) {
			usePrivacyCheckBox.check();
		} else {
			usePrivacyCheckBox.uncheck();
		}
	}
	public void setPrivacyPassword(String privacyPassword){
		WebUITextField privacyPasswordTextBox = (WebUITextField)container.getPasswordTextField(privacyPasswordBoxName);
		privacyPasswordTextBox.type(privacyPassword);
	}
	
}
