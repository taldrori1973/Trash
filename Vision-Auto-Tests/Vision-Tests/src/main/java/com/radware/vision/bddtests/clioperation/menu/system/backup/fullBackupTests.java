package com.radware.vision.bddtests.clioperation.menu.system.backup;

import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.test_parameters.ImportExport.ImportExportType;
import com.radware.vision.vision_handlers.system.Backup;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.When;

public class fullBackupTests extends BddCliTestBase {

    @When("^CLI Create full backup with name \"(.*)\"$")
    public void createFullBackup(String backupName) {
        Backup.createFullBackup(backupName, "created_by_automation", restTestBase.getRadwareServerCli());
    }

    @When("^CLI Delete full backup with name \"(.*)\"$")
    public void deleteCFullBackup(String backupName) {
        Backup.deleteFullBackup(backupName, restTestBase.getRadwareServerCli());
    }

    @When("^CLI Restore full backup with name \"(.*)\"$")
    public void restoreFullBackup(String backupName) {
        Backup.restoreFullBackup(backupName, restTestBase.getRadwareServerCli());
    }

    @When("^CLI Export full backup with name \"(.*)\" to remote server using \"(.*)\" protocol$")
    public void exportConfigurationBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        Backup.exportFullBackup(backupName, restTestBase.getRadwareServerCli(),
                importExportType.toString() + "://root@"
                        + restTestBase.getLinuxFileServer().getHost() + ":"
                        + ImportExport.getPath(importExportType) + backupName
                , restTestBase.getLinuxFileServer().getPassword());
    }

    @When("^CLI Import full backup with name \"(.*)\" from remote server using \"(.*)\" protocol$")
    public void importFullBackup(String backupName, String protocol) {
        ImportExportType importExportType = ImportExportType.valueOf(protocol);
        Backup.importFullBackup(backupName, restTestBase.getRadwareServerCli(),
                importExportType.toString() + "://root@"
                        + restTestBase.getLinuxFileServer().getHost() + ":"
                        + ImportExport.getPath(importExportType)
                , restTestBase.getLinuxFileServer().getPassword());
    }
}
