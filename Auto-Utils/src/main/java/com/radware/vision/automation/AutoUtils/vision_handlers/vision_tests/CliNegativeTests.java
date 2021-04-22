package com.radware.vision.automation.AutoUtils.vision_handlers.vision_tests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
//import com.radware.vision.enums.YesNo;
import org.junit.After;
import org.junit.Before;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * @author org
 */
public class CliNegativeTests extends CliTests {


    protected Properties prop = new Properties();


    @Before
    public void init() throws Exception {
        prop.load(getClass().getClassLoader().getResourceAsStream("badInput.properties"));
        super.init();
    }

    @After
    public void after() throws Exception {
//		if (radwareServerCli.getTestAgainstObject().toString().toLowerCase().contains("password")) {
//			InvokeUtils.invokeCommand(null, "\n", radwareServerCli);
//			InvokeUtils.invokeCommand(null, "\n", radwareServerCli);
//		}
        super.AfterMethodMain();
//		visionLab.close();

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
        for (String badInput : listOfInputs) {
            if (badInput.isEmpty())
                continue;
            if (badInput.equals(" "))
                continue;
            InvokeUtils.invokeCommand(null, command, radwareServerCli);
            if (radwareServerCli.getTestAgainstObject().toString().contains(badInput)) {
                existingList.add(badInput + " is exist!!!");
            }
        }
        if (!existingList.isEmpty()) {
            report.startLevel("Errors : find some of the strings");
            for (String string : existingList) {
                BaseTestUtils.reporter.report(string);
            }
            report.stopLevel();
            BaseTestUtils.report("There were : " + existingList.size() + "bad items", Reporter.FAIL);
        }
    }

    /**
     * general export negative test
     */
    protected void exportNegativeTest(String command, String name, String destenation) throws Exception {
        exportNegativeTest(command, name, destenation, linuxFileServer.getPassword());
    }

    protected void exportNegativeTest(String command, String name, String destenation, String password/*, GoodErrorsList goodErrorsList*/) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Begining the export");
            InvokeUtils.invokeCommand(null, command + " export " + name + " " + destenation, radwareServerCli, 2 * 60 * 1000, true);
            if (radwareServerCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                InvokeUtils.invokeCommand(null, "yes", radwareServerCli, 2 * 60 * 1000, true);
            }
            if (radwareServerCli.getTestAgainstObject().toString().toLowerCase().contains("password:")) {
                InvokeUtils.invokeCommand(null, password, radwareServerCli, 2 * 60 * 1000, true);
            }
            if (!checkForErrorInTheReturnData(GoodErrorsList.EXPORT_NEGATIVE_LIST)) {
                doTheVisionLabRestart = true;
                BaseTestUtils.report("Error, couldn't find the correct error message", Reporter.FAIL);
            }
        } catch (Exception e) {
            doTheVisionLabRestart = true;
            BaseTestUtils.report("Timeout/Unexpected error !!!", Reporter.FAIL);
        } finally {
            report.stopLevel();
        }
    }

    /**
     * general import negative test
     */
    protected void importNegativeTest(String command, String location) throws Exception {
        importNegativeTest(command, linuxFileServer.getPassword(), location);
    }

    protected void importNegativeTest(String command, String password, String location/*, GoodErrorsList goodErrorsList*/) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Begining the import");

            InvokeUtils.invokeCommand(null, command + " import " + location, radwareServerCli, 3 * 60 * 1000, true);
            if (radwareServerCli.getTestAgainstObject().toString().contains("(yes/no)?")) {
                InvokeUtils.invokeCommand(null, "yes", radwareServerCli, 3 * 60 * 1000, true);
            }
            if ((radwareServerCli.getTestAgainstObject().toString().toLowerCase().contains("password"))) {
                InvokeUtils.invokeCommand(null, password, radwareServerCli, 3 * 60 * 1000, true);
            }
            if (!checkForErrorInTheReturnData(GoodErrorsList.IMPORT_NEGATIVE_LIST)) {
                BaseTestUtils.report("Error, couldn't find the correct error message", Reporter.FAIL);
            }
        } finally {
            report.stopLevel();
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
        run(commandRadware, invailedDataList, YesNo.YES, null, false, "", goodErrorsList, null, false);
    }

    public void run(String commandRadware, ArrayList<InvalidInputDataType> invailedDataList, String seconedCommandRadwae, GoodErrorsList goodErrorsList) throws Exception {
        run(commandRadware, invailedDataList, YesNo.YES, null, false, seconedCommandRadwae, goodErrorsList, null, false);
    }

    public void run(String commandRadware, ArrayList<InvalidInputDataType> invailedDataList, YesNo yesNo, GoodErrorsList goodErrorsList) throws Exception {
        run(commandRadware, invailedDataList, yesNo, null, false, "", goodErrorsList, null, false);
    }

    public void run(String command, ArrayList<InvalidInputDataType> invailedDataList, YesNo yesNo, String commandRoot,
                    boolean isPossitiveRootCheck, String seconedPartOfCommand, GoodErrorsList goodErrorsList, String commandRadware,
                    boolean isPossitiveRadwareCheck) throws Exception {

        BaseTestUtils.reporter.report("About to begin the run for negative tests cli.");

        Properties prop = new Properties();
        prop.load(getClass().getClassLoader().getResourceAsStream("badInput.properties"));

        // get the list from the invailedDataList
        List<String> listOfInputs = getTheBadInputList(invailedDataList);

        //for all the list check that the list have a good output error message
        List<String> errorsList = new ArrayList<String>();

        for (String badInput : listOfInputs) {

            boolean findString = false;

            InvokeUtils.invokeCommand(null, (command + badInput + seconedPartOfCommand).replace("  ", " "), radwareServerCli, InvokeUtils.getAvarageTimeout(), true);

            if (radwareServerCli.getTestAgainstObject().toString().contains("y/n")) {
                InvokeUtils.invokeCommand(null, yesNo.getText(), radwareServerCli, 5 * 60 * 1000);
            }
            List<String> validOutputErrorsList = Arrays.asList(prop.getProperty(goodErrorsList.goodErrorsList).split(";"));
            for (String validOutputError : validOutputErrorsList) {

                if (radwareServerCli.getTestAgainstObject().toString().contains(validOutputError)) {
                    findString = true;
                    break;
                }
            }

            //this if is for the root or radware seconed command
//			if(findString) {
//				if(!badInput.isEmpty()) {
//				if(commandRoot!= null) {
//					//in this case there is a need to check the root
//					InvokeUtils.invokeCommand(null, commandRoot, rootServerCli);
//					//possitive -find
//					if (radwareServerCli.getTestAgainstObject().toString().contains(badInput.split(" ")[1])) {
//						if(!isPossitiveRootCheck) {
//							findString = false;
//						}
//					}
//					else {
//						if(isPossitiveRootCheck) {
//							findString = false;
//						}
//					}
//				}
//				if(commandRadware!= null) {
//					//in this case there is a need to check the root
//					InvokeUtils.invokeCommand(null, commandRadware, radwareServerCli);
//					//possitive -find
//					if (radwareServerCli.getTestAgainstObject().toString().contains(badInput.split(" ")[1])) {
//						if(!isPossitiveRadwareCheck) {
//							findString = false;
//						}
//					}
//					else {
//						if(isPossitiveRadwareCheck) {
//							findString = false;
//						}
//					}
//				}
//				}
//			}
//
            if (findString != true) {
                errorsList.add( /*commandRadware + " " + badInput +"\n###################################\n"*/command + "\n" + radwareServerCli.getTestAgainstObject().toString());
            }
        }

        if (!errorsList.isEmpty()) {
            report.startLevel("The wrong errors list for the negative tests");
            for (String string : errorsList) {
                BaseTestUtils.reporter.report(string);
            }
            BaseTestUtils.report("There Is " + errorsList.size() + " Errors", Reporter.FAIL);
            report.stopLevel();
        }
        report.stopLevel();

    }

    /**
     * This function returns the list of the combination of the lists from the InvailedInputDataType
     */
    protected List<String> getTheBadInputList(ArrayList<InvalidInputDataType> invailedDataList) throws IOException {

        //this list will be fill with invailed and vailed lists
        List<List<String>> listOfValidLists = new ArrayList<List<String>>();
        List<List<String>> listOfInvalidLists = new ArrayList<List<String>>();

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
