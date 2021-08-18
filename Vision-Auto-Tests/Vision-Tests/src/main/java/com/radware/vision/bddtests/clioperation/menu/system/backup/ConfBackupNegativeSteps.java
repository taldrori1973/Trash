package com.radware.vision.bddtests.clioperation.menu.system.backup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.bddtests.CliNegative;
import com.radware.vision.system.ConfBackup;
import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.utils.SutUtils;

import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class ConfBackupNegativeSteps extends CliNegative {
    CliNegative CliNegative=new CliNegative();

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    private final String CONFBACKUP_NAME = "NoNameCB";
    public void initNegativeBackup()  {
        try {
            ConfBackup.deleteConfBackup(CONFBACKUP_NAME, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);        }
    }

    /**
     * The test check the confbackup create negative tests
     * */
    @When("^CLI Conf Backup Create Negative Test$")
    public void confbackupCreateNegativeTest()  {
        try {
            init();
            initNegativeBackup();
            ArrayList<InvalidInputDataType> invailedDataList = new ArrayList<InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME));
            run(Menu.system().backup().config().create().build(),invailedDataList, GoodErrorsList.BACKUP_NEGATIVE_LIST);
            namesNotToFindInListRadware(Menu.system().backup().config().list().build(), invailedDataList);
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * The test check the confbackup delete negative tests
     * */
    @When("^CLI Conf Backup Delete Negative Test$")
    public void confbackupDeleteNegativeTest()  {
        try {
            CliNegative.init();
            initNegativeBackup();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<CliNegative.InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME));
            CliNegative.run(Menu.system().backup().config().delete().build(), invailedDataList , GoodErrorsList.BACKUP_NEGATIVE_LIST);
            CliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * the function :
     * 1. 	Export not existing file
     * 2.	create new file
     * 3.	Export with bad ip
     * 4.	Export with bad password
     * */
    public void confbackupExportNegativeTest(ImportExport.ImportExportType importExportType)   {
        try {
            exportNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, importExportType.toString()+"://root@"+ SutUtils.getCurrentVisionIp() +":/home/radware");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * The test check the confbackup export ${file type} negative tests
     * Each of the import tests (not the file) :
     * 	1.	system confbackup export with not existing file
     * 	2.	system confbackup create
     * 	3.	system confbackup export with bad ip
     * 	4.	system confbackup export with bad password
     * */
    @When("^CLI Conf Backup Export Protocol \"(.*)\" Negative Test$")
    public void confBackupExportProtocolNegativeTest(String protocol)   {
        try {
            init();
            initNegativeBackup();
            protocol.toLowerCase();
            if(protocol.equals("ftp")){ confbackupExportNegativeTest(ImportExport.ImportExportType.ftp);}
            else if(protocol.equals("sftp")){confbackupExportNegativeTest(ImportExport.ImportExportType.sftp);}
            else if(protocol.equals("ssh")){confbackupExportNegativeTest(ImportExport.ImportExportType.ssh);}
            else if(protocol.equals("scp")){confbackupExportNegativeTest(ImportExport.ImportExportType.scp);}
            else {
                BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
            }
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Conf Backup Export File Negative Test$")
    public void confBackupExportFileNegativeTest()   {
        try {
            init();
            initNegativeBackup();
            exportNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, "file:"+CONFBACKUP_NAME);
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * the function :
     * 1. 	Import not existing file
     * 2.	create new file
     * 3.	Import with bad ip
     * 4.	Import with bad password
     * */
    public void confbackupImportNegativeTest(ImportExport.ImportExportType importExportType)   {
        try {
            importNegativeTest(Menu.system().backup().config().build(), importExportType, CONFBACKUP_NAME);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    /**
     * the function :
     * 1. 	Import not existing file
     * 2.	create new file
     * 3.	Import with bad ip
     * 4.	Import with bad password
     * */
    @When("^CLI Conf Backup Import Protocol \"(.*)\" Negative Test$")
    public void confbackupImportProtocolNegativeTest(String protocol)   {
        try {
            init();
            initNegativeBackup();
            protocol.toLowerCase();
            if(protocol.equals("ftp")){ confbackupImportNegativeTest(ImportExport.ImportExportType.ftp);}
            else if(protocol.equals("sftp")){confbackupImportNegativeTest(ImportExport.ImportExportType.sftp);}
            else if(protocol.equals("ssh")){confbackupImportNegativeTest(ImportExport.ImportExportType.ssh);}
            else if(protocol.equals("scp")){confbackupImportNegativeTest(ImportExport.ImportExportType.scp);}
            else {
                BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
            }
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Conf Backup Import File Negative Test$")
    public void confbackupImportFileNegativeTest()  {
        try {
            initNegativeBackup();
            importNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, "file://"+CONFBACKUP_NAME+".tar");
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Conf Backup Restore Negative Test$")
    public void confbackupRestoreNegativeTest()  {
        try {
            CliNegative.init();
            initNegativeBackup();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<CliNegative.InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME));
            CliNegative.run(Menu.system().backup().config().restore().build(), invailedDataList, GoodErrorsList.BACKUP_NEGATIVE_LIST);
            CliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Conf Backup Info Negative Test$")
    public void confBackupInfoNegativeTest()  {
        try {
            CliNegative.init();
            initNegativeBackup();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<CliNegative.InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME));
            CliNegative.run(Menu.system().backup().config().info().build(), invailedDataList, GoodErrorsList.BACKUP_NEGATIVE_LIST);
            CliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Conf Backup Negative Test$")
    public void confBackupNegativeTest()  {
        try {
            CliNegative.init();
            initNegativeBackup();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<CliNegative.InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME_WITHOUT_EMPTY));
            CliNegative.run(Menu.system().backup().config().build(), invailedDataList, GoodErrorsList.BACKUP_NEGATIVE_LIST);
            CliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }



}
