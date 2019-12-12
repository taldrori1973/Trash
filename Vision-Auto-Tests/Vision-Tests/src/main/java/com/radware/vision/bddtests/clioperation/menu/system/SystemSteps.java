package com.radware.vision.bddtests.clioperation.menu.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.system.SystemGenerals;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Then;
import com.radware.automation.tools.basetest.Reporter;;

public class SystemSteps extends BddCliTestBase {

    @Then("^CLI Verifying sub menu of system cmd$")
    public void system(){
try {
    InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.system().build(), SystemGenerals.SYSTEM_SUB_MENU);
}catch(Exception e){
    BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
}

    }
}
