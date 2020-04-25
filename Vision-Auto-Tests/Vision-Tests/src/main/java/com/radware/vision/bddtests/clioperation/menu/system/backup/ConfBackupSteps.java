package com.radware.vision.bddtests.clioperation.menu.system.backup;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.test_parameters.ImportExport.ImportExportType;
import com.radware.vision.test_parameters.VisionServerConstants;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.file_server.LinuxFileServerVerifications;
import com.radware.vision.vision_handlers.root.RootVerifications;
import com.radware.vision.vision_handlers.system.ConfBackup;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_tests.CliTests;
import cucumber.api.java.en.When;

public class ConfBackupSteps extends BddCliTestBase {
    private static String confB0 = "confB0" + CliTests.backupFileSufix;
    private static String confB1 = "confB1" + CliTests.backupFileSufix;
    private static String confB2 = "confB2" + CliTests.backupFileSufix;
    private static String confB3 = "confB3" + CliTests.backupFileSufix;
    private static String confB4 = "confB4" + CliTests.backupFileSufix;
    private static String confB5 = "confB5" + CliTests.backupFileSufix;
    private static String confB6 = "confB6" + CliTests.backupFileSufix;
    String path = "/tmp/";

    @When("^CLI Create configuration backup with name \"(.*)\"$")
    public void createConfigurationBackup(String backupName) {
        ConfBackup.createConfigurationBackup(backupName, "created_by_automation", restTestBase.getRadwareServerCli());
    }

    @When("^CLI Delete configuration backup with name \"(.*)\"$")
    public void deleteConfigurationBackup(String backupName) {
        ConfBackup.deleteConfigurationBackup(backupName, restTestBase.getRadwareServerCli());
    }

    @When("^CLI Restore configuration backup with name \"(.*)\"$")
    public void restoreConfigurationBackup(String backupName) {
        ConfBackup.restoreConfigurationBackup(backupName, restTestBase.getRadwareServerCli());
    }

    @When("^CLI Export configuration backup with name \"(.*)\" to remote server using \"(.*)\" protocol$")
    public void exportConfigurationBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        ConfBackup.exportConfigurationBackup(backupName, restTestBase.getRadwareServerCli(),
                importExportType.toString() + "://root@"
                        + restTestBase.getLinuxFileServer().getHost() + ":"
                        + ImportExport.getPath(importExportType) + backupName
                , restTestBase.getLinuxFileServer().getPassword());
    }

    @When("^CLI Import configuration backup with name \"(.*)\" from remote server using \"(.*)\" protocol$")
    public void importConfigurationBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        ConfBackup.importConfigurationBackup(backupName, restTestBase.getRadwareServerCli(),
                importExportType.toString() + "://root@"
                        + restTestBase.getLinuxFileServer().getHost() + ":"
                        + ImportExport.getPath(importExportType)
                , restTestBase.getLinuxFileServer().getPassword());
    }

    /**
     * The Scenario :
     * 1.	system confBackup (verify the sub menu)
     */
    @When("^CLI System Conf Backup Sub Menu$")
    public void systemConfBackupSubMenu() {

        try {
            ConfBackup.systemConfBackupSubMenuCheck(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Creating confBackup and verifying it's confBackup really created and can be restored
     */
    @When("^CLI Conf Backup Create Max Number Of Conf Backups$")
    public void confBackupCreateMaxNumber() {
        try {
            afterMethod();
            ConfBackup.confBackupCreate(confB0, "0created_by_automation", restTestBase.getRadwareServerCli());
            RootVerifications.verifyDirectoryExists(VisionServerConstants.VISION_CONFBACKUP_PATH + confB0 + "/", restTestBase.getRootServerCli());
            ConfBackup.confBackupInfo(confB0, "0created_by_automation", VisionServerConstants.VISION_CONFBACKUP_PATH + confB0 + "/", restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
            ConfBackup.confBackupRestore(confB0, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * Creating more then 5 confBackups and verifying that only 5 were saved
     */
    @When("^CLI Conf Backup Save Test$")
    public void confBackupSaveTest() {
        try {
            afterMethod();
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB2, "2created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB3, "3created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB4, "4created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB5, "5created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB6, "6created_by_automation", restTestBase.getRadwareServerCli());
            String[] confBackupNames = {confB2, confB3, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRadware(confBackupNames, restTestBase.getRadwareServerCli());
            ConfBackup.verifyConfBackupListRoot(confBackupNames, restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	system confBackup create confB1 1created_by_automation
     * 2.	Verify directory was created in the file system via root user /opt/radware/storage/backup/ConfBackup_confB1/
     * 3.	system confBackup info confB1
     */
    @When("^CLI Conf Backup Info$")
    public void confBackupInfo() {
        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            RootVerifications.verifyDirectoryExists(VisionServerConstants.VISION_CONFBACKUP_PATH + confB1 + "/", restTestBase.getRootServerCli());
            ConfBackup.confBackupInfo(confB1, "1created_by_automation", VisionServerConstants.VISION_CONFBACKUP_PATH + confB1 + "/", restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	System confBackup create confB1
     * 2.	verify exist via root /opt/radware/storage/backup/ConfBackup_confB1/
     * 3.	system ConfBackup List
     * 4.	verify exist via root ll /opt/radware/storage/backup | grep ConfBackup
     * 5.	verify exist via root ll /opt/radware/storage/backup | grep ConfBackup -c
     */
    @When("^CLI System Conf Backup List$")
    public void systemConfBackupList() {
        try {
            afterMethod();
            String[] confBackupNames = {confB2, confB3, confB4, confB5, confB6};
            for (int i = 0; i < confBackupNames.length; i++) {
                ConfBackup.confBackupCreate(confBackupNames[i], Integer.toString(i + 2) + "created_by_automation", restTestBase.getRadwareServerCli());
            }
            ConfBackup.confBackupList(restTestBase.getRadwareServerCli(), confBackupNames);
            RootVerifications.verifyLinuxOSParamsViaRootText("ll " + VisionServerConstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup", confBackupNames, restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ll " + VisionServerConstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup -c ", "5", restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	system confBackup create confB1 1created_by_automation
     * 2.	export the confBackup file
     * 3.	verify on the remote with ls that the file exist
     */
    @When("^CLI Verify System ConfBackup Export \"(.*)\" Protocol$")
    public void systemConfBackupExportProtocol(String protocol) {
        protocol = protocol.toLowerCase();
        if (protocol.equals("ftp")) {
            systemConfBackupExport(ImportExportType.ftp, "root");
        } else if (protocol.equals("sftp")) {
            systemConfBackupExport(ImportExportType.sftp, "root");
        } else if (protocol.equals("ssh")) {
            systemConfBackupExport(ImportExportType.ssh, "root");
        } else if (protocol.equals("scp")) {
            systemConfBackupExport(ImportExportType.scp, "root");
        } else {
            BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
        }
        afterMethod();
    }

    private void systemConfBackupExport(ImportExportType importExportType, String username) {

        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.exportConfBackup(confB1, restTestBase.getRadwareServerCli(), importExportType.toString() + "://" + username + "@" + restTestBase.getLinuxFileServer().getHost() + ":" + ImportExport.getPath(importExportType) + confB1, restTestBase.getLinuxFileServer().getPassword());
            LinuxFileServerVerifications.verifyDirectoryExists("ls " + ImportExport.getPath(importExportType) + confB1 + ".tar", restTestBase.getLinuxFileServer());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    @When("^CLI System backup Export \"(.*)\" Protocol$")
    public void systemBackupTwoMachines(String protocol) {
        try {
            String targetIP = restTestBase.getRootServerCli().getHost();
            String sourceIP = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli sourceServerCli = new RadwareServerCli(sourceIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            sourceServerCli.disconnect();
            sourceServerCli.init();
            sourceServerCli.connect();
            ConfBackup.deleteConfBackup(confB1, sourceServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", sourceServerCli);
            sourceServerCli.connect();
            ConfBackup.exportConfBackup(confB1, sourceServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path + confB1, restTestBase.getLinuxFileServer().getPassword());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    @When("^CLI System restore backup \"(.*)\" Protocol$")
    public void systemBackupRestoreTwoMachines(String protocol) {
        try {
            String targetIP = restTestBase.getRootServerCli().getHost();
            restTestBase.getRadwareServerCli().connect();
            ConfBackup.importConfigurationBackup(confB1, restTestBase.getRadwareServerCli(), protocol + "://" + "root" + "@" + targetIP + ":" + path , "radware");
            ConfBackup.confBackupRestore(confB1, restTestBase.getRadwareServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
//        afterMethod();
    }


    @When("^CLI Verify Backup and Restore two machines with \"(.*)\" Protocol$")
    public void systemBackupAndRestoreTwoMachines(String protocol) {
        try {
            String targetIP = restTestBase.getRootServerCli().getHost();
            String sourceIP = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli sourceServerCli = new RadwareServerCli(sourceIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            sourceServerCli.init();
            ConfBackup.deleteConfBackup(confB1, sourceServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", sourceServerCli);
            ConfBackup.exportConfBackup(confB1, sourceServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path + confB1, restTestBase.getLinuxFileServer().getPassword());
            restTestBase.getRadwareServerCli().connect();
            ConfBackup.importConfigurationBackup(confB1, restTestBase.getRadwareServerCli(), protocol + "://" + "root" + "@" + targetIP + ":" + path , "radware");
            ConfBackup.confBackupRestore(confB1, restTestBase.getRadwareServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }






    @When("^CLI Verify Configuartion between two machines$")
    public void systemBackupAndRestoreTwoMachinesTwoMachinesconfigaurations() {

    }


    /**
     * The Scenario :
     * 1.	system confBackup create confB1 1created_by_automation
     * 2.	export the confBackup file
     */
    @When("^CLI System ConfBackup Export File$")
    public void systemConfBackupExportFile() {

        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.exportConfBackupFile(confB1, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	System confBackup create confB1
     * 2.	verify exist via root /opt/radware/storage/backup/ConfBackup_confB1/
     */
    @When("^CLI Verify System Conf Backup Create$")
    public void systemConfBackupCreate() {
        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            RootVerifications.verifyDirectoryExists(VisionServerConstants.VISION_CONFBACKUP_PATH + confB1 + "/", restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	System confBackup create confB1
     * 2.	verify exist via root /opt/radware/storage/backup/ConfBackup_confB1/
     * 3.	system ConfBackup Restore
     */
    @When("^CLI Verify System Conf Backup Restore$")
    public void systemConfBackupRestore() throws Exception {
        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            RootVerifications.verifyDirectoryExists(VisionServerConstants.VISION_CONFBACKUP_PATH + confB1 + "/", restTestBase.getRootServerCli());
            ConfBackup.confBackupRestore(confB1, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            InvokeCommon.repairTheRestore(restTestBase.getRadwareServerCli(), "10.205.1.1");
            afterMethod();
        }

    }

    /**
     * The Scenario :
     * 1.	Create 5 confBackup# users
     * 2.	Verify directory was list all the confBackup#s was created
     * 3.	Delete confBackup3
     * 4.	Verify via root that confBackup3 was deleted
     */
    @When("^CLI Verify System conf Backup Delete$")
    public void systemConfBackupDelete() {
        try {
            afterMethod();
            ConfBackup.confBackupCreate(confB2, "2created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB3, "3created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB4, "4created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB5, "5created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB6, "6created_by_automation", restTestBase.getRadwareServerCli());

            String[] confBackupNames = {confB2, confB3, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRadware(confBackupNames, restTestBase.getRadwareServerCli());

            ConfBackup.deleteConfBackup(confB3, restTestBase.getRadwareServerCli());
            String[] confBackupNamesAfterDelete = {confB2, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRoot(confBackupNamesAfterDelete, restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    private void systemBackupImport(ImportExportType importExportType, String username) {

        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.exportConfBackup(confB1, restTestBase.getRadwareServerCli(), importExportType.toString() + "://" + username + "@" + restTestBase.getLinuxFileServer().getHost() + ":" + ImportExport.getPath(importExportType) + confB1, restTestBase.getLinuxFileServer().getPassword());
            LinuxFileServerVerifications.getLsString(ImportExport.getPath(importExportType) + confB1 + ".tar", confB1, restTestBase.getLinuxFileServer());
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            String[] confBackupNameArr = {confB1};
            ConfBackup.verifyConfBackupNotInListRadware(confBackupNameArr, restTestBase.getRadwareServerCli());
            ConfBackup.importConfBackup(confB1, restTestBase.getRadwareServerCli(), importExportType.toString() + "://" + username + "@" + restTestBase.getLinuxFileServer().getHost() + ":" + ImportExport.getPath(importExportType), restTestBase.getLinuxFileServer().getPassword());
            ConfBackup.verifyConfBackupListRadware(confBackupNameArr, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	System confBackup create confB1 1created_by_automation
     * 2.	System confBackup export confB1 ftp://radware@[linuxFileServer]:/home/radware/backups/backup1
     * 3.	Via root user login to the ftp file server (ip [linuxFileServer])
     * 4.	ls /home/radware/backups/backup1.tar - verify confB1.tar
     * 5.	Delete the confBackup file.
     * 6.	Verify the list of without confB1
     * 7.	Import the confBackup file.
     * 8.	Verfiy the list of confB1
     */
    @When("^CLI Verify System Conf Backup Import \"(.*)\" Protocol$")
    public void systemBackupImportProtocol(String protocol) {
        protocol = protocol.toLowerCase();
        if (protocol.equals("ftp")) {
            systemBackupImport(ImportExportType.ftp, "root");
        } else if (protocol.equals("sftp")) {
            systemBackupImport(ImportExportType.sftp, "root");
        } else if (protocol.equals("ssh")) {
            systemBackupImport(ImportExportType.ssh, "root");
        } else if (protocol.equals("scp")) {
            systemBackupImport(ImportExportType.scp, "root");
        } else {
            BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * The Scenario :
     * 1.	System confBackup create confB1 1created_by_automation
     * 2.	System confBackup export confB1 file://confB1
     * 3.	Delete the confBackup file.
     * 6.	Verify the list of without confB1
     * 7.	Import the confBackup file.
     * 8.	Verfiy the list of confB1
     */
    @When("^CLI Verify System Conf Backup Import File$")
    public void systemBackupImportFile() {

        try {
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", restTestBase.getRadwareServerCli());
            ConfBackup.exportConfBackupFile(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            String[] confBackupNameArr = {confB1};
            ConfBackup.verifyConfBackupNotInListRadware(confBackupNameArr, restTestBase.getRadwareServerCli());
            ConfBackup.importConfBackupFile(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.verifyConfBackupListRadware(confBackupNameArr, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    //***********************************After methods**********************************************************
    private void afterMethod() {
        try {
            ConfBackup.deleteConfBackup(confB0, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB1, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB2, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB3, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB4, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB5, restTestBase.getRadwareServerCli());
            ConfBackup.deleteConfBackup(confB6, restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


}
