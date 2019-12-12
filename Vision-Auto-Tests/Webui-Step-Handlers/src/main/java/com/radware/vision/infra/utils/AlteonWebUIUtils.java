package com.radware.vision.infra.utils;


import com.radware.automation.webui.connection.VisionConnectionAuthentication;
import com.radware.automation.webui.webuiproduct.AlteonWebUIProduct;
import com.radware.automation.webui.webuiproduct.WebUIProductFactory;

public class AlteonWebUIUtils extends VisionWebUIUtils{
public AlteonWebUIProduct alteonProduct;
	
	public void setUp() {
		alteonProduct = WebUIProductFactory.createAlteonWebUIProduct();
		setConnection(new VisionConnectionAuthentication());
	}
}
