package com.radware.vision.bddtests;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.base.VisionCliTestBase;
import com.radware.vision.enums.YesNo;
import com.radware.vision.test_parameters.ImportExport;
import com.radware.vision.utils.SutUtils;

import java.io.IOException;
import java.util.*;

import static com.radware.automation.tools.basetest.BaseTestUtils.reporter;

public class CliNegative extends VisionCliTestBase {
    protected Properties prop = new Properties();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();


    public void init() throws Exception {
        prop.load(getClass().getClassLoader().getResourceAsStream("badInput.properties"));
    }

    public void after() throws Exception {
        super.afterMethod();
    }

    /**
     * The function returns true if the value found in the correct error list, else its returns false
     */
    public boolean checkForErrorInTheReturnData(GoodErrorsList goodErrorsList) throws IOException {

        List<String> correctErrors = getListByType(goodErrorsList);
        for (String correctError : correctErrors) {
            if (radwareServerCli.getTestAgainstObject().toString().contains(correctError)) {
                return true;
            }
        }
        return false;
    }

    /**
     * this function checks that the names are not existing in the radware output command
     */
    public void namesNotToFindInListRadware(String command, ArrayList<InvalidInputDataType> invailedDataList) throws Exception {

        List<String> listOfInputs = getTheBadInputList(invailedDataList);
        List<String> existingList = new ArrayList<String>();
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        for (String badInput : listOfInputs) {
            if (badInput.isEmpty())
                continue;
            if (badInput.equals(" "))
                continue;
            CliOperations.runCommand(radwareServerCli, command);
            if (radwareServerCli.getTestAgainstObject().toString().contains(badInput)) {
                existingList.add(badInput + " is exist!!!");
            }
        }
        if (!existingList.isEmpty()) {
            reporter.startLevel("Errors : find some of the strings");
            for (String string : existingList) {
                reporter.report(string);
            }
            reporter.stopLevel();
            BaseTestUtils.report("There were : " + existingList.size() + "bad items", Reporter.FAIL);
        }
    }

    /**
     * general export negative test
     */
    protected void exportNegativeTest(String command, String name, String destination) throws Exception {
        LinuxFileServer linuxFileServer = serversManagement.getLinuxFileServer().get();
        String password;
        password = linuxFileServer.getPassword();
        exportNegativeTest(command, name, destination, password);
    }

    protected void exportNegativeTest(String command, String name, String destination, String password/*, GoodErrorsList goodErrorsList*/) throws Exception {
        try {
            RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
            BaseTestUtils.reporter.startLevel("Begining the export");
            CliOperations.runCommand(radwareServerCli, command + " export " + name + " " + destination,
                    2 * 60 *1000, true);
            if (radwareServerCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                CliOperations.runCommand(radwareServerCli, "yes", 2 * 60 * 1000, true);
            }
            if (radwareServerCli.getTestAgainstObject().toString().toLowerCase().contains("password:")) {
                CliOperations.runCommand(radwareServerCli,password, 2 * 60 * 1000, true);
            }
            if (!checkForErrorInTheReturnData(GoodErrorsList.EXPORT_NEGATIVE_LIST)) {
                doTheVisionLabRestart = true;
                BaseTestUtils.report("Error, couldn't find the correct error message", Reporter.FAIL);
            }
        } catch (Exception e) {
            doTheVisionLabRestart = true;
            BaseTestUtils.report("Timeout/Unexpected error !!!", Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * general import negative test
     */
    protected void importNegativeTest(String command, ImportExport.ImportExportType type, String backupName) throws Exception {
        LinuxFileServer linuxFileServer = serversManagement.getLinuxFileServer().get();
        String location = type+"://root@"+ linuxFileServer.getHost() +":"+ImportExport.getPath(type)+ backupName + ".tar";
        String password;
        password = linuxFileServer.getPassword();
        importNegativeTest(command, password, location);
    }

    protected void importNegativeTest(String command, String password, String location) throws Exception {
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        try {
            BaseTestUtils.reporter.startLevel("Beginning the import");
            CliOperations.runCommand(radwareServerCli, command + " import " + location,
                    3 * 60 * 1000, true);
            if (radwareServerCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                CliOperations.runCommand(radwareServerCli, "ÿes", 3 * 60 * 1000, true);
            }
            if (radwareServerCli.getTestAgainstObject().toString().toLowerCase().contains("password")) {
                CliOperations.runCommand(radwareServerCli, password, 3 * 60 * 1000, true);
            }
            if (!checkForErrorInTheReturnData(GoodErrorsList.IMPORT_NEGATIVE_LIST)) {
                BaseTestUtils.report("Error, couldn't find the correct error message", Reporter.FAIL);
            }
        } finally {
            reporter.stopLevel();
        }
    }

    /**
     * The Scenario :
     * 1.	Get the bad input list from the invailedDataList.
     * 2.	For each invailedDataList.
     * 2.1.	Invoke command via radware.
     * 2.2.	Check if the returned data is in the include error list.
     * 2.3.	Optional - enter y/n.
     * 2.4.	Optional - check the commandRoot.
     * 2.5.	If there is any error -put it in the error list.
     * 3.	Report Error and print the list if needed.
     */
    public void run(String commandRadware, ArrayList<InvalidInputDataType> invailedDataList, GoodErrorsList goodErrorsList) throws Exception {
        run(commandRadware, invailedDataList, YesNo.YES, null, "", goodErrorsList, null);
    }

    public void run(String commandRadware, ArrayList<InvalidInputDataType> invailedDataList, String seconedCommand, GoodErrorsList goodErrorsList) throws Exception {
        run(commandRadware, invailedDataList, YesNo.YES, null, seconedCommand, goodErrorsList, null);
    }

    public void run(String commandRadware, ArrayList<InvalidInputDataType> invailedDataList, YesNo yesNo, GoodErrorsList goodErrorsList) throws Exception {
        run(commandRadware, invailedDataList, yesNo, null, "", goodErrorsList, null);
    }

    public void run(String command, ArrayList<InvalidInputDataType> invailedDataList, YesNo yesNo, String commandRoot,
                    String seconedPartOfCommand, GoodErrorsList goodErrorsList, String commandRadware) throws Exception {
        reporter.report("Negative test is about to begin");

        Properties prop = new Properties();
        prop.load(getClass().getClassLoader().getResourceAsStream("badInput.properties"));

        // get the list from the invailedDataList
        List<String> listOfInputs = getTheBadInputList(invailedDataList);

        //for all the list check that the list have a good output error message
        List<String> errorsList = new ArrayList<String>();

        for (String badInput : listOfInputs) {

            boolean findString = false;
            CliOperations.runCommand(radwareServerCli,
                    (command + badInput + seconedPartOfCommand).replace("  ", " "),
                    CliOperations.DEFAULT_TIME_OUT, true);

            if (radwareServerCli.getTestAgainstObject().toString().contains("y/n")) {
                CliOperations.runCommand(radwareServerCli, yesNo.getText(), 5 * 60 * 1000);
            }
            List<String> validOutputErrorsList = Arrays.asList(prop.getProperty(goodErrorsList.goodErrorsList).split(";"));
            for (String validOutputError : validOutputErrorsList) {

                if (radwareServerCli.getTestAgainstObject().toString().contains(validOutputError)) {
                    findString = true;
                    break;
                }
            }

            if (!findString) {
                errorsList.add(command + "\n" + radwareServerCli.getTestAgainstObject().toString());
            }
        }

        if (!errorsList.isEmpty()) {
            BaseTestUtils.reporter.startLevel("There are some wrong errors for the negative tests: ");
            for (String string : errorsList) {
                BaseTestUtils.reporter.report(string);
            }
            BaseTestUtils.report("There are: " + errorsList.size() + " Errors", Reporter.FAIL);
        }
        reporter.report("Negative test successful");
        BaseTestUtils.reporter.stopLevel();

    }

    /**
     * This function returns the list of the combination of the lists from the InvailedInputDataType
     */
    protected List<String> getTheBadInputList(ArrayList<InvalidInputDataType> invailedDataList) throws IOException {

        //this list will be fill with invailed and vailed lists
        List<List<String>> listOfValidLists = new ArrayList<List<String>>();
        List<List<String>> listOfInvalidLists = new ArrayList<>();

        //getting the correct name of the list
        for (InvalidInputDataType invailedDataEnum : invailedDataList) {
            listOfInvalidLists.add(Arrays.asList(prop.getProperty(invailedDataEnum.invalidListName).split(";")));
        }

        List<String> returnList = getAllTheListsCombinations(listOfInvalidLists);
        for (String string : returnList) {
            string.replace("  ", " ");
        }
        return returnList;
    }

    /**
     * This function returns all the lists combinations
     */
    private List<String> getAllTheListsCombinations(List<List<String>> listOfInvalidLists) {
        List<String> combined = new ArrayList<String>();
        if (listOfInvalidLists.size() == 1) {
            for (int i = 0; i < listOfInvalidLists.get(0).size(); i++) {
                listOfInvalidLists.get(0).set(i, " " + listOfInvalidLists.get(0).get(i));
            }
            return listOfInvalidLists.get(0);
        } else {
            List<String> remained = listOfInvalidLists.remove(0);
            List<String> restCombinations = getAllTheListsCombinations(listOfInvalidLists);

            for (int i = 0; i < remained.size(); i++) {
                for (int j = 0; j < restCombinations.size(); j++) {
                    combined.add(remained.get(i) + " " + restCombinations.get(j));
                }
            }
        }
        //adding space to the combined
        for (int i = 0; i < combined.size(); i++) {
            combined.set(i, " " + combined.get(i));
        }
        return combined;
    }

    /**
     * the function returns the wanted list from the properties file
     */
    public List<String> getListByType(InvalidInputDataType invailedDataEnum) throws IOException {
        List<String> returnList = Arrays.asList(prop.getProperty(invailedDataEnum.invalidListName).split(";"));
        return returnList;
    }

    /**
     * the function returns the wanted list from the properties file
     */
    public List<String> getListByType(GoodErrorsList goodErrorsList) throws IOException {
        List<String> returnList = Arrays.asList(prop.getProperty(goodErrorsList.goodErrorsList).split(";"));
        return returnList;
    }

    // invailed input type enum
    public enum InvalidInputDataType {
        IP_NET_ROUTH("invalidIpNetRouthList"),
        NET_INVALID("invailedNetList"),
        IP_NET_DNS("invalidIpNetDNsList"),
        IP_NET_DNS_DELETE("invalidIpNetDNsDeleteList"),
        NETMASK("invaidMaskList"),
        INTERFACE("invalidInterfaceList"),
        BAD_STRING("oneInvalid"),
        TWO_INVALID("twoInvalid"),
        NET("invalidNetList"),
        PING("invalidPingList"),
        NAME_EXPORT("invalidExportNamesList"),
        NAME("invalidCreationNamesList"),
        NAME_WITHOUT_TOO_LONG("invalidCreationNamesNoTooLongList"),
        NAME_WITHOUT_EMPTY("invalidCreationNamesNoEmptyList"),
        GOOD_NAME("oneGoodName"),
        GOOD_IP("oneGoodIp"),
        HOST_NAME("invalidHostNamesList"),
        HOST_NAME_SET_NEGATIVE("invalidHostNamesSetList"),
        FIREWALL_OPENPORT_SET_NEGATIVE("invalidFirewallOpenPortSet"),
        HELP_UPGRADE("helpUpgradeInput");

        private String invalidListName;

        private InvalidInputDataType(String s) {
            invalidListName = s;
        }


        public String getInvalidListName() {
            return invalidListName;
        }

    }

    public enum GoodErrorsList {
        NET_ROUTH_NEGATIVE_LIST("validOutputErrorsListNetRouth"),
        NET_DNS_NEGATIVE_LIST("validOutputErrorsListNetDns"),
        NET_IP_NEGATIVE_LIST("validOutputErrorsListNetIP"),
        NET_NAT_NEGATIVE_LIST("validOutputErrorsListNetNat"),
        EXPORT_NEGATIVE_LIST("validOutputErrorsListExport"),
        IMPORT_NEGATIVE_LIST("validOutputErrorsListImport"),
        DATABASE_NEGATIVE_LIST("validOutputErrorsListDatabase"),
        DATE_NEGATIVE_LIST("validOutputErrorsListDate"),
        DPM_NEGATIVE_LIST("validOutputErrorsListDpm"),
        DPM_BACKUP_NEGATIVE_LIST("validOutputErrorsListDpmBackup"),
        DPM_TECHSUPPORT_NEGATIVE_LIST("validOutputErrorsListDpmTechSupport"),
        NTP_NEGATIVE_LIST("validOutputErrorsListNtp"),
        TECH_SUPPORT_NEGATIVE_LIST("validOutputErrorsListTechSupport"),
        TIME_ZONE_NEGATIVE_LIST("validOutputErrorsListTimeZone"),
        STORAGE_NEGATIVE_LIST("validOutputErrorsListStorage"),
        USER_NEGATIVE_LIST("validOutputErrorsUser"),
        VERSION_NEGATIVE_LIST("validOutputErrorsVersion"),
        VISION_SERVER_NEGATIVE_LIST("validOutputErrorsVisionServer"),
        PING_NEGATIVE_LIST("validOutputErrorsPing"),
        SSL_NEGATIVE_LIST("validOutputErrorsSsl"),
        BACKUP_NEGATIVE_LIST("validOutputErrorsListBackup"),
        HOSTNAME_SET_NEGATIVE("validErrorsListHostnameSet"),
        NET_FIREWALL_LIST("validErrorsNetFirewall"),
        UPGRADE_HELP_NEGATIVE("validUpgradeHelp"),
        UPGRADE_FULL_NEGATIVE("validUpgradeFull");

        private String goodErrorsList;

        private GoodErrorsList(String s) {
            goodErrorsList = s;
        }

        public String getGoodErrorsList() {
            return goodErrorsList;
        }

    }
}
