package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.VisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.enums.LastConfiguration;
import com.radware.vision.enums.YesNo;
import com.radware.vision.utils.RegexUtils;

import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by moaada on 4/10/2017.
 */
public class ConfigSync {


    public static final String CONFIG_SYNC_SUB_MENU = "interval                Manages the configuration-synchronization interval.\n" +
            "manual                  Manually starts a configuration-synchronization action.\n" +
            "mode                    Manages the configuration-synchronization mode.\n" +
            "peer                    Manages the peer address.\n" +
            "status                  Displays the configuration-synchronization status.\n";

    public static final String INTERVAL_SUB_MENU = "get                     Displays the configuration-synchronization interval (in minutes).\n"
            + "set                     Sets the configuration-synchronization interval (in minutes).";

    public static final String INTERVAL_SET_USAGE = "Usage: system config-sync interval set  <interval in minutes>\n" +
            "\n" +
            "Sets the configuration-synchronization interval (in minutes).\n" +
            "Minimum allowed interval: 1 (minute)\n" +
            "Maximum allowed interval: 1440 (minutes = 24 hours)\n";

    public static final String MODE_SUB_MENU = "get                     Displays the configuration-synchronization mode.\n"
            + "set                     Sets the configuration-synchronization mode.";

    public static final String MODE_SET_USAGE = "active                  Sets the server mode to active.\n" +
            "disabled                Disables configuration synchronization.\n" +
            "standby                 Sets the server mode to standby.";

    public static final String PEERS_SUB_MENU = "get                     Displays the peer address.\n"
            + "set                     Sets the peer address.";

    public static final String PEERS_SET_USAGE = "Usage: system config-sync peer set <address>\n" +
            "\n" +
            "Sets the peer IP address or hostname.";


    public static void configSyncSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().build(), CONFIG_SYNC_SUB_MENU);
    }

    public static void intervalSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().interval().build(), INTERVAL_SUB_MENU);
    }

    public static void intervalSetUsage(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().interval().set().build() + "?", INTERVAL_SET_USAGE, false);
    }


    public static void modeSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().mode().build(), MODE_SUB_MENU);
    }

    public static void ModeSetUsage(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().mode().set().build() + "?", MODE_SET_USAGE, false);
    }


    public static void peerSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().peer().build(), PEERS_SUB_MENU);
    }

    public static void peerSetUsage(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().configSync().peer().set().build() + "?", PEERS_SET_USAGE, false);
    }

    public static int getInterval(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("get ConfigSync Interval");
            CliOperations.runCommand(serverCli, Menu.system().configSync().interval().get().build());
            return Integer.parseInt(RegexUtils.getGroupWithPattern("\\d+", serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1)));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static void setInterval(RadwareServerCli serverCli, String interval) throws Exception {

        try {
            BaseTestUtils.reporter.startLevel("set ConfigSync Interval to " + interval);
            CliOperations.runCommand(serverCli, Menu.system().configSync().interval().set().build() + " " + interval);


        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }


    public static boolean verifyIntervalSet(RadwareServerCli serverCli, String expectedInterval) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("verify 'system config-sync interval with expected value: " + expectedInterval);


            if (String.valueOf(getInterval(serverCli)).equals(expectedInterval)) {
                BaseTestUtils.reporter.report("setting interval to " + expectedInterval + " succeeded");
                return true;
            } else {

                BaseTestUtils.reporter.report("setting interval to " + expectedInterval + " failed");
                return false;
            }


        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static String getMode(RadwareServerCli serverCli) throws Exception {
        try {

            BaseTestUtils.reporter.startLevel("get config-sync mode");
            CliOperations.runCommand(serverCli, Menu.system().configSync().mode().get().build(), 120*1000);

            String result = serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);

            return result.replace(buildModeText(""), "");


        } finally {

            BaseTestUtils.reporter.stopLevel();

        }
    }

    /**
     * sets the mode to--> active,standby or disable
     * verify that all relevant services are up to a specific mode.
     * if the timeout reached to zero and the services still down it will throw a exception
     */

    public static void setMode(RadwareServerCli serverCli, ConfigSyncMode mode, int timeout, String yesNo) throws Exception {
        try {
            if (yesNo.equals(null)) {
                throw new Exception("Please specify if you want to continue or not (y/n)");

            }
            String newMode = mode.getMode();
            if (newMode == null) {
                throw new Exception("please select a mode ");
            }
            String currentMode = getMode(serverCli);
            if (currentMode.equals(newMode)) return;
            boolean serviceNeedToGoDown = false, serviceNeedToGoUp = false, warningMessage = false;

            if (currentMode.equals(ConfigSyncMode.STANDBY.getMode()))
                serviceNeedToGoUp = true;
            else if ((currentMode.equals(ConfigSyncMode.ACTIVE.getMode()) || currentMode.equals(ConfigSyncMode.DISABLED.getMode())) && (newMode.equals(ConfigSyncMode.STANDBY.getMode())))
                serviceNeedToGoDown = true;

            BaseTestUtils.reporter.startLevel("Setting Mode to " + newMode);
            CliOperations.runCommand(serverCli, Menu.system().configSync().mode().set().build() + " " + newMode,  300 * 1000);
            if (serviceNeedToGoUp) {
                if ((serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1).contains("will start the configuration service"))) {
                    warningMessage = true;
                }

            } else if (serviceNeedToGoDown) {
                if ((serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1).contains("will stop the configuration service"))) {
                    warningMessage = true;
                }
            }

            if ((serviceNeedToGoDown || serviceNeedToGoUp) && warningMessage == false)
                throw new Exception("No warning message been showed");
            if (warningMessage) {
                CliOperations.runCommand(serverCli, yesNo,  5 * 60 * 1000);
                if (yesNo.equals(YesNo.YES.getText())) {
                    if (!VisionServer.waitForVisionServerServicesToStartHA(serverCli, timeout)) {
                        throw new Exception("Timeout : Services are not in the appropriate state for the new mode  ");
                    }
                }
            }
        } finally

        {
            BaseTestUtils.reporter.stopLevel();

        }

    }

    public static void setModeWitoutServices(RadwareServerCli serverCli, ConfigSyncMode mode, int timeout, String yesNo) throws Exception {
        try {
            if (yesNo==null) {
                throw new Exception("Please specify if you want to continue or not (y/n)");

            }
            String newMode = mode.getMode();
            if (newMode == null) {
                throw new Exception("please select a mode ");
            }
            String currentMode = getMode(serverCli);
            if (currentMode.equals(newMode)) return;
            boolean serviceNeedToGoDown = false, serviceNeedToGoUp = false, warningMessage = false;

            if (currentMode.equals(ConfigSyncMode.STANDBY.getMode()))
                serviceNeedToGoUp = true;
            else if ((currentMode.equals(ConfigSyncMode.ACTIVE.getMode()) || currentMode.equals(ConfigSyncMode.DISABLED.getMode())) && (newMode.equals(ConfigSyncMode.STANDBY.getMode())))
                serviceNeedToGoDown = true;

            BaseTestUtils.reporter.startLevel("Setting Mode to " + newMode);
            CliOperations.runCommand(serverCli, Menu.system().configSync().mode().set().build() + " " + newMode,  60 * 1000);
            if (serviceNeedToGoUp) {
                if ((serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1).contains("will start the configuration service"))) {
                    warningMessage = true;
                }

            } else if (serviceNeedToGoDown) {
                if ((serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1).contains("will stop the configuration service"))) {
                    warningMessage = true;
                }
            }

            if ((serviceNeedToGoDown || serviceNeedToGoUp) && !warningMessage )
                throw new Exception("No warning message been showed");
            if (warningMessage) {
                CliOperations.runCommand(serverCli, yesNo,  5 * 60 * 1000);
//                if (yesNo.equals(YesNo.YES.getText())) {
//                    if (!VisionServer.waitForVisionServerServicesToStartHA(serverCli, timeout)) {
//                        throw new Exception("Timeout : Services are not in the appropriate state for the new mode  ");
//                    }
//                }
            }
        } finally

        {
            BaseTestUtils.reporter.stopLevel();

        }

    }



    public static boolean verifyModeSet(RadwareServerCli serverCli, ConfigSyncMode expectedMode) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("verify 'system config-sync mode with expected value: " + expectedMode);
            String actualValue = getMode(serverCli);
            if (actualValue.equals(expectedMode.getMode())) {
                BaseTestUtils.reporter.report("setting mode to " + expectedMode + " succeeded");

                return true;
            } else {

                BaseTestUtils.reporter.report("setting mode to " + expectedMode + " failed");
                return false;
            }

        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static String getPeer(RadwareServerCli serverCli) throws Exception {


        try {

            BaseTestUtils.reporter.startLevel("get config-sync peer");
            CliOperations.runCommand(serverCli, Menu.system().configSync().peer().get().build());
            String result = serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);
            return result.replace(buildPeerText(""), "");
        } finally {
            BaseTestUtils.reporter.stopLevel();

        }
    }


    public static void setPeer(RadwareServerCli serverCli, String peer) throws Exception {


        try {
            BaseTestUtils.reporter.startLevel("set config-sync peer to : " + peer);
            CliOperations.runCommand(serverCli, Menu.system().configSync().peer().set().build() + " " + peer);


        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }


    public static boolean verifyPeerSet(RadwareServerCli serverCli, String expectedPeer) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("verify 'system config-sync peer with expected value: " + expectedPeer);
            String actualValue = getPeer(serverCli);
            if (actualValue.equals(expectedPeer)) {
                BaseTestUtils.reporter.report("setting peer to " + expectedPeer + " succeeded");
                return true;
            } else {

                BaseTestUtils.reporter.report("setting peer to " + expectedPeer + " failed");
                return false;
            }

        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static void verifyStatus(int interval, ConfigSyncMode mode, String peerAddress, RadwareServerCli serverCli, LastConfiguration lastConfiguration) throws Exception {


        if (interval == 0 || mode == null || peerAddress == null || lastConfiguration == null)
            throw new Exception("One of the params of the test is equal to null");


        try {

            BaseTestUtils.reporter.startLevel("Verifying status settings ");
            BaseTestUtils.reporter.report("Verifying status settings");
            //doing invoke with empty command so i can get the right response when i call getCmdOutput
            CliOperations.runCommand(serverCli, "");
            String command = Menu.system().configSync().status().build();
            CliOperations.runCommand(serverCli, command);

            List<String> statusResponse = serverCli.getCmdOutput();
            if (statusResponse.size() == 0)
                throw new Exception("command '" + command + "' may not been executed properly");

            loop:
            for (int i = 0; i < statusResponse.size(); i++) {
                switch (i) {

                    case 0:
                        String statusMode = statusResponse.get(0);
                        String expectedMode = buildModeText(mode.getMode());

                        if (!statusMode.equals(expectedMode))
                            throw new Exception("status mode value : " + statusMode + " is not equal to expected value :  " + expectedMode);
                        break;


                    case 1:
                        String statusInterval = statusResponse.get(i);
                        String expectedInterval = buildIntervalText(Integer.toString(interval));
                        expectedInterval = fixIntervalText(expectedInterval);

                        if (!statusInterval.equals(expectedInterval))
                            throw new Exception("status interval value : " + statusInterval + " is not equal to expected value :  " + expectedInterval);
                        break;


                    case 2:
                        String statusPeer = statusResponse.get(i);
                        String expectedPeer = buildPeerText(peerAddress);
                        if (!statusPeer.equals(expectedPeer))
                            throw new Exception("status peer value: " + statusPeer + " is not equal to expected value :  " + expectedPeer);
                        break;

                    case 3:
                        String statusDate = statusResponse.get(3);
                        String expectedDate = "Last Configuration Sync Date: ";
                        String statusTimestamp = statusResponse.get(4);
                        String expectedTimeStamp = "Last Configuration Sync Timestamp: ";

                        if ((lastConfiguration == LastConfiguration.NA)) {
                            if (!statusDate.matches(expectedDate + "NA")) {
                                throw new Exception(statusDate + " - Does not match " + expectedDate + "NA");
                            }
                            if (!(statusTimestamp.matches(expectedTimeStamp + "NA"))) {
                                throw new Exception(statusTimestamp + " - Does not match " + expectedTimeStamp + "NA");

                            }
                        } else if (lastConfiguration == LastConfiguration.DATE) {
                            if (!statusDate.matches(expectedDate + "\\d+.+\\d+")) {
                                throw new Exception(statusDate + " - Does not match a Date pattern ");
                            }

                            if (!(statusTimestamp.matches(expectedTimeStamp + "\\d+")))
                                throw new Exception(statusTimestamp + " - Does not match a Timestamp pattern ");

                        }

                        break loop;


                }
            }

        } finally {
            BaseTestUtils.reporter.stopLevel();

        }
    }

    public static java.util.Date getDateFromStatus(RadwareServerCli serverCli) throws Exception {


        BaseTestUtils.reporter.startLevel("Get Date from config-sync status.");
        SimpleDateFormat df = new SimpleDateFormat(Date.DATE_STATUS_PATTERN);
        CliOperations.runCommand(serverCli, Menu.system().configSync().status().build());
        String date = "";
        for (int i = 0; i < serverCli.getCmdOutput().size(); i++) {
            String row = serverCli.getCmdOutput().get(i);
            if (row.contains("Last Configuration Sync Date:")) {
                date = serverCli.getCmdOutput().get(i);
                break;
            }
        }

        return df.parse(RegexUtils.getGroupWithPattern("\\d.*\\d", date));


    }

    public static long getTimeStampFromStatus(RadwareServerCli serverCli) throws Exception {

        try {
            BaseTestUtils.reporter.startLevel("Get timeStamp from config-sync status.");
            CliOperations.runCommand(serverCli, Menu.system().configSync().status().build());
            String date = serverCli.getCmdOutput().get(serverCli.getCmdOutput().size() - 1);
            date = date.replaceAll("\\D", "");//delete all non digits from the string
            return Long.parseLong(date);

        } finally {

            BaseTestUtils.reporter.stopLevel();
        }

    }

    public static void manualSync(RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.startLevel("invoke manual sync");
        CliOperations.runCommand(serverCli, Menu.system().configSync().manual().build());
        BaseTestUtils.reporter.stopLevel();

    }

    public static void verifyManualSync(long activeLastTime, long standbyLastTime) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify Manual Sync");
            long result = Math.abs(standbyLastTime - activeLastTime);
            result /= 1000;
            int delayTime = (int) Math.rint(result);
            if (delayTime <= 30) {
                BaseTestUtils.reporter.report("Manual sync from active to manual occured within " + delayTime + " seconds", Reporter.PASS);
            } else
                BaseTestUtils.reporter.report("Manual sync from active to manual not occured", Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static long getTimeBetweenStatusAndRadware(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Getting the time for the next sync.");
            java.util.Date radwareDate = Date.getRadwareDate((serverCli));
            return Math.abs(radwareDate.getTime() - getDateFromStatus(serverCli).getTime());


        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static String fixIntervalText(String interval) {
        return interval.replace("(", " (");
    }

    public static String buildIntervalText(String interval) {
        return "Interval: " + interval + "(Minutes)";
    }

    public static String buildModeText(String mode) {
        return "Mode: " + mode;
    }

    public static String buildPeerText(String peer) {
        return "Peer Address: " + peer;
    }


}
