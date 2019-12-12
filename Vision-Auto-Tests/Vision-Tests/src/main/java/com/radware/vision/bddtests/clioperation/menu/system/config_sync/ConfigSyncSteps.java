package com.radware.vision.bddtests.clioperation.menu.system.config_sync;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.enums.LastConfiguration;
import com.radware.vision.enums.YesNo;
import com.radware.vision.vision_handlers.system.ConfigSync;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.vision_project_cli.HaManager;
import com.radware.vision.vision_project_cli.VisionServerHA;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;
import jsystem.framework.RunProperties;

public class ConfigSyncSteps extends BddCliTestBase {

    private String peer;




   @Given("^CLI set target vision \"(active|standby|disabled)\"$")
    public void setTargetVision(String mode) {

        try {
            ConfigSyncMode configSyncMode;
            try {
                configSyncMode = ConfigSyncMode.getConstant(mode);
            } catch (IllegalArgumentException e) {
                throw new Exception("there is no mode called: " + mode + " please enter active, standby or disabled mode!");
            }
            getRestTestBase().getHaManager().setHost(configSyncMode);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * this test will get the interval and verify it against the expected value.
     */

    @Given("^CLI verify get config-sync interval against expected with interval (\\d+)$")
    public void verifyGetConfigSyncIntervalTest(int interval) {
        try {
            int returnedValue = ConfigSync.getInterval(restTestBase.getRadwareServerCli());
            if (returnedValue == interval) {
                report.report("Interval is equal to " + interval + " as expected ", Reporter.PASS);

            } else {

                BaseTestUtils.report("Interval is equal to " + returnedValue + ". not to " + interval + " as expected ", Reporter.FAIL);

            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI set config-sync interval - with interval (\\d+)$")
    public void setConfigSyncIntervalTest(int interval) {


        try {

            ConfigSync.setInterval(restTestBase.getRadwareServerCli(), interval + "");
            if (ConfigSync.verifyIntervalSet(restTestBase.getRadwareServerCli(), interval + "")) {
                report.report("Verify Interval Set Succeeded", Reporter.PASS);
            } else {
                report.report("", Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    /**
     * this test will get the mode and verify it against the expected value.
     */

    @Given("^CLI verify get config-sync mode against expected - with mode \"(active|standby|disabled)\"$")
    public void verifyGetConfigSyncModeTest(String mode) {
        try {
            ConfigSyncMode configSyncMode;
            try {
                configSyncMode = ConfigSyncMode.getConstant(mode);
            } catch (IllegalArgumentException e) {
                throw new Exception("there is no mode called: " + mode + " please enter active, standby or disabled mode!");
            }

            if (configSyncMode==null) {
                throw new Exception("Please specify expected mode");
            }
            String returnedValue = ConfigSync.getMode(restTestBase.getRadwareServerCli());
            if (returnedValue.equals(configSyncMode.getMode())) {
                BaseTestUtils.report("mode is equal to " + mode + " as expected ", Reporter.PASS);

            } else {

                BaseTestUtils.report("mode is equal to " + returnedValue + ". not to " + configSyncMode.getMode() + " as expected ", Reporter.FAIL);

            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * This test performs these steps:
     * 1-sets the mode by running the command "system config-sync mode set"
     * 2-verifies that the service status compatible to the mode
     * 3-get the mode by running the command "system config-sync mode get"
     */
    @Given("^CLI set config-sync mode - with mode \"(active|standby|disabled)\" timeout (\\d+) YesNo \"(.*)\"$")
    public void setConfigSyncModeTest(String mode, int timeout, String yn) {
        YesNo yesNo;
        ConfigSyncMode configSyncMode;
        try {
            yesNo = YesNo.getConstant(yn);
            configSyncMode = ConfigSyncMode.getConstant(mode);
            ConfigSync.setMode(restTestBase.getRadwareServerCli(), configSyncMode, timeout, yesNo.getText());
            if (yesNo.equals(YesNo.YES)) {
                if (ConfigSync.verifyModeSet(restTestBase.getRadwareServerCli(), configSyncMode)) {
                    BaseTestUtils.report("Verify Mode Test Succeeded", Reporter.PASS);
                } else {
                    BaseTestUtils.report("", Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }


    }

    @Given("^CLI get config-sync peer$")
    public void getConfigSyncPeerTest() {

        try {

            ConfigSync.getPeer(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    /**
     * u can run the test by a given peer value or not to give any value .
     * if not give any value,this will be performed
     * check what is the host of the current vision
     * if its Host_1  runs the command "system config-sync peer set Host_2"
     * if its Host_2 runs the command "system config-sync peer set Host_1"
     * in both cases the value which been set will be returned
     * <p>
     * <p>
     * Add following statement <${peer}> to use returned parameter value in upcoming tests!
     */


    @Given("^CLI set config-sync peer(?: chosen Peer \"(.*)\")?$")
    public void setConfigSyncPeerTest(String chosenPeer) {


        try {
            if (chosenPeer == null) {
                VisionServerHA visionServerHA = restTestBase.getVisionServerHA();

                if (restTestBase.getRadwareServerCli().getHost().equals(visionServerHA.getHost_1())) {
                    peer = visionServerHA.getHost_2();
                } else if (restTestBase.getRadwareServerCli().getHost().equals(visionServerHA.getHost_2())) {
                    peer = visionServerHA.getHost_1();
                }

            } else {
                peer = chosenPeer;

            }
            RunProperties.getInstance().setRunProperty("peer", peer);
            ConfigSync.setPeer(restTestBase.getRadwareServerCli(), peer);
            if (!ConfigSync.verifyPeerSet(restTestBase.getRadwareServerCli(), peer)) {
                throw new Exception("couldn't set peer to " + peer);

            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }


    }

    /**
     * this test will get the peer and verify it against the expected value.
     */
    @Given("^CLI verify get config-sync peer against expected peer \"(.*)\"$")
    public void verifyGetConfigSyncPeerTest(String peer) {
        try {

            if (peer==null) {
                throw new Exception("Please specify expected peer");
            }
            String returnedValue = ConfigSync.getPeer(restTestBase.getRadwareServerCli());
            if (returnedValue.equals(peer)) {
                BaseTestUtils.report("peer is equal to " + peer + " as expected ", Reporter.PASS);

            } else {

                BaseTestUtils.report("peer is equal to " + returnedValue + ". not to " + peer + " as expected ", Reporter.FAIL);

            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * 1- run command:system config-sync status
     * 2- verify values against expected
     */


    @Given("^CLI Verify that the Redundancy settings are displayed interval (\\d+) mode \"(.*)\" peer \"(.*)\" last configuration \"(.*)\"$")
    public void configSyncStatus(int interval, String mode, String peer, String lastConfig ) {
        LastConfiguration lastConfiguration;
        ConfigSyncMode configSyncMode;
        try {
            configSyncMode=ConfigSyncMode.getConstant(mode);
            lastConfiguration=LastConfiguration.getConstant(lastConfig);

            ConfigSync.verifyStatus(interval, configSyncMode, peer, restTestBase.getRadwareServerCli(),lastConfiguration);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Verify that only the Active Vision instance its service up
     */

    @Given("^CLI verify Active And Standby Service Status$")
    public void verifyActiveAndStandbyServiceStatus() {

        try {
            HaManager haManager = restTestBase.getHaManager();
            if (VisionServer.isVisionServerRunningHA(haManager.getRadwareSessionByMode(ConfigSyncMode.ACTIVE)) &&
                    VisionServer.isVisionServerRunningHA(haManager.getRadwareSessionByMode(ConfigSyncMode.STANDBY))
                    )


                BaseTestUtils.report("Test passed ", Reporter.PASS);
            else {
                BaseTestUtils.report("Test Failed", Reporter.FAIL);

            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * verify that config-sync status display the last sync time
     * checks if the radware time - last sync time is greater that 10 seconds
     */

    @Given("^CLI checks if the last sync date updated -manual sync$")
    public void lastConfigSyncTime() {
        try {
            ConfigSync.manualSync(restTestBase.getHaManager().getRadwareSessionByMode(ConfigSyncMode.ACTIVE));
            long time = ConfigSync.getTimeBetweenStatusAndRadware(restTestBase.getRadwareServerCli());
            if (time / 1000 < 10)
                BaseTestUtils.report("manual sync was occurred.", Reporter.PASS);
            else
                BaseTestUtils.report("manual sync was not occurred,  ", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }




    @Given("^CLI manual sync$")
    public void manualSync() {

        try {
            ConfigSync.manualSync(restTestBase.getRadwareServerCli());

            BaseTestUtils.report("", Reporter.PASS);

        } catch (Exception e) {

            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }

    }

    /**
     * This tests waits for the next sync according to the value of the interval
     * steps:
     * 1- get interval value
     * 2-check time elapsed -->radware time -status time
     * 3-wait -->interval -time elapsed
     */

    @Given("^CLI Wait For Configuration Sync$")
    public void waitForConfigurationSync() {
        try {

           int interval = ConfigSync.getInterval(restTestBase.getRadwareServerCli());

            long timeElapsed = ConfigSync.getTimeBetweenStatusAndRadware(restTestBase.getRadwareServerCli());

            Thread.sleep((interval * 60 * 1000) - timeElapsed);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Given("^CLI Check Switchover Time$")
    public void checkSwitchoverTime() {
        try {
            ConfigSync.setMode(restTestBase.getRadwareServerCli(), ConfigSyncMode.STANDBY, 3 * 60 * 1000, YesNo.YES.getText());
            long preTime = System.currentTimeMillis();
            ConfigSync.setMode(restTestBase.getRadwareServerCli(), ConfigSyncMode.ACTIVE, 3 * 60 * 1000, YesNo.YES.getText());
            long afterTime = System.currentTimeMillis();
            long switchoverTime = afterTime - preTime;
            if (!(switchoverTime < 5 * 60 * 1000))
                throw new Exception("Switchover from standby to active took more than 5 minutes");
            BaseTestUtils.report("Switchover took:" + switchoverTime / 60 / 1000 + " minutes", Reporter.PASS);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * This test checks if the last sync time date gets updated after sync.
     * Requests:
     * **time out have to be at least 60 seconds
     * **have to be a vision in active mode
     * Steps:
     * 1-get config-sync status date
     * 2-wait timeout
     * 3-get config-sync date
     * 4-if last date -current date >= active vision interval
     */

    @Given("^CLI checks if the last sync date updated -interval with timeout (\\d+)$")
    public void checkIfLastSyncUpdated(int timeout) {
        int minute = 60000;
        try {
            if (timeout < minute) {

                throw new Exception("invalid given timeout ,this value have to be a least 60 seconds");
            }
            long oldDate = ConfigSync.getDateFromStatus(restTestBase.getRadwareServerCli()).getTime();
            Thread.sleep(timeout);
            int activeVisionInterval = ConfigSync.getInterval(restTestBase.getHaManager().getRadwareSessionByMode(ConfigSyncMode.ACTIVE));
            long currentDate = ConfigSync.getDateFromStatus(restTestBase.getRadwareServerCli()).getTime();
            if (currentDate - oldDate >= activeVisionInterval * minute - 5000) {
                BaseTestUtils.report("Status date have been updated ", Reporter.PASS);
            } else {
                BaseTestUtils.report("Status date did not updated -->old date -last date = " + (currentDate - oldDate) + " milliseconds", Reporter.FAIL);

            }
        } catch (Exception e) {

            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    @Given("^CLI Validate services state for vision mode$")
    public void validateServiesState() {

        try {
            if (!VisionServer.isVisionServerRunningHA(restTestBase.getRadwareServerCli())) {

                BaseTestUtils.report("", Reporter.FAIL);
            } else {
                BaseTestUtils.report("", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }

    }

    /*sub menus tests*/

    /*
     * read config-sync sub menu via user radware, sub menu should meet the cli design.
     */

    @Given("^CLI system config-sync sub menu$")
    public void systemConfigSyncSubMenu() {

        try {
            ConfigSync.configSyncSubMenuCheck(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /*
     * read interval sub menu via user radware, sub menu should meet the cli design.
     */
    @Given("^CLI System Config-Sync Interval usage$")
    public void systemConfigSyncIntervalUsageTest() {

        try {
            ConfigSync.intervalSetUsage(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    /*
     * read mode sub menu via user radware, sub menu should meet the cli design.
     */

    @Given("^CLI System Config-Sync Mode SubMenu$")
    public void systemConfigSyncModeSubMenuTest() {

        try {
            ConfigSync.modeSubMenuCheck(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI System Config-Sync Mode usage$")
    public void systemConfigSyncModeSetUsageTest() {

        try {
            ConfigSync.ModeSetUsage(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    /*
     * read peer sub menu via user radware, sub menu should meet the cli design.
     */
    @Given("^CLI System Config-Sync Peer SubMenu$")
    public void systemConfigSyncPeerSubMenuTest() {

        try {
            ConfigSync.peerSubMenuCheck(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI System Config-Sync Peer usage$")
    public void systemConfigSyncPeerSetUsageTest() {

        try {
            ConfigSync.peerSetUsage(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


// peer get
    public String getPeer(){
        return peer;
    }

}
