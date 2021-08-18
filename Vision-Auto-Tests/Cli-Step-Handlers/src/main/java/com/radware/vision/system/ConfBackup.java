package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ParamsValidations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.StringParametersUtils;
import com.radware.vision.root.GetRootOutput;
import com.radware.vision.root.RootConstants;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;
import utils.RegexUtils;

import java.util.ArrayList;
import java.util.List;

public class ConfBackup {

    public static final String SYSTEM_CONFBACKUP_SUB_MENU = "create                  Creates a system-configuration backup.\n"
            +"delete                  Deletes a system-configuration backup.\n"
            +"export                  Exports a system-configuration backup to a target.\n"
            +"import                  Imports a system-configuration backup from a source location.\n"
            +"info                    Displays information about a specified system-configuration.\n"
            +"list                    Lists the available system-configuration backups.\n"
            +"restore                 Restores the system from specified system-configuration backup.\n";

    /**
     * Deletes the specified conf backup if exists.
     *
     * @param confBackupName
     * @param serverCli
     * @throws Exception
     */
    public static void deleteConfBackup(String confBackupName, RadwareServerCli serverCli) throws Exception{

        try{
            BaseTestUtils.reporter.startLevel("Delete ConfBackup : " +confBackupName);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());

            if(serverCli.getTestAgainstObject().toString().contains(confBackupName)){
                CliOperations.runCommand(serverCli, Menu.system().backup().config().delete().build() + " " + confBackupName);
                CliOperations.runCommand(serverCli, "y");
                serverCli.analyze(new FindText("Remove completed."));
            }
        }
        finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    public static void deleteConfBackupWithoutList(String confBackupName, RadwareServerCli serverCli) throws Exception{

        try{
            BaseTestUtils.reporter.startLevel("Delete ConfBackup Without Check The List");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().delete().build() + " " + confBackupName);
            CliOperations.runCommand(serverCli, "y");
            serverCli.analyze(new FindText("Remove completed."));
        }
        finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Deletes the specified conf backup list if exists.
     *
     * @param confBackupNames
     * @param serverCli
     * @throws Exception
     */
    public static void deleteConfBackupList(String[] confBackupNames, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Delete ConfBackup List : " + confBackupNames);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            List<String> confBackupNamesForDelete = new ArrayList<String>();
            for (String confBackupName : confBackupNames) {
                if (serverCli.getTestAgainstObject().toString().contains(confBackupName)) {
                    confBackupNamesForDelete.add(confBackupName);

                }
            }
            for (String confBackupNameForDelete : confBackupNamesForDelete) {
                CliOperations.runCommand(serverCli, Menu.system().backup().config().delete().build() + " " + confBackupNameForDelete);
                CliOperations.runCommand(serverCli, "y");
                serverCli.analyze(new FindText("Remove completed."));
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * system confBackup export backupName
     *
     **/
    public static void exportConfBackup(String confBackupName, RadwareServerCli serverCli , String backUpDestenation, String remotePassword) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Export ConfBackup");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().export().build() + " " + confBackupName +" "+ backUpDestenation);
            serverCli.analyze(new FindText("If the database is large, this operation can take several minutes."));
            if(serverCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                CliOperations.runCommand(serverCli, "yes");
            }
            CliOperations.runCommand(serverCli, remotePassword, 3 * 60 * 1000);
            serverCli.analyze(new FindText("Export completed."));
            serverCli.analyze(new FindRegex("The configuration backup was successfully exported to " + backUpDestenation+".tar"));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static void exportConfBackupFile(String confBackupName, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Export ConfBackup File");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().export().build() + " " + confBackupName +" file://"+ confBackupName);
            serverCli.analyze(new FindText("Export completed."));
            serverCli.analyze(new FindRegex("The configuration backup was successfully exported to " +  "file://"+confBackupName+".tar"));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    /**
     * system confBackup create <name> <description>
     * Backs up the APSolute Vision system-configuration with the specified name.
     * set timeout to 3 minutes
     * @throws Exception
     */
    public static void confBackupCreate(String name, String description, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Export ConfBackup Create");
            ParamsValidations.validateStringNotEmpty(name);
            ParamsValidations.validateStringNotEmpty(description);
            String params = StringParametersUtils.stringArrayParamsToString(new String[] {name, description});
            CliOperations.runCommand(serverCli, Menu.system().backup().config().create().build() + params, 3*60*1000);
            serverCli.analyze(new FindText("Done."));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * system backup import backupName
     *
     **/
    public static void importConfBackup(String backupName, RadwareServerCli serverCli , String backUpLocation, String remotePassword) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Import ConfBackup");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().importBackup().build() + " " + backUpLocation + backupName + ".tar");
            if(serverCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                CliOperations.runCommand(serverCli, "yes");
            }
            CliOperations.runCommand(serverCli, remotePassword);
            serverCli.analyze(new FindText("Import completed."));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void importConfBackupFile(String backupName, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Import ConfBackup File");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().importBackup().build() + " file://"+ backupName + ".tar");
            serverCli.analyze(new FindText("Import completed."));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    /**
     * Displays information about a specified system-configuration.
     * Check disk size > 0
     * Date
     * System version
     * @param dirStr
     * @param userConnection
     * @throws Exception
     */
    public static void confBackupInfo(String name, String description, String dirStr, RadwareServerCli serverCli, RootServerCli userConnection) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup Info");
            ParamsValidations.validateStringNotEmpty(name);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().info().build() + " " + name);
            //Check disk size
            String diskSizeFromFile = serverCli.getStringCounter("Disk Size").replace(" Bytes", "");
            String diskSizeFromRootOutput = GetRootOutput.getDirSize(dirStr, userConnection);
            try{
                if (Integer.parseInt(diskSizeFromFile) <= 0){
                    throw new Exception("Illegal disk size :" + diskSizeFromFile);
                }
                if (Math.abs(Integer.parseInt(diskSizeFromRootOutput) - Integer.parseInt(diskSizeFromFile)) > 6000){
                    throw new Exception("size via root and via radware user has distance error bigger than 6000, " + diskSizeFromFile);
                }
            }catch(Exception e){
                throw new Exception("Couldn't read disk size\\illegal size ," + e.getMessage());
            }
            //Check description
            String fileDescription = serverCli.getStringCounter("Description");
            if (!fileDescription.equals(description)){
                throw new Exception("description of file ," + fileDescription + ", is different from the entered description ," + description);
            }

            //Check version
            String fileVersion = serverCli.getStringCounter("Version");
            String serverVersion = Version.getServerVersion(serverCli);
            if (!fileVersion.equals(serverVersion)){
                throw new Exception("file version ," + fileVersion + ", is different from the version on server ," + serverVersion);
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }


    /**
     * Restores the APSolute Vision system-configuration from the specified backup.
     * This command requires restarting the server.
     * set timeout to 5 minutes
     * @throws Exception
     */
    public static void confBackupRestore(String name, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup Restore");
            ParamsValidations.validateStringNotEmpty(name);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().restore().build() + " " + name);
            CliOperations.runCommand(serverCli, "y", 5*60*1000);
            serverCli.analyze(new FindText("Done."));
            serverCli.analyze(new FindRegex("Starting APSolute Vision Application Server:(\\.*\\s*)*G\\[  OK  \\]|\\[FAILED\\]"));
            serverCli.analyze(new FindText("You can access Vision Server"));
            //serverCli.analyze(new FindText("Reloading httpd:"));
            serverCli.analyze(new FindRegex("Starting Apsolute Vision Reporter Service:\\s*G\\[  OK  \\]"));
            serverCli.analyze(new FindRegex("Starting APSolute Vision Web Server\\s*G\\[  OK  \\]"));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * get the available system-configuration backups list via user root, verify existence of the input names and only them
     * Lists the available system-configuration backups.
     * @throws Exception
     */
    public static void verifyConfBackupListRadware(String[] names, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Verify ConfBackup List Radware");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            String pattern = "(\\w+" + ")\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, serverCli.getTestAgainstObject().toString());

            if (names.length != confBackupNames.size()){
                throw new Exception("list of confBackup isn't as expected: " + confBackupNames.toString());
            }
            for (String name: names){
                if(!confBackupNames.contains(name)){
                    throw new Exception(name + "is missing in confBackup list");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * verify that the names isn't in the list
     * @throws Exception
     */
    public static void verifyConfBackupNotInListRadware(String[] names, RadwareServerCli serverCli) throws Exception{
        try {
            BaseTestUtils.reporter.startLevel("Verify Not In ConfBackup List Radware");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            String pattern = "(\\w+" + ")\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, serverCli.getTestAgainstObject().toString());

            for (String name: names){
                if(confBackupNames.contains(name)){
                    throw new Exception(name + "is in confBackup list");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * get the available system-configuration backups list via user root, verify existence of the input names and only them
     * @param names - techSupportPackage names
     * @param userConnection
     * @throws Exception
     */
    public static void verifyConfBackupListRoot(String[] names, RootServerCli userConnection) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify ConfBackup List Root");
            CliOperations.runCommand(userConnection, "ll " + RootConstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup");
            String pattern = "ConfBackup_(\\w+)";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, userConnection.getTestAgainstObject().toString());

            if (names.length != confBackupNames.size()){
                throw new Exception("list of confBackup isn't as expected: " + confBackupNames);
            }
            for (String name: names){
                if(!confBackupNames.contains(name)){
                    throw new Exception(name + "is missing in confBackup list");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    /**
     * system confBackup
     */
    public static void systemConfBackupSubMenuCheck(RadwareServerCli radwareCliConnection) throws Exception {
        CliOperations.checkSubMenu(radwareCliConnection, Menu.system().backup().config().build(), SYSTEM_CONFBACKUP_SUB_MENU);
    }

    /**
     * system confBackup list
     * verify the output by the wanted names
     * */
    public static void confBackupList(RadwareServerCli serverCli , String [] namesToFind) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup List");
            String regex = "\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+\\d+.\\d+.\\d+.\\d+\\s+\\S+";
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            for (String name : namesToFind) {
                serverCli.analyze(new FindRegex(name+regex));
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }
}
