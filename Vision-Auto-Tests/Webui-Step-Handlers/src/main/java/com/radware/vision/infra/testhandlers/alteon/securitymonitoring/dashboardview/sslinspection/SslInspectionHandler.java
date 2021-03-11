package com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.DeleteOrLeaveIt;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.SslInspectionTabs;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.EnableDisableEnum;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.infra.utils.ReportsUtils;
import org.openqa.selenium.support.How;


public class SslInspectionHandler {

    public static void selectGlobalTimeFilter(String quickRange) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Select.Global Time Filter");
        BasicOperationsHandler.clickButton("Select.Global Time Filter.Quick Range", quickRange);
    }

    public static boolean verifyIfTabClicked(SslInspectionTabs tab) {

        String tabXpath = GeneralUtils.buildGenericXpath(WebElementType.Data_Debug_Id, tab.getDataDebugId(), OperatorsEnum.EQUALS);
        if (!ClickOperationsHandler.checkIfElementAttributeContains(new ComponentLocator(How.XPATH, tabXpath), "class", "active")) {
            ReportsUtils.reportAndTakeScreenShot(tab.getTabName() + " Is Not Clicked", Reporter.FAIL);
            return false;
        }
        return true;
    }

    public static class ReportsSettings {

        /*
        Data-debug-ids for the widgets
         */
        public static final String ADD_REPORT = "ngr-reports-list-add-report";
        public static final String REPORT_TITILE = "reporter-title-input-field";
        public static final String REPORT_SENDER = "report-sender-tokeninput";
        public static final String REPORT_RECIPIENTS = "report-recipients-tokeninput";
        public static final String REPORT_SUBJECT = "report-message-body-input-field";
        public static final String REPORTER_MESSAGE_BODY = "reporter-message-body-textarea";
        public static final String REPORTED_PERIOD_DROPDOWN = "reported-period-dropdown-input";
        public static final String SECONDS_NUMBER_INPUT = "seconds-number-input";
        public static final String MINUTES_NUMBER_INPUT = "minutes-number-input";
        public static final String HOURS_NUMBER_INPUT = "hours-number-input";
        public static final String REPORT_SAVE_BUTTON = "reporter-form-save-button";
        public static final String REPORT_CANCEL_BUTTON = "reporter-form-cancel-button";
        public static final String REPORT_RUN_NOW_BUTTON = "reporter-form-run-now-button";


        public static void clickOnDeleteReport(String reportTitle) {
            ClickOperationsHandler.clickWebElement(WebElementType.XPATH, getDeleteWidgetXpath(reportTitle), 0);
        }

        public static void clickOnYesDeleteOrLeaveIt(String reportTitle, DeleteOrLeaveIt deleteOrLeaveIt) {
            ClickOperationsHandler.clickWebElement(WebElementType.XPATH, getYesOrLeaveItWidgetXpath(reportTitle, deleteOrLeaveIt), 0);
        }

        public static boolean verifyIfReportExists(String reportTitle) {

            return ClickOperationsHandler.checkIfElementExists(getReportWidgetXpath(reportTitle));

        }

        public static void enableDisableReport(String reportTitle, EnableDisableEnum action) {
            String enableDisableWidgetXpath = getEnableDisableWidgetXpath(reportTitle);
            ComponentLocator enableDisableButton = new ComponentLocator(How.XPATH, enableDisableWidgetXpath);
            boolean enabled = ClickOperationsHandler.checkIfElementAttributeContains(enableDisableButton, "class", "on enabled");

            if (action == EnableDisableEnum.ENABLE && !enabled || action == EnableDisableEnum.DISABLE && enabled) {
                ClickOperationsHandler.clickWebElement(WebElementType.XPATH, enableDisableWidgetXpath, 0);
            }

        }

        private static String getReportWidgetXpath(String reportTitle) {
            return ".//*[@data-debug-id='ngr-report-list-item-container_" + reportTitle + "']";
        }

        private static String getDeleteWidgetXpath(String reportTitle) {

            return ".//*[@data-debug-id='ngr-report-list-item-container_" + reportTitle + "']" + "//*[@data-debug-id='report-item-delete-button']";
        }

        private static String getYesOrLeaveItWidgetXpath(String reportTitle, DeleteOrLeaveIt deleteOrLeaveIt) {

            return ".//*[@data-debug-id='ngr-report-list-item-container_" + reportTitle + "']" + "//*[@data-debug-id='" + deleteOrLeaveIt.getDataDebugId() + "']";
        }


        private static String getEnableDisableWidgetXpath(String reportTitle) {
            return ".//*[@data-debug-id='ngr-report-list-item-container_" + reportTitle + "']" + "//*[@data-debug-id='SwitchButton_Button']";
        }
    }

    public static class Reports {


    }

    public static class Dashboard {

    }
}

