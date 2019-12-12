package com.radware.vision.tests.popups;

import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.vision.base.WebUITestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by moaada on 7/5/2017.
 */
public class PopUps extends WebUITestBase {


    @Test
    @TestProperties(name = "close all yellow messages", paramsInclude = {})
    public void closeAllYellowMessages() {

        WebUIBasePage.closeAllYellowMessages();
    }

}
