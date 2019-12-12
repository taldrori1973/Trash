package com.radware.vision.infra.base.pages.topologytree.devicecfg;

import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;

public class WebAccess extends DeviceProperties{
	String userNameBoxName = "User Name";
	String passwordBoxName = "Password";
	String httpPortBoxName = "HTTP Port";
	String httpsPortBoxName = "HTTPS Port";
	String verifyHttpAccessCheckName = "Verify HTTP Access";
	String verifyHttpsAccessCheckName = "Verify HTTPS Access";
	String httpAccess = "http";
    String mgmtIpBoxId = "deviceSetup.deviceAccess.appwall.managementIp";

    public WebAccess(String deviceDriverFilename) {
		super(deviceDriverFilename);
	}

	public void setUserName(String userName){
		WebUITextField userNameTextBox = (WebUITextField)container.getTextField(userNameBoxName,httpAccess);
		userNameTextBox.type(userName);
	}
	public void setPassword(String password){
		WebUITextField passwordTextBox = (WebUITextField)container.getPasswordTextField(passwordBoxName);
		passwordTextBox.type(password);
	}
	public void setHttpPort(int httpPort){
		WebUITextField httpPortTextBox = (WebUITextField)container.getTextField(httpPortBoxName);
		httpPortTextBox.type(String.valueOf(httpPort));
		
	}
	public void setHttpsPort(int httpsPort){
		WebUITextField httpsPortTextBox = (WebUITextField)container.getTextField(httpsPortBoxName);
		httpsPortTextBox.type(String.valueOf(httpsPort));
	}

    public void setManagementIp(String mgmtName) {
        WebUITextField mgmtIpTextBox = (WebUITextField) container.getWidgetById(mgmtIpBoxId);
        mgmtIpTextBox.type(mgmtName);
    }

	public void setVerifyHttpAccess(boolean check) {
		WebUICheckbox verifyHttpAccessCheckBox = (WebUICheckbox)container.getCheckbox(verifyHttpAccessCheckName);
		if (check) {
			verifyHttpAccessCheckBox.check();
		} else {
			verifyHttpAccessCheckBox.uncheck();
		}
	}
	public void setVerifyHttpsAccess(boolean check) {
		WebUICheckbox verifyHttpsAccessCheckBox = (WebUICheckbox)container.getCheckbox(verifyHttpsAccessCheckName);
		if (check) {
			verifyHttpsAccessCheckBox.check();
		} else {
			verifyHttpsAccessCheckBox.uncheck();
		}
	}
}
