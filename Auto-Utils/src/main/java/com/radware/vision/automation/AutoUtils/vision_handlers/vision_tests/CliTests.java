package com.radware.vision.automation.AutoUtils.vision_handlers.vision_tests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.basetest.RuntimePropertiesEnum;
import com.radware.automation.tools.centralreporting.entities.ReportResultEntity;
import com.radware.automation.tools.centralreporting.manager.CentralReportingResultsManager;
import com.radware.automation.tools.cli.AlteonServer;
import com.radware.automation.tools.cli.LinuxFileServer;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.tools.reports.AutomationTestReporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.annotation.QC;
import com.radware.vision.automation.AutoUtils.vision_handlers.HaManager;
import com.radware.vision.automation.AutoUtils.vision_handlers.VisionCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;

import com.radware.vision.vision_project_cli.menu.Menu;
import jsystem.framework.TestProperties;
import junit.framework.SystemTestCase4;
import org.junit.After;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

/**
 * @author Hadar Elbaz
 */

public class CliTests extends SystemTestCase4 {

    public final static String backupFileSufix = "_" +BaseTestUtils.getRuntimeProperty(RuntimePropertiesEnum.VISION_VERSION.name(), RuntimePropertiesEnum.VISION_VERSION.getDefaultValue());;
    public static String visionVersion;
    public final static long DEFAULT_TIME_WAIT_FOR_VISION_SERVICES_RESTART = 20 * 60 * 1000;
    public static String sourceFolderPath = "";
    public static boolean isFirstTimeScenario = false;
    public static CentralReportingResultsManager resultsManager = new CentralReportingResultsManager();
    public static RadwareServerCli radwareServerCli = null;
    public static RootServerCli rootServerCli = null;
    public static HaManager haManager;
    // For Results Reporting
    public static AutomationTestReporter automationTestReporter;
    protected static String reportAutomationMode;
    public VisionServerHA visionServerHA;
    //the VisionCli contains all the next servers SO
    public VisionCli visionCli;
    public LinuxFileServer linuxFileServer = null;
    //the alton server is for forward use - for now only the host is being use
    public AlteonServer alteonServer = null;
    //run after is usually used as a boolean if there is after after the test that need to run
    protected boolean runAfter = true;
    //this variable is for doing the after : makes the init of the vision lab happened in the next test that run throw Jsystem
    protected boolean doTheVisionLabRestart = false;
    protected String targetTestId;
    public static String lastOutput;

    public void readSutObjects() throws Exception {

        visionCli = (VisionCli) system.getSystemObject("visionCli");
        alteonServer = visionCli.alteonServer;
        if (radwareServerCli == null)
            radwareServerCli = visionCli.visionServer.visionRadware;
        if (rootServerCli == null)
            rootServerCli = visionCli.visionServer.visionRoot;
        linuxFileServer = visionCli.linuxFileServer;
        visionServerHA = visionCli.visionServer.visionServerHA;

        if (visionServerHA != null) {
            if (haManager == null)
                haManager = new HaManager(radwareServerCli, rootServerCli, visionServerHA);
        }

    }


    //	@Before
    public void init() throws Exception {
        try {

            BaseTestUtils.reporter.startLevel("Beginning to Init the test(Before).");
            readSutObjects();
//            String qcId = getStringFromQCAnnotation();
//            report.addProperty("qcTestId", qcId);
//            BaseTestUtils.reporter.report("Qc Test Id : " + qcId);


            if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
                reportAutomationMode = System.getProperty(RuntimePropertiesEnum.REPORT_AUTOMATION_MODE.name()) != null ?
                        System.getProperty(RuntimePropertiesEnum.REPORT_AUTOMATION_MODE.name()) :
                        RuntimePropertiesEnum.REPORT_AUTOMATION_MODE.getDefaultValue();
                if (automationTestReporter == null) {
                    automationTestReporter = new AutomationTestReporter();
                    automationTestReporter.init(rootServerCli.getVersionNumebr(), rootServerCli.getBuildNumber(), reportAutomationMode);
                }
            }

            visionVersion = BaseTestUtils.getRuntimeProperty(RuntimePropertiesEnum.VISION_VERSION.name(), RuntimePropertiesEnum.VISION_VERSION.getDefaultValue());

//			initTheDataBaseConnection();

        } finally {
            BaseTestUtils.reporter.stopLevel();
            //opening level for the test itself
            BaseTestUtils.reporter.startLevel("Starting  the test : " + getTestNameAnnotation()/*this.getMethodName()*/);
        }
    }

    public void reconnect() {
        radwareServerCli.reconnect();
        rootServerCli.reconnect();
    }


    //TODO check if there is a need to
    public void checkIfClosed() {
        if (!radwareServerCli.isConnected()) {
            visionCli.close();
        }
    }


    /**
     * Initing the data base connection
     */
    public void initTheDataBaseConnection() throws Exception {
        rootServerCli.addDBPermissionsToConnectoToMySql(rootServerCli.getHost());
        radwareServerCli.connect();
        InvokeUtils.invokeCommand(null, Menu.system().database().access().grant().build() + " " + rootServerCli.getHost(), radwareServerCli);
    }


    /**
     * This after function happens only if doTheVisionLabRestart = true
     * notice that some of the tests need to do this for the next test to begin from the beginning
     * visionCli.close();  --> makes the next test that run with Jsystem to init the lab !!!
     */
    @After
    public void AfterMethodMain() throws IOException {
        try {
            // Clear any remaining commands on the output (In case of a 'Help text' command)
            String clearString = "";
            for (int i = 0; i < 60; i++) {
                clearString += "\b";
            }
            InvokeUtils.invokeCommand(null, clearString, radwareServerCli, 2 * 2000, true, true, true, null, true, true);
            InvokeUtils.invokeCommand(null, clearString, rootServerCli, 2 * 2000, true, true, true, null, true, true);
            BaseTestUtils.reporter.stopLevel();
            BaseTestUtils.reporter.startLevel("Begining to Finish the test(After).");
//			if(visionCli.numberOfTests > visionCli.maxNumberOfTests) {
//				doTheVisionLabRestart = true;
//			}

            if (doTheVisionLabRestart) {
                InvokeUtils.invokeCommand(null, "", radwareServerCli, 6000, true);
                if (radwareServerCli.getTestAgainstObject().toString().endsWith("$ ")) {
                    InvokeUtils.invokeCommand(null, Menu.system().database().access().revoke().build() + " all", radwareServerCli);
                    InvokeUtils.invokeCommand(null, "y", radwareServerCli);
                }
//                visionCli.close();
                doTheVisionLabRestart = false;
            }

            if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
                ReportResultEntity report = new ReportResultEntity().withtestID("").withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
                resultsManager.addResult(report);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (radwareServerCli != null) {
                radwareServerCli.cleanCliBuffer();
            }
            if (rootServerCli != null) {
                rootServerCli.cleanCliBuffer();
            }
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public void publishResults(int targetTestCaseID) {
        try {
            StringBuilder results = new StringBuilder();
            for (ReportResultEntity result : resultsManager.getAllResults().values()) {
                results.append(result.toString());
            }
            if (automationTestReporter == null) {
                automationTestReporter = new AutomationTestReporter();
            }
            if(rootServerCli.getVersionNumebr().isEmpty() || rootServerCli.getBuildNumber().isEmpty()) {
                rootServerCli.setConnectOnInit(true);
                rootServerCli.connect();
                rootServerCli.getVersionAndBuildFromSever();
                automationTestReporter.init(rootServerCli.getVersionNumebr(), rootServerCli.getBuildNumber(), reportAutomationMode);
            }
            automationTestReporter.updateTestResult(resultsManager.getUpToDateAggResult(), results.toString(), targetTestCaseID);
            resultsManager.resetAllResults();
        }
        catch(Exception e){
            BaseTestUtils.report("publish has Failed", Reporter.WARNING);
        }
    }


    private static void updateLastOutput(ServerCliBase cliBase) {
        lastOutput = cliBase.getTestAgainstObject() != null ? cliBase.getTestAgainstObject().toString() : "";



    }
    public static void verifyLastOutputByRegex(String regex,ServerCliBase cliBase) {
        StringBuilder result = new StringBuilder();
        updateLastOutput(cliBase);
        boolean isContained = com.radware.vision.utils.RegexUtils.isStringContainsThePattern(regex, lastOutput);
        if (!isContained) {
            result.append("Regex: " + "\"").append(regex).append("\"").append(" not found in the actual output").
                    append("\n").
                    append("Actual output: ").append(Arrays.asList(lastOutput));
        }
        if (!result.toString().equals("")) {
            BaseTestUtils.report(result.toString(), Reporter.FAIL);
        }
        else
            BaseTestUtils.report(regex + " is contained",Reporter.PASS);
    }

    private String getTestNameAnnotation() {
        List<Method> methods = getMethodsAnnotatedWith(this.getClass(), TestProperties.class);
        for (Method method : methods) {
            //in this case the wanted method name found and the QC annotation found too
            if ((method.isAnnotationPresent(TestProperties.class)) && (method.getName().equals(this.getMethodName()))) {
                TestProperties methodAnno = method.getAnnotation(TestProperties.class);
                return methodAnno.name();
            }
        }
        BaseTestUtils.report("No naming annotation with the properties", Reporter.WARNING);
        return this.getMethodName();
    }


    /**
     * this function return the qc number
     */
    private String getStringFromQCAnnotation() throws SecurityException, ClassNotFoundException {
        List<Method> methods = getMethodsAnnotatedWith(this.getClass(), QC.class);
        for (Method method : methods) {
            //in this case the wanted method name found and the QC annotation found too
            if ((method.isAnnotationPresent(QC.class)) && (method.getName().equals(this.getMethodName()))) {
                QC methodAnno = method.getAnnotation(QC.class);
                return methodAnno.id();
            }
        }
        return "0";
    }

    /**
     * return all the annotation in a class
     */
    public List<Method> getMethodsAnnotatedWith(final Class<?> type, final Class<? extends Annotation> annotation) {
        final List<Method> methods = new ArrayList<Method>();
        Class<?> klass = type;
        while (klass != Object.class) { // need to iterated thought hierarchy in order to retrieve methods from above the current instance
            // iterate though the list of methods declared in the class represented by klass variable, and add those annotated with the specified annotation
            final List<Method> allMethods = new ArrayList<Method>(Arrays.asList(klass.getDeclaredMethods()));
            for (final Method method : allMethods) {
                if (annotation == null || method.isAnnotationPresent(annotation)) {
                    //TODO to add the method that check that returns the method by a name
                    methods.add(method);
                }
            }
            // move to the upper class in the hierarchy in search for more methods
            klass = klass.getSuperclass();
        }
        return methods;
    }

    public VisionServerHA getVisionServerHA() throws Exception {

        if (visionServerHA == null)
            throw new Exception("visionServerHA is null");
        else
            return visionServerHA;

    }


    public HaManager getHaManager() throws Exception {

        if (haManager == null)
            throw new Exception("HaManager is null");
        else
            return haManager;

    }

    public String getTargetTestId() {
        return targetTestId;
    }

    public void setTargetTestId(String targetTestId) {
        this.targetTestId = targetTestId;
    }
}
