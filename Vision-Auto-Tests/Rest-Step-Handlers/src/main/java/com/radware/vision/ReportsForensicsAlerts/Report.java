package com.radware.vision.ReportsForensicsAlerts;

import org.openqa.selenium.WebElement;

import java.util.Arrays;
import java.util.Map;

public class Report extends ReportsForensicsAlertsAbstract {

    @Override
    public  void create(String reportName, Map<String, String> map) throws Exception {

        try
        {
            createReportParameters(reportName, map);
            selectTemplates(map);
        }
        catch (Exception e)
        {
            closeReport();
            throw e;
        }
        if (!reportCreated())
        {
            closeReport();
            throw new Exception("");
        }
    }

    private  boolean reportCreated() {
        return true;
    }

    private  void closeReport() {
    }

    private  void selectTemplates(Map<String, String> map) {
        for (Object template : (Arrays.asList(map.get("templates")))) {
            addTemplate(template);
        }
    }

    private  void addTemplate(Object template) {

    }

    private void createReportParameters(String reportName, Map<String, String> map) throws Exception {

            expandReportParameters();
            createName(reportName);
            addLogo(map);
            selectTime(map);
            selectScheduling(map);
            selectShare(map);
            selectFormat(map);

    }

    private void expandReportParameters() throws Exception {

        WebElement expandOrCollapseElement = getWebElement("expandCollapseArrow");
        if(expandOrCollapseElement == null)
            throw new Exception("Expand Element doesn't displayed");
        if (expandOrCollapseElement.getAttribute(checkedNotCheckedAttribute).equalsIgnoreCase("false"))
            expandOrCollapseElement.click();
    }

    private  void selectFormat(Map<String, String> map) {
    }

    private  void addLogo(Map<String, String> map) {

    }

    @Override
    public  void validate() {

    }

    @Override
    public  void edit() {

    }

    @Override
    public  void delete() {

    }
}
