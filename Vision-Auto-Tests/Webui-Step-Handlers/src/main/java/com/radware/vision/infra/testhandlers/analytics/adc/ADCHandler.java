package com.radware.vision.infra.testhandlers.analytics.adc;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.infra.utils.json.CustomizedJsonManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Map;

import static com.radware.automation.webui.UIUtils.SHORT_WAIT_TIME;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;

/**
 * Created by MoaadA on 9/11/2018.
 */
public class ADCHandler {


    public static boolean validateChart(String chartName, Map<String, String> data) {
        chartName = chartName.toUpperCase();
        Map<String, String> dataAsJSon = CustomizedJsonManager.fixJson(data);
        boolean result = true;
        switch (chartName) {
            case "TOP USED CIPHER DISTRIBUTION":
                WebElement cipherWidget = WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId("Vrm-Dpm-Cipher-Chart-cipher chart-container").getBy());
                WebElement row = WebUIUtils.fluentWait(By.xpath("/div[" + dataAsJSon.get("rowNumber") + "]"), SHORT_WAIT_TIME, false, cipherWidget);
                String expected, actual;


                expected = data.get("cipher-name");
                if (expected != null) {
                    actual = WebUIUtils.fluentWait(By.xpath("/div[1]"), SHORT_WAIT_TIME, false, row).getText();
                    if (!expected.equals(actual)) {
                        addErrorMessage("cipher name Expected : " + expected + " | Actual " + actual);
                        result = false;
                    }
                }

                expected = data.get("cipher-progress");
                if (expected != null) {
                    expected = expected.replaceAll(" ", "");
                    actual = WebUIUtils.fluentWait(By.xpath("/div[2]/div"), SHORT_WAIT_TIME, false, row).getAttribute("style").split(";")[0].trim().replaceAll(" ", "");
                    if (!expected.equals(actual)) {
                        addErrorMessage("cipher-progress Expected : " + expected + " | Actual " + actual);
                        result = false;
                    }

                }


                expected = data.get("cipher-percentage");
                if (expected != null) {
                    actual = WebUIUtils.fluentWait(By.xpath("/div[3]"), SHORT_WAIT_TIME, false, row).getText();
                    if (!expected.equals(actual)) {
                        addErrorMessage("cipher-percentage Expected : " + expected + " | Actual " + actual);
                        result = false;
                    }

                }

                break;

        }
        return result;

    }
}
