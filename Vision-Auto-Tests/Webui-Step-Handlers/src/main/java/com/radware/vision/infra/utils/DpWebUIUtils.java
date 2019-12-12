package com.radware.vision.infra.utils;

import com.radware.automation.webui.connection.VisionConnectionAuthentication;
import com.radware.automation.webui.webuiproduct.DefenseProWebUIProduct;
import com.radware.automation.webui.webuiproduct.WebUIProductFactory;

public class DpWebUIUtils extends VisionWebUIUtils {
	
	public DefenseProWebUIProduct dpProduct;
	
	public void setUp() {
		dpProduct = WebUIProductFactory.createDefenseProWebUIProduct();
		setConnection(new VisionConnectionAuthentication());
	}

}