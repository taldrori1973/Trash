package com.radware.vision.infra.base.pages.topologytree.devicecfg;

import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;

public class SshAccess extends DeviceProperties{
	String userNameBoxName = "User Name";
	String passwordBoxName = "Password";
	String sshPortBoxName = "SSH Port";
	String sshAccess = "cli";
	
	public SshAccess(String deviceDriverFilename) {
		super(deviceDriverFilename);
	}
	public void setUserName(String userName){
		WebUITextField userNameTextBox = (WebUITextField)container.getTextField(userNameBoxName,sshAccess);
		userNameTextBox.type(userName);
	}
	public void setPassword(String password){
		WebUITextField passwordTextBox = (WebUITextField)container.getPasswordTextField(passwordBoxName,sshAccess);
		passwordTextBox.type(password);
	}
	public void setSshPort(int sshPort){
		WebUITextField sshPortTextBox = (WebUITextField)container.getTextField(sshPortBoxName);
		sshPortTextBox.type(String.valueOf(sshPort));
	}
}
