package com.radware.vision.infra.base.pages.deviceoperations;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.enums.DeviceState;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class DeviceOperations{

	public DeviceOperations() {}

    public void lockUnlockDevice() {
        ComponentLocator lockButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getLockUnlockDevice());
        WebUIUtils.fluentWaitClick(lockButtonLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
//        if (lockElement == null) {
//            RestTestBase.report.report("LockUnlock device operation failure", Reporter.FAIL);
//        } else {
//            lockElement.click();
//        }
    }

    public boolean isLocked() {
        ComponentLocator lockButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getLockUnlockDevice());
        WebElement lockElement = WebUIUtils.fluentWait(lockButtonLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        if (lockElement == null) return false;
        String titleAttr = null;
        int counter = 0;
        do {
            titleAttr = WebUIUtils.fluentWaitAttribute(lockElement, WebUIUtils.SHORT_WAIT_TIME, false, "title");
        } while (titleAttr == null && counter++ < 10);
        if (titleAttr == null) return false;
        if (titleAttr.contains(DeviceState.UnLock.getDeviceState())) {
            return true;
        } else if (titleAttr.contains(DeviceState.Lock.getDeviceState())) {
            return false;
        }
        return false;
    }

}
