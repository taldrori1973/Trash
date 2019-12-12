package com.radware.vision.infra.utils;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.connection.VisionConnectionAuthentication;
import com.radware.automation.webui.webuiproduct.VisionWebUIProduct;

public class VisionWebUIUtils extends WebUIUtils {

    public VisionWebUIProduct visionWebUIProduct;
    public static String loggedinUser;

    @Override
    public void setUp() throws Exception {
 //      visionWebUIProduct = WebUIProductFactory.createVisionWebUIProduct();
        setConnection(new VisionConnectionAuthentication());
    }

    public void haSetUp(String ip) throws Exception {
//        visionWebUIProduct = WebUIProductFactory.createVisionWebUIProduct(ip);
        setConnection(new VisionConnectionAuthentication());
    }
}
