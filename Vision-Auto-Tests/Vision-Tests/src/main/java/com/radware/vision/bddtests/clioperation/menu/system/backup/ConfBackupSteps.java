package com.radware.vision.bddtests.clioperation.menu.system.backup;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.test_parameters.ImportExport.ImportExportType;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.TestParameters.VisionServerconstants;
import com.radware.vision.system.ConfBackup;
import cucumber.api.java.en.When;


public class ConfBackupSteps extends TestBase {
    private static final String confB0 = "confB0" + ConfBackup.backupFileSuffix;
    private static final String confB1 = "confB1" + ConfBackup.backupFileSuffix;
    private static final String confB2 = "confB2" + ConfBackup.backupFileSuffix;
    private static final String confB3 = "confB3" + ConfBackup.backupFileSuffix;
    private static final String confB4 = "confB4" + ConfBackup.backupFileSuffix;
    private static final String confB5 = "confB5" + ConfBackup.backupFileSuffix;
    private static final String confB6 = "confB6" + ConfBackup.backupFileSuffix;
    private static final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private static final RootServerCli rootServerCLI = serversManagement.getRootServerCLI().get();
    private static final LinuxFileServer linuxFileServer = serversManagement.getLinuxFileServer().get();
    String path = "/tmp/";

    @When("^CLI Create configuration backup with name \"(.*)\"$")
    public void createConfigurationBackup(String backupName) {
        ConfBackup.confBackupCreate(backupName, "created_by_automation", radwareServerCli);
    }

    @When("^CLI Delete configuration backup with name \"(.*)\"$")
    public void deleteConfigurationBackup(String backupName) {
        ConfBackup.deleteConfBackup(backupName, radwareServerCli);
    }

    @When("^CLI Restore configuration backup with name \"(.*)\"$")
    public void restoreConfigurationBackup(String backupName) {
        ConfBackup.confBackupRestore(backupName, radwareServerCli);
    }

    @When("^CLI Export configuration backup with name \"(.*)\" to remote server using \"(.*)\" protocol$")
    public void exportConfigurationBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        ConfBackup.exportConfBackup(backupName, radwareServerCli,
                importExportType.toString() + "://root@"
                        + linuxFileServer.getHost() + ":"
                        + ImportExport.getPath(importExportType) + backupName
                , linuxFileServer.getPassword(),rootServerCLI);
    }

    @When("^CLI Import configuration backup with name \"(.*)\" from remote server using \"(.*)\" protocol$")
    public void importConfigurationBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        ConfBackup.importConfBackup(backupName, radwareServerCli,
                importExportType.toString() + "://root@"
                        + linuxFileServer.getHost() + ":"
                        + ImportExport.getPath(importExportType)
                , linuxFileServer.getPassword());
    }

    /**
     * The Scenario :
     * 1.	system confBackup (verify the sub menu)
     */
    @When("^CLI System Conf Backup Sub Menu$")
    public void systemConfBackupSubMenu() {

        try {
            ConfBackup.systemConfBackupSubMenuCheck(radwareServerCli);
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
            ConfBackup.confBackupCreate(confB0, "0created_by_automation", radwareServerCli);
            CliOperations.verifyDirectoryExists(VisionServerconstants.VISION_CONFBACKUP_PATH + confB0 + "/", rootServerCLI);
            ConfBackup.confBackupInfo(confB0, "0created_by_automation", VisionServerconstants.VISION_CONFBACKUP_PATH + confB0 + "/", radwareServerCli, rootServerCLI);
            ConfBackup.confBackupRestore(confB0, radwareServerCli);
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
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB2, "2created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB3, "3created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB4, "4created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB5, "5created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB6, "6created_by_automation", radwareServerCli);
            String[] confBackupNames = {confB2, confB3, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRadware(confBackupNames, radwareServerCli);
            ConfBackup.verifyConfBackupListRoot(confBackupNames, rootServerCLI);
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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            CliOperations.verifyDirectoryExists(VisionServerconstants.VISION_CONFBACKUP_PATH + confB1 + "/", rootServerCLI);
            ConfBackup.confBackupInfo(confB1, "1created_by_automation", VisionServerconstants.VISION_CONFBACKUP_PATH + confB1 + "/", radwareServerCli, rootServerCLI);
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
                ConfBackup.confBackupCreate(confBackupNames[i], Integer.toString(i + 2) + "created_by_automation", radwareServerCli);
            }
            ConfBackup.confBackupList(radwareServerCli, confBackupNames);
              ConfBackup.verifyLinuxOSParamsViaRootText("ll " + VisionServerconstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup", confBackupNames, rootServerCLI);
              ConfBackup.verifyLinuxOSParamsViaRootText("ll " + VisionServerconstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup -c ", "5", rootServerCLI);
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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            ConfBackup.exportConfBackup(confB1, radwareServerCli, importExportType.toString() + "://" + username + "@" + linuxFileServer.getHost() + ":" + ImportExport.getPath(importExportType) + confB1, linuxFileServer.getPassword(),rootServerCLI);
            CliOperations.verifyDirectoryExists("ls " + ImportExport.getPath(importExportType) + confB1 + ".tar", linuxFileServer);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    @When("^CLI System backup Export \"(.*)\" Protocol$")
    public void systemBackupTwoMachines(String protocol) {
        try {
            String targetIP = clientConfigurations.getHostIp();
            String sourceIP = sutManager.getpair().getPairIp();
            RadwareServerCli radwareServerCli = ConfBackupSteps.radwareServerCli;
            RootServerCli rootServerCli = ConfBackupSteps.rootServerCLI;
            RadwareServerCli sourceServerCli = new RadwareServerCli(sourceIP, radwareServerCli.getUser(), radwareServerCli.getPassword());
            sourceServerCli.disconnect();
            sourceServerCli.init();
            sourceServerCli.connect();
            ConfBackup.deleteConfBackup(confB1,  sourceServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", sourceServerCli);
            sourceServerCli.connect();
            ConfBackup.exportConfBackup(confB1, sourceServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path + confB1, ConfBackupSteps.radwareServerCli.getPassword(),rootServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
//        afterMethod();
    }

    @When("^CLI System restore backup \"(.*)\" Protocol$")
    public void systemBackupRestoreTwoMachines(String protocol) {
        try {
            String targetIP = rootServerCLI.getHost();
            radwareServerCli.connect();
            ConfBackup.importConfBackup(confB1, radwareServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path , "radware");
            ConfBackup.confBackupRestore(confB1, radwareServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    @When("^CLI Verify Backup and Restore two machines with \"(.*)\" Protocol$")
    public void systemBackupAndRestoreTwoMachines(String protocol) {
        try {
            String targetIP = radwareServerCli.getHost();
            String sourceIP = sutManager.getpair().getPairIp();
            RadwareServerCli sourceServerCli = new RadwareServerCli(sourceIP, radwareServerCli.getUser(), radwareServerCli.getPassword());
            sourceServerCli.init();
            ConfBackup.deleteConfBackup(confB1, sourceServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", sourceServerCli);
            ConfBackup.exportConfBackup(confB1, sourceServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path + confB1, linuxFileServer.getPassword(),rootServerCLI);
            radwareServerCli.connect();
            ConfBackup.importConfBackup(confB1, radwareServerCli, protocol + "://" + "root" + "@" + targetIP + ":" + path , "radware");
            ConfBackup.confBackupRestore(confB1, radwareServerCli);

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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            ConfBackup.exportConfBackup(confB1, radwareServerCli, "1created_by_automation", ConfBackupSteps.radwareServerCli.getPassword(),rootServerCLI);
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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            CliOperations.verifyDirectoryExists(VisionServerconstants.VISION_CONFBACKUP_PATH + confB1 + "/", rootServerCLI);
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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            CliOperations.verifyDirectoryExists(VisionServerconstants.VISION_CONFBACKUP_PATH + confB1 + "/", radwareServerCli);
            ConfBackup.confBackupRestore(confB1, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            ConfBackup.repairTheRestore(radwareServerCli, "10.205.1.1");
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
            ConfBackup.confBackupCreate(confB2, "2created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB3, "3created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB4, "4created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB5, "5created_by_automation", radwareServerCli);
            ConfBackup.confBackupCreate(confB6, "6created_by_automation", radwareServerCli);
            String[] confBackupNames = {confB2, confB3, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRadware(confBackupNames, radwareServerCli);

            ConfBackup.deleteConfBackup(confB3, radwareServerCli);
            String[] confBackupNamesAfterDelete = {confB2, confB4, confB5, confB6};
            ConfBackup.verifyConfBackupListRoot(confBackupNamesAfterDelete, rootServerCLI);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    private void systemBackupImport(ImportExportType importExportType, String username) {

        try {
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            ConfBackup.exportConfBackup(confB1, radwareServerCli, importExportType.toString() + "://" + username + "@" + linuxFileServer.getHost() + ":" + ImportExport.getPath(importExportType) + confB1, linuxFileServer.getPassword(),rootServerCLI);
            ConfBackup.getLsString(ImportExport.getPath(importExportType) + confB1 + ".tar", confB1, linuxFileServer);
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            String[] confBackupNameArr = {confB1};
            ConfBackup.verifyConfBackupNotInListRadware(confBackupNameArr, radwareServerCli);
            ConfBackup.importConfBackup(confB1, radwareServerCli, importExportType.toString() + "://" + username + "@" + linuxFileServer.getHost() + ":" + ImportExport.getPath(importExportType), linuxFileServer.getPassword());
            ConfBackup.verifyConfBackupListRadware(confBackupNameArr, radwareServerCli);
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
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.confBackupCreate(confB1, "1created_by_automation", radwareServerCli);
            ConfBackup.exportConfBackup(confB1, radwareServerCli, "1created_by_automation", ConfBackupSteps.radwareServerCli.getPassword(),rootServerCLI);
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            String[] confBackupNameArr = {confB1};
            ConfBackup.verifyConfBackupNotInListRadware(confBackupNameArr, radwareServerCli);
            ConfBackup.importConfBackup(confB1, radwareServerCli, "://" + "root" + "@" + radwareServerCli.getHost() + ":" + path ,ConfBackupSteps.radwareServerCli.getPassword());
            ConfBackup.verifyConfBackupListRadware(confBackupNameArr, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    //***********************************After methods**********************************************************
    private void afterMethod() {
        try {
            ConfBackup.deleteConfBackup(confB0, radwareServerCli);
            ConfBackup.deleteConfBackup(confB1, radwareServerCli);
            ConfBackup.deleteConfBackup(confB2, radwareServerCli);
            ConfBackup.deleteConfBackup(confB3, radwareServerCli);
            ConfBackup.deleteConfBackup(confB4, radwareServerCli);
            ConfBackup.deleteConfBackup(confB5, radwareServerCli);
            ConfBackup.deleteConfBackup(confB6, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


}
