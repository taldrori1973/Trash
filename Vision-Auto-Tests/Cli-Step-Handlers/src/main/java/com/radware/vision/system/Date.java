/**
 *
 */
package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.utils.RegexUtils;
import com.radware.vision.vision_tests.CliTests;
import jsystem.extensions.analyzers.text.FindText;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 * @author Hadar Elbaz
 */
public class Date {

    public static final String DATE_SUB_MENU = "get                     Displays the date and time.\n"
            + "set                     Sets the date and time.\n";

    /**
     * net - verify the answer
     */
    public static void dateSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().date().build(), DATE_SUB_MENU);
    }

    public static final String SYSTEM_DATE_SUB_MENU = "get                     Displays the date and time.\n"
            + "set                     Sets the date and time.\n";

    public final static String DATE_PATTERN = "EEE MMM d HH:mm:ss 'UTC' yyyy";

    public final static String DATE_PATTERN_TZ = "EEE MMM d HH:mm:ss X yyyy";
    //in the config-sync status
    public final static String DATE_STATUS_PATTERN = "MM/dd/yyyy HH:mm:ss";

    /**
     * Displays the date and time for user radware Convert the date to Date object Displays the date and time for user root Convert the date
     * to Date object validate that the dates are the same with max of 6 seconds because of running time.
     * <p>
     * for example date structure is: Wed Jun 5 13:53:27 UTC 2013
     *
     * @throws Exception
     */
    public static void compareDateRootAndRadware(RadwareServerCli serverCli, RootServerCli userCli) throws Exception {

        try {
            BaseTestUtils.reporter.startLevel("Compare The Root's and Radware's Date");
            SimpleDateFormat df = new SimpleDateFormat(DATE_PATTERN);
            java.util.Date radwareDate = getRadwareDate(serverCli);
            InvokeUtils.invokeCommand(null, "date", userCli);

            String rootDateStr = userCli.getOutputStr().replaceAll("  ", " "); // Remove white spaces in case there are more then one.
            java.util.Date rootDate = df.parse(rootDateStr);
            if ((Math.abs(rootDate.getTime() - radwareDate.getTime())) > 6000) {
                throw new Exception("Dates are not equal via radware and root user");
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void compareDateRootAndRadware(RadwareServerCli serverCli, RootServerCli userCli, String lineToGetRootDate)
            throws Exception {
        compareDateRootAndRadware(serverCli, userCli, lineToGetRootDate, 6000);
    }

    public static void compareDateRootAndRadware(RadwareServerCli serverCli, RootServerCli userCli, String lineToGetRootDate, long timeOut)
            throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Compare The Root's and Radware's Date");
            SimpleDateFormat df = new SimpleDateFormat(DATE_PATTERN);
            java.util.Date radwareDate = getRadwareDate(serverCli);
            InvokeUtils.invokeCommand(null, lineToGetRootDate, userCli);
            String rootDateStr = userCli.getOutputStr();
            try {
                java.util.Date rootDate = df.parse(rootDateStr);
                if ((Math.abs(rootDate.getTime() - radwareDate.getTime())) > timeOut) {
                    throw new Exception("Dates are not equal via radware and root user");
                }
            } catch (ParseException e) {
                df = new SimpleDateFormat(DATE_PATTERN);
                java.util.Date rootDate = df.parse(rootDateStr);
                if ((Math.abs(rootDate.getTime() - radwareDate.getTime())) > timeOut) {
                    throw new Exception("Dates are not equal via radware and root user");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static String getRadwareDateStr(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Radware Date");
            InvokeUtils.invokeCommand(null, Menu.system().date().get().build(), serverCli);
            return serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /*
     * Cut only the timezone from the date string Use pattern that match dateStr in the structure of the 'DATE_PATTERN' parameter
     */
    public static String getTimezone(String dateStr) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("get Timezone from 'system date' cmd ");
            BaseTestUtils.reporter.report("date is " + dateStr);
            dateStr = dateStr.replace("  "," ");
            ArrayList<String> regexReturn = RegexUtils.fromStringToArrayWithPattern("\\w{3} \\w{3} \\d{1,2} \\d+:\\d+:\\d+ (\\w{3}) \\d+", dateStr);
            if (regexReturn != null & regexReturn.size() == 1) {
                BaseTestUtils.reporter.report("TimeZone From date CMD is" + regexReturn.get(0));
                return regexReturn.get(0);
            } else {
                return null;
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static java.util.Date getRadwareDate(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Radware Date.");
            SimpleDateFormat df = new SimpleDateFormat(DATE_PATTERN);
            InvokeUtils.invokeCommand(null, Menu.system().date().get().build(), serverCli, 180000);
            String radwareDateStr = serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);
            if(!radwareDateStr.contains("UTC")){
                df = new SimpleDateFormat(DATE_PATTERN_TZ);
            }
            java.util.Date dateToReturn = df.parse(radwareDateStr);
            return dateToReturn;
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    /**
     * Read current time from radware user Set new time, approve restart with y Set timeout to 5 minutes
     *
     * @param dateStr
     * @param serverCli
     * @throws Exception
     */
    public static java.util.Date getCurrentDateAndsetNewDate(String dateStr, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Current Date And Set New Date.");
            java.util.Date currentRadwareDate = getRadwareDate(serverCli);
            InvokeUtils.invokeCommand(null, Menu.system().date().set().build() + " " + dateStr, serverCli);
            InvokeUtils.invokeCommand(null, "y", serverCli, CliTests.DEFAULT_TIME_WAIT_FOR_VISION_SERVICES_RESTART);
            serverCli.analyze(new FindText("Setting the date completed successfully."));
            return currentRadwareDate;
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    /**
     * Check the date is the same as expected with max of 60 seconds change because of running time
     *
     * @param expectedDate - format example: 2013/06/03 12:36:00
     * @param serverCli
     * @throws Exception
     */
    public static void verifyDate(String expectedDate, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify Date.");
            SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            java.util.Date currentDate = getRadwareDate(serverCli);
            java.util.Date expectDate = df.parse(expectedDate);
            if ((Math.abs(currentDate.getTime() - expectDate.getTime())) > 120000) {
                throw new Exception("Dates are not as expected, current: " + currentDate.toString() + " , expected: " + expectedDate);
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }
}
