package com.radware.vision.bddtests.clioperation.menu.system.backup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.vision_handlers.system.ConfBackup;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import com.radware.vision.bddtests.CliNegative;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class ConfBackupNegativeSteps extends CliNegative {
    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    private final String CONFBACKUP_NAME = "NoNameCB";
    public void initNegativeBackup() throws Exception {
        ConfBackup.deleteConfBackup(CONFBACKUP_NAME, restTestBase.getRadwareServerCli());
    }

    /**
     * The test check the confbackup create negative tests
     * */
    @When("^CLI Conf Backup Create Negative Test$")
    public void confbackupCreateNegativeTest() throws Exception {
        uiInit();
        initNegativeBackup();
        ArrayList<InvalidInputDataType> invailedDataList = new ArrayList<InvalidInputDataType>(Arrays.asList(InvalidInputDataType.NAME));
        run(Menu.system().backup().config().create().build(),invailedDataList, GoodErrorsList.BACKUP_NEGATIVE_LIST);
        namesNotToFindInListRadware(Menu.system().backup().config().list().build(), invailedDataList);
        afterMethod();
    }

    /**
     * The test check the confbackup delete negative tests
     * */
    @When("^CLI Conf Backup Delete Negative Test$")
    public void confbackupDeleteNegativeTest() throws Exception {
        cliNegativeTests.init();
        initNegativeBackup();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME));
        cliNegativeTests.run(Menu.system().backup().config().delete().build(), invailedDataList , CliNegativeTests.GoodErrorsList.BACKUP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * the function :
     * 1. 	Export not existing file
     * 2.	create new file
     * 3.	Export with bad ip
     * 4.	Export with bad password
     * */
    public void confbackupExportNegativeTest(ImportExport.ImportExportType importExportType, String hostIp, String password) throws Exception  {
        exportNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, importExportType.toString()+"://root@"+ hostIp +":/home/radware", password);
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
    public void confBackupExportProtocolNegativeTest(String protocol) throws Exception  {
        uiInit();
        initNegativeBackup();
        protocol.toLowerCase();
        String host = restTestBase.getGenericLinuxServer().getHost();
        String password = restTestBase.getGenericLinuxServer().getPassword();
        if(protocol.equals("ftp")){ confbackupExportNegativeTest(ImportExport.ImportExportType.ftp, host , password);}
        else if(protocol.equals("sftp")){confbackupExportNegativeTest(ImportExport.ImportExportType.sftp, "1.1.1.1" , password);}
        else if(protocol.equals("ssh")){confbackupExportNegativeTest(ImportExport.ImportExportType.ssh, host, "bad_password" );}
        else if(protocol.equals("scp")){confbackupExportNegativeTest(ImportExport.ImportExportType.scp, "1.1.1.1" , "bad_password");}
        else {
            BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
        }
        afterMethod();
    }

    @When("^CLI Conf Backup Export File Negative Test$")
    public void confBackupExportFileNegativeTest() throws Exception  {
        uiInit();
        initNegativeBackup();
        exportNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, "file:"+CONFBACKUP_NAME);
        afterMethod();
    }

    /**
     * the function :
     * 1. 	Import not existing file
     * 2.	create new file
     * 3.	Import with bad ip
     * 4.	Import with bad password
     * */
    public void confbackupImportNegativeTest(ImportExport.ImportExportType importExportType, String hostIp, String password) throws Exception  {
        importNegativeTest(Menu.system().backup().config().build(), password, importExportType+"://root@"+ hostIp +":"+ImportExport.getPath(importExportType)+ CONFBACKUP_NAME + ".tar");

    }

    /**
     * the function :
     * 1. 	Import not existing file
     * 2.	create new file
     * 3.	Import with bad ip
     * 4.	Import with bad password
     * */
    @When("^CLI Conf Backup Import Protocol \"(.*)\" Negative Test$")
    public void confbackupImportProtocolNegativeTest(String protocol) throws Exception  {
        uiInit();
        initNegativeBackup();
        protocol.toLowerCase();
        String host = restTestBase.getGenericLinuxServer().getHost();
        String password = restTestBase.getGenericLinuxServer().getPassword();
        if(protocol.equals("ftp")){ confbackupImportNegativeTest(ImportExport.ImportExportType.ftp, host, password);}
        else if(protocol.equals("sftp")){confbackupImportNegativeTest(ImportExport.ImportExportType.sftp, host, "bad_password");}
        else if(protocol.equals("ssh")){confbackupImportNegativeTest(ImportExport.ImportExportType.ssh, "1.1.1.1", host);}
        else if(protocol.equals("scp")){confbackupImportNegativeTest(ImportExport.ImportExportType.scp, "1.1.1.1", "bad_password");}
        else {
            BaseTestUtils.report(protocol + " is not supported here!", Reporter.FAIL);
        }
        afterMethod();
    }

    @When("^CLI Conf Backup Import File Negative Test$")
    public void confbackupImportFileNegativeTest() throws Exception {
        initNegativeBackup();
        importNegativeTest(Menu.system().backup().config().build(), CONFBACKUP_NAME, "file://"+CONFBACKUP_NAME+".tar");
        afterMethod();
    }

    @When("^CLI Conf Backup Restore Negative Test$")
    public void confbackupRestoreNegativeTest() throws Exception {
        cliNegativeTests.init();
        initNegativeBackup();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME));
        cliNegativeTests.run(Menu.system().backup().config().restore().build(), invailedDataList, CliNegativeTests.GoodErrorsList.BACKUP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Conf Backup Info Negative Test$")
    public void confBackupInfoNegativeTest() throws Exception {
        cliNegativeTests.init();
        initNegativeBackup();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME));
        cliNegativeTests.run(Menu.system().backup().config().info().build(), invailedDataList, CliNegativeTests.GoodErrorsList.BACKUP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Conf Backup Negative Test$")
    public void confBackupNegativeTest() throws Exception {
        cliNegativeTests.init();
        initNegativeBackup();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.system().backup().config().build(), invailedDataList, CliNegativeTests.GoodErrorsList.BACKUP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }



}
