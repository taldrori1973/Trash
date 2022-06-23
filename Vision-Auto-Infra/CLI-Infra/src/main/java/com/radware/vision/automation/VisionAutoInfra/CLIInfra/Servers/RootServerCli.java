package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.IPUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.report.Summary;
import systemobject.terminal.Prompt;
import utils.RegexUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RootServerCli extends ServerCliBase {

    private String versionNumebr = "";
    private String buildNumber = "";
    private String remoteHost = "";
    private String pairIP = "";
    private String setUpImport = "";
    private String continueImport = "";

//    private String earFileName = "server-ear-" + CliTests.visionVersion + ".ear";

    public RootServerCli() {
    }

    public RootServerCli(String host, String user, String password) {
        super(host, user, password);
    }

    @Override
    public void init() throws Exception {
//        BaseTestUtils.reporter.startLevel("Init RootServerCli");
        super.init();
//        if (!CliTests.isFirstTimeScenario && isConnectOnInit()) {
//            getVersionAndBuildFromSever();
//            BaseTestUtils.showRuntimeProperties();
//        }
//        BaseTestUtils.reporter.stopLevel();
    }

    public void close() {
        super.close();
    }

    public boolean checkDeploymentComplete(String expectedFile, long timeout) throws InterruptedException {
        long startTime = System.currentTimeMillis();
        String origUsername = getUser();
        String origPassword = getPassword();
        try {
            setUser("root");
            setPassword("radware");
            setConnectRetries(1);
            while (((startTime + timeout) > System.currentTimeMillis())) {
                try {
                    this.connect();
                    CliOperations.runCommand(this, "ls  " + expectedFile, 2 * 1000, true, true, true);
                    String consoleResult = getTestAgainstObject() == null ? "" : getTestAgainstObject().toString();
                    if (consoleResult.contains(expectedFile) && !consoleResult.contains("cannot")) {
                        return true;
                    } else
                        Thread.sleep(10 * 1000);
                } catch (Exception e) {
                    Thread.sleep(10 * 1000);
                }
            }
        } finally {
            setUser(origUsername);
            setPassword(origPassword);
        }
        return false;
    }

    public boolean isServerConnected() {
        try {
            connect();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public void getVersionAndBuildFromSever() throws Exception {

        StringBuilder version = new StringBuilder();
        String build = "";
        String workFolder = "/tmp/sysVerAuto/";

        try {

            if (buildNumber.isEmpty() || versionNumebr.isEmpty()) {
                try {
                    CliOperations.runCommand(this, "cat /opt/radware/mgt-server/build.properties"); // Give write permissions to the file
                    version.append(this.getStringCounter("buildMajorVersion"));
                    version.append(".").append(this.getStringCounter("buildMinorVersion"));
                    version.append(".").append(this.getStringCounter("buildRevisionVersion"));
                    build += this.getStringCounter("buildId");
                    CliOperations.runCommand(this, "cd ~");
                } finally {
                    if (version.toString().isEmpty() == false) {
                        versionNumebr = version.toString();
                    }
                    if (build.toString().isEmpty() == false) {
                        buildNumber = build.toString();
                    }
                }

                if (buildNumber.isEmpty() == false) {
                    Summary.getInstance().setProperty("Build number", buildNumber);
                    BaseTestUtils.reporter.addProperty("Build", buildNumber);
                }

                if (versionNumebr.isEmpty() == false) {
                    Summary.getInstance().setProperty("Version number", versionNumebr);
                    BaseTestUtils.reporter.addProperty("Version", versionNumebr);
                }


            }
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to set Version and Build number from server", e);
        }

    }

    public String getOutputStr() throws Exception {
        String s = RegexUtils.getGroupsWithPattern("\\n(.*)", getTestAgainstObject().toString()).get(0);
        return s;
    }

    public void switchToRadware() throws Exception {
        CliOperations.runCommand(this, "su radware");
        CliOperations.runCommand(this, getPassword());
        if (!getTestAgainstObject().toString().endsWith("$ ")) {
            throw new Exception("Failed switch to radware user");
        }
    }

    /*
     * Moving back to root user after switching to radware
     */
    public void exitRadware() throws Exception {
        CliOperations.runCommand(this, "");
        if (!getTestAgainstObject().toString().endsWith("# ") && getTestAgainstObject().toString().endsWith("$ ")) {
            CliOperations.runCommand(this, Menu.exit().build());
        }
    }

    public long getCurrentEpochTime() {
        try {
            CliOperations.runCommand(this, "date +%s");
            String epochTime = this.getTestAgainstObject().toString();
            List<String> output = Arrays.asList(epochTime.split("\r\n"));
            if (output.size() >= 2) {
                return Long.valueOf(output.get(1));
            } else {
                return 0;
            }
        } catch (Exception e) {
            return 0;
        }
    }


    public String getStringCounter(String key) throws Exception {

        GetTextCounter counter = new GetTextCounter(key);
        analyze(counter);
        return counter.getCounter();
    }

    /**
     * Initing the data base connection
     */

    public void addDBPermissionsToConnectoToMySql() throws Exception {
        addDBPermissionsToConnectoToMySql(null);
    }

    public void addDBPermissionsToConnectoToMySql(String sourceHost) throws Exception {
        String host = sourceHost == null ? IPUtils.getIpV4LocalAddress() : sourceHost;
        CliOperations.runCommand(this, "mysql -uroot -pradware -e \"grant all on *.* to 'root'@'" + host
                + "' identified by 'rad123'\"");
    }

    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<Prompt>();
        Prompt p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt(":/>");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("$ ");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("login as: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setStringToSend(getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("'s password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("# reboot");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("mysql>");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("ear'?");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(y/n):");
        p.setCommandEnd(true);
        prompts.add(p);

        // For 'su radware'
        p = new Prompt();
        p.setPrompt("Password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        // For 'passwd'
        p = new Prompt();
        p.setPrompt("New password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Retype new password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        // For Server debug mode activation
        p = new Prompt();
        p.setPrompt("(Y/y/N/n) ?");
        p.setStringToSend("n");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(yes/no)?");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to export Elasticsearch data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to export Configuration data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to export data to remote location? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter remote host address (*):");
        p.setStringToSend(getRemoteHost());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter remote NFS share (Default: /var/lib/docker/mnt/nfs_share):");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter relative path for Elasticsearch data (Default: cvision/data-export/elasticsearch):");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter relative path for Configuration data (Default: cvision/data-export/config):");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Setup automated data import from existing vision (Should be done only once)? (yes/no):");
        p.setStringToSend(getSetUpImport());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter IP address of your existing vision:");
        p.setStringToSend(getPairIP());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Continue to data import? (yes/no):");
        p.setStringToSend(getContinueImport());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Import Configuration Data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Import Elasticsearch Data? (yes/no)");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Is your data located on a remote machine? (yes/no):");
        p.setStringToSend("no");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter path to configuration data (Default: /var/lib/docker/mnt/nfs_share/cvision/data-export/config):");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter path to elasticsearch data (Default: /var/lib/docker/mnt/nfs_share/cvision/data-export/elasticsearch):");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Only root users can perform this action. This action will recover the radware user password. Do you wish to continue (y/n)?:");
        p.setStringToSend("y");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter new password for radware user:");
        p.setStringToSend("radware");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Confirm password:");
        p.setStringToSend("radware");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter how long this password should be valid (1-365) days:");
        p.setStringToSend("365");
        prompts.add(p);

        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getVersionNumebr() {
        return versionNumebr;
    }

    public void setVersionNumebr(String versionNumebr) {
        this.versionNumebr = versionNumebr;
    }

    public String getBuildNumber() {
        return buildNumber;
    }

    public void setBuildNumber(String buildNumber) {
        this.buildNumber = buildNumber;
    }

    public String getRemoteHost() {
        return remoteHost;
    }

    public void setRemoteHost(String remoteHost) {
        this.remoteHost = remoteHost;
    }

    public String getPairIP() {
        return pairIP;
    }

    public void setPairIP(String pairIP) {
        this.pairIP = pairIP;
    }

    public String getSetUpImport() {
        return setUpImport;
    }

    public void setSetUpImport(String setUpImport) {
        this.setUpImport = setUpImport;
    }

    public String getContinueImport() {
        return continueImport;
    }

    public void setContinueImport(String continueImport) {
        this.continueImport = continueImport;
    }
}