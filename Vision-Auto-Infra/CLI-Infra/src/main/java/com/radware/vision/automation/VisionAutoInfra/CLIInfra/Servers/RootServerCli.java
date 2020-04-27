package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import ch.ethz.ssh2.log.Logger;
//import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.IPUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.utils.RegexUtils;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliTests;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.report.Summary;
import systemobject.terminal.Prompt;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RootServerCli extends ServerCliBase {
    private String versionNumebr = "";
    private String buildNumber = "";
    private String earFileName;

    public RootServerCli() {
        this.earFileName = "server-ear-" + CliTests.visionVersion + ".ear";
    }

    public RootServerCli(String host, String user, String password) {
        super(host, user, password);
        this.earFileName = "server-ear-" + CliTests.visionVersion + ".ear";
    }

    public void init() throws Exception {
//        BaseTestUtils.reporter.startLevel("Init RootServerCli");
        super.init();
        if (!CliTests.isFirstTimeScenario && this.isConnectOnInit()) {
            this.getVersionAndBuildFromSever();
//            BaseTestUtils.showRuntimeProperties();
        }

//        BaseTestUtils.reporter.stopLevel();
    }

    public void close() {
        super.close();
    }

    public boolean checkDeploymentComplete(String expectedFile, long timeout) throws InterruptedException {
        long startTime = System.currentTimeMillis();
        String origUsername = this.getUser();
        String origPassword = this.getPassword();

        try {
            this.setUser("root");
            this.setPassword("radware");
            this.setConnectRetries(1);

            while(startTime + timeout > System.currentTimeMillis()) {
                try {
                    this.connect();
                    InvokeUtils.invokeCommand((Logger)null, "ls  " + expectedFile, this, 2000L, true, true, true);
                    String consoleResult = this.getTestAgainstObject() == null ? "" : this.getTestAgainstObject().toString();
                    if (consoleResult.contains(expectedFile) && !consoleResult.contains("cannot")) {
                        boolean var9 = true;
                        return var9;
                    }

                    Thread.sleep(10000L);
                } catch (Exception var13) {
                    Thread.sleep(10000L);
                }
            }

            return false;
        } finally {
            this.setUser(origUsername);
            this.setPassword(origPassword);
        }
    }

    public boolean isServerConnected() {
        try {
            this.connect();
            return true;
        } catch (Exception var2) {
            return false;
        }
    }

    public void getVersionAndBuildFromSever() throws Exception {
        StringBuilder version = new StringBuilder();
        String build = "";
        String var3 = "/tmp/sysVerAuto/";

        try {
            if (this.buildNumber.isEmpty() || this.versionNumebr.isEmpty()) {
                try {
                    InvokeUtils.invokeCommand((Logger)null, "cat /opt/radware/mgt-server/build.properties", this);
                    version.append(this.getStringCounter("buildMajorVersion"));
                    version.append(".").append(this.getStringCounter("buildMinorVersion"));
                    version.append(".").append(this.getStringCounter("buildRevisionVersion"));
                    build = build + this.getStringCounter("buildId");
                    InvokeUtils.invokeCommand((Logger)null, "cd ~", this);
                } finally {
                    if (!version.toString().isEmpty()) {
                        this.versionNumebr = version.toString();
                    }

                    if (!build.toString().isEmpty()) {
                        this.buildNumber = build.toString();
                    }

                }

                if (!this.buildNumber.isEmpty()) {
                    Summary.getInstance().setProperty("Build number", this.buildNumber);
//                    BaseTestUtils.reporter.addProperty("Build", this.buildNumber);
                }

                if (!this.versionNumebr.isEmpty()) {
                    Summary.getInstance().setProperty("Version number", this.versionNumebr);
//                    BaseTestUtils.reporter.addProperty("Version", this.versionNumebr);
                }
            }
        } catch (Exception var8) {
//            BaseTestUtils.reporter.report("Failed to set Version and Build number from server", var8);
        }

    }

    public String getOutputStr() throws Exception {
        String s = (String) RegexUtils.getGroupsWithPattern("\\n(.*)", this.getTestAgainstObject().toString()).get(0);
        return s;
    }

    public void switchToRadware() throws Exception {
        InvokeUtils.invokeCommand((Logger)null, "su radware", this);
        InvokeUtils.invokeCommand((Logger)null, this.getPassword(), this);
        if (!this.getTestAgainstObject().toString().endsWith("$ ")) {
            throw new Exception("Failed switch to radware user");
        }
    }

    public void exitRadware() throws Exception {
        InvokeUtils.invokeCommand((Logger)null, "", this);
        if (!this.getTestAgainstObject().toString().endsWith("# ") && this.getTestAgainstObject().toString().endsWith("$ ")) {
            InvokeUtils.invokeCommand((Logger)null, Menu.exit().build(), this);
        }

    }

    public long getCurrentEpochTime() {
        try {
            InvokeUtils.invokeCommand((Logger)null, "date +%s", this);
            String epochTime = this.getTestAgainstObject().toString();
            List<String> output = Arrays.asList(epochTime.split("\r\n"));
            return output.size() >= 2 ? Long.valueOf((String)output.get(1)) : 0L;
        } catch (Exception var3) {
            return 0L;
        }
    }

    public String getStringCounter(String key) throws Exception {
        GetTextCounter counter = new GetTextCounter(key);
        this.analyze(counter);
        return counter.getCounter();
    }

    public void addDBPermissionsToConnectoToMySql() throws Exception {
        this.addDBPermissionsToConnectoToMySql((String)null);
    }

    public void addDBPermissionsToConnectoToMySql(String sourceHost) throws Exception {
        String host = sourceHost == null ? IPUtils.getIpV4LocalAddress() : sourceHost;
        InvokeUtils.invokeCommand((Logger)null, "mysql -uroot -prad123 -e \"grant all on *.* to 'root'@'" + host + "' identified by 'rad123'\"", this);
    }

    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList();
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
        p.setStringToSend(this.getUser());
        prompts.add(p);
        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setStringToSend(this.getPassword());
        prompts.add(p);
        p = new Prompt();
        p.setPrompt("'s password: ");
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
        p = new Prompt();
        p.setPrompt("Password: ");
        p.setCommandEnd(true);
        prompts.add(p);
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
        p = new Prompt();
        p.setPrompt("(Y/y/N/n) ?");
        p.setStringToSend("n");
        p.setCommandEnd(true);
        prompts.add(p);
        p = new Prompt();
        p.setPrompt("(yes/no)?");
        p.setCommandEnd(true);
        prompts.add(p);
        return (Prompt[])prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getVersionNumebr() {
        return this.versionNumebr;
    }

    public void setVersionNumebr(String versionNumebr) {
        this.versionNumebr = versionNumebr;
    }

    public String getBuildNumber() {
        return this.buildNumber;
    }

    public void setBuildNumber(String buildNumber) {
        this.buildNumber = buildNumber;
    }
}
