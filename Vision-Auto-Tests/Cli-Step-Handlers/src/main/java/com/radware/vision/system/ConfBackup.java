package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.basetest.RuntimePropertiesEnum;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.GlobalProperties;
import com.radware.vision.root.GetRootOutput;
import com.radware.vision.test_utils.RegexUtils;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;
import com.radware.vision.test_parameters.VisionServerConstants;

import java.util.ArrayList;


public class ConfBackup {

    public final static String backupFileSuffix = "_" + BaseTestUtils.getRuntimeProperty(RuntimePropertiesEnum.VISION_VERSION.name(), RuntimePropertiesEnum.VISION_VERSION.getDefaultValue());
    public static final String SYSTEM_CONF_BACKUP_SUB_MENU = "create                  Creates a system-configuration backup.\n"
            + "delete                  Deletes a system-configuration backup.\n"
            + "export                  Exports a system-configuration backup to a target.\n"
            + "import                  Imports a system-configuration backup from a source location.\n"
            + "info                    Displays information about a specified system-configuration.\n"
            + "list                    Lists the available system-configuration backups.\n"
            + "restore                 Restores the system from specified system-configuration backup.\n";

    /**
     * Deletes the specified conf backup if exists.
     * @param confBackupName
     * @param serverCli
     */
    public static void deleteConfBackup(String confBackupName, RadwareServerCli serverCli) {

        try {
            BaseTestUtils.reporter.startLevel("Delete ConfBackup : " + confBackupName);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            if (serverCli.getTestAgainstObject().toString().contains(confBackupName)) {
                CliOperations.runCommand(serverCli, Menu.system().backup().config().delete().build() + " " + confBackupName);
                if(!(CliOperations.lastOutput.contains("Remove completed."))){
                    BaseTestUtils.report("Failed to delete backup file: " + confBackupName + "\n" +
                            "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    /**
     * system confBackup export backupName
     * @param confBackupName
     * @param serverCli
     * @param backUpDestenation
     * @param remotePassword
     **/
    public static void exportConfBackup(String confBackupName, RadwareServerCli serverCli, String backUpDestenation, String remotePassword,RootServerCli rootServerCli) {
        try {
            BaseTestUtils.reporter.startLevel("Export ConfBackup");
            CliOperations.runCommand(rootServerCli,"rm -f /opt/radware/storage/backup/ConfBackup_"+confBackupName+"/db_access.txt",GlobalProperties.VISION_OPERATIONS_TIMEOUT);
            CliOperations.runCommand(serverCli, Menu.system().backup().config().export().build() + " " + confBackupName + " " + backUpDestenation, GlobalProperties.VISION_OPERATIONS_TIMEOUT);
            if(!(CliOperations.lastOutput.contains("If the database is large, this operation can take several minutes."))){
                BaseTestUtils.report("Failed to export backup file: " + confBackupName + "\n" +
                        "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
            }
            CliOperations.runCommand(serverCli, remotePassword, GlobalProperties.DEFAULT_TIME_WAIT_FOR_VISION_SERVICES_RESTART);
            if (!(CliOperations.lastOutput.contains("The configuration backup was successfully exported to " + backUpDestenation + ".tar.")) &&
                    (!(CliOperations.lastOutput.contains("Export completed.")))){
                    BaseTestUtils.report("Failed to export backup file: " + confBackupName + "\n" +
                            "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
                }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(),Reporter.FAIL);
        }
    }
    /**
     * system confBackup create <name> <description>
     * Backs up the APSolute Vision system-configuration with the specified name.
     * set timeout to 3 minutes
     */
    public static void confBackupCreate(String name, String description, RadwareServerCli serverCli) {
        try {
            BaseTestUtils.reporter.startLevel("Export ConfBackup Create");
            assert !name.equals("");
            assert !description.equals("");
            StringBuilder params = new StringBuilder(name + " " + description);
            CliOperations.runCommand(serverCli ,Menu.system().backup().config().create().build() + " " + params,GlobalProperties.DEFAULT_TIME_WAIT_FOR_VISION_SERVICES_RESTART );
            if(!(CliOperations.lastOutput.contains("Done."))){
                BaseTestUtils.report("Failed to create backup file: " + name + "\n" +
                        "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
           }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }
    }

    /**
     * system backup import backupName
     * @param backupName
     * @param serverCli
     * @param backUpLocation
     * @param remotePassword
     **/
    public static void importConfBackup(String backupName, RadwareServerCli serverCli, String backUpLocation, String remotePassword) {
        try {
            BaseTestUtils.reporter.startLevel("Import ConfBackup");
            CliOperations.runCommand(serverCli,"system backup config import " + backUpLocation + backupName + ".tar",GlobalProperties.VISION_OPERATIONS_TIMEOUT);
            CliOperations.runCommand(serverCli,remotePassword,GlobalProperties.VISION_OPERATIONS_TIMEOUT);
            if(!(CliOperations.lastOutput.contains("Import completed."))){
                BaseTestUtils.report("Failed to import backup file: " + backupName + "\n" +
                        "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }
    }

    /**
     * Displays information about a specified system-configuration.
     * Check disk size > 0
     * Date
     * System version
     *
     * @param dirStr
     * @param userConnection
     * @throws Exception
     */

    public static void confBackupInfo(String name, String description, String dirStr, RadwareServerCli serverCli, RootServerCli userConnection) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup Info");
            assert !name.equals("");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().info().build() + " " + name);
            //Check disk size
            String diskSizeFromFile = serverCli.getStringCounter("Disk Size").replace(" Bytes", "");
            String diskSizeFromRootOutput = GetRootOutput.getDirSize(dirStr, userConnection);
            try {
                if (Long.parseLong(diskSizeFromFile) <= 0) {
                    throw new Exception("Illegal disk size :" + diskSizeFromFile);
                }
                if (Math.abs(Long.parseLong(diskSizeFromRootOutput) - Long.parseLong(diskSizeFromFile)) > 6000) {
                    throw new Exception("size via root and via radware user has distance error bigger than 6000, " + diskSizeFromFile);
                }
            } catch (Exception e) {
                throw new Exception("Couldn't read disk size\\illegal size ," + e.getMessage());
            }
            //Check description
            String fileDescription = serverCli.getStringCounter("Description");
            if (!fileDescription.equals(description)) {
                throw new Exception("description of file ," + fileDescription + ", is different from the entered description ," + description);
            }

            //Check version
            String fileVersion = serverCli.getStringCounter("Version");
            String serverVersion = Version.getServerVersion(serverCli);
            if (!fileVersion.equals(serverVersion)) {
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
     */
    public static void confBackupRestore(String name, RadwareServerCli serverCli) {
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup Restore");
            assert !name.equals("");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().restore().build() + " " + name + " -retainlicenses", GlobalProperties.VISION_OPERATIONS_TIMEOUT);
            if (!CliOperations.lastOutput.contains("Restoring configuration.") && !CliOperations.lastOutput.contains("Done.")) {
                BaseTestUtils.report("Failed to restore backup file: " + name + "\n" +
                        "Due to the following output:\n" + serverCli.getCmdOutput(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }
    }
    /**
     * get the available system-configuration backups list via user root, verify existence of the input names and only them
     * Lists the available system-configuration backups.
     *
     * @throws Exception
     */
    public static void verifyConfBackupListRadware(String[] names, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify ConfBackup List Radware");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            String pattern = "(\\w+" + backupFileSuffix + ")\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, serverCli.getTestAgainstObject().toString());

            if (names.length != confBackupNames.size()) {
                throw new Exception("list of confBackup isn't as expected: " + confBackupNames.toString());
            }
            for (String name : names) {
                if (!confBackupNames.contains(name)) {
                    throw new Exception(name + "is missing in confBackup list");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * verify that the names isn't in the list
     *
     * @throws Exception
     */
    public static void verifyConfBackupNotInListRadware(String[] names, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify Not In ConfBackup List Radware");
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            String pattern = "(\\w+" + backupFileSuffix + ")\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, serverCli.getTestAgainstObject().toString());

            for (String name : names) {
                if (confBackupNames.contains(name)) {
                    throw new Exception(name + "is in confBackup list");
                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * get the available system-configuration backups list via user root, verify existence of the input names and only them
     *
     * @param names          - techSupportPackage names
     * @param userConnection
     * @throws Exception
     */
    public static void verifyConfBackupListRoot(String[] names, RootServerCli userConnection) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify ConfBackup List Root");
            CliOperations.runCommand(userConnection, "ll " + VisionServerConstants.VISION_STORAGE_BACKUP_DIR + " | grep ConfBackup");
            String pattern = "ConfBackup_(\\w+" + backupFileSuffix + ")";
            ArrayList<String> confBackupNames = RegexUtils.fromStringToArrayWithPattern(pattern, userConnection.getTestAgainstObject().toString());

            if (names.length != confBackupNames.size()) {
                throw new Exception("list of confBackup isn't as expected: " + confBackupNames.toString());
            }
            for (String name : names) {
                if (!confBackupNames.contains(name)) {
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
        CliOperations.checkSubMenu(radwareCliConnection, Menu.system().backup().config().build(), SYSTEM_CONF_BACKUP_SUB_MENU);
    }

    /**
     * system confBackup list
     * verify the output by the wanted names
     */
    public static void confBackupList(RadwareServerCli serverCli, String[] namesToFind) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("ConfBackup List");
            String regex = "\\s+\\d+\\s+\\d+/\\d+/\\d+\\s+\\d+:\\d+\\s+\\d+.\\d+.\\d+.\\d+\\s+\\S+";
            CliOperations.runCommand(serverCli, Menu.system().backup().config().list().build());
            for (String name : namesToFind) {
                serverCli.analyze(new FindRegex(name + regex));
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void verifyLinuxOSParamsViaRootText(String command, String[] wantedOutput, RootServerCli userCli) throws Exception {

        InvokeUtils.invokeCommand(null, command, userCli);
        for (String string : wantedOutput) {
            userCli.analyze(new FindText(string));
        }
    }

    public static void verifyLinuxOSParamsViaRootText(String command, String wantedOutput, RootServerCli userCli) throws Exception {
        InvokeUtils.invokeCommand(null, command, userCli);
        userCli.analyze(new FindText(wantedOutput));
    }

    public static void repairTheRestore(RadwareServerCli serverCli, String ipDefault) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Repair The Restore");
            ipDelete("G2", serverCli);
            ipDelete("G3", serverCli);
            setRouteDefault(ipDefault, serverCli);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void ipDelete(String iFace, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Ip Delete " + iFace);
        InvokeUtils.invokeCommand(null, Menu.net().ip().delete().build() + " " + iFace, serverCli);
        InvokeUtils.invokeCommand(null, "y", serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    public static void setRouteDefault(String ip, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Set Route Default : " + ip);
        assert !ip.equals("");
        InvokeUtils.invokeCommand(null, Menu.net().route().setDefault().build() + " " + ip, serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    public static void getLsString(String stringForUsingInLs, String stringForFinding, ServerCliBase fileServer) throws Exception {
        try {
            fileServer.connect();
            InvokeUtils.invokeCommand(null, "ls " + stringForUsingInLs, fileServer);
            fileServer.analyze(new FindText(stringForFinding));
        } finally {
            fileServer.disconnect();
        }

    }

}
