package com.radware.vision.root;

import com.aqua.sysobj.conn.CliCommand;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.utils.RegexUtils;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;

import java.util.List;

public class RootVerifications {

    /**
     * Connect with root
     * Invoke "command"
     * Use analyze with Text to find output
     * @throws Exception
     */
    public static void verifyLinuxOSParamsViaRootText(String command, String wantedOutput, RootServerCli rootServerCli) throws Exception{
        InvokeUtils.invokeCommand(null, command, rootServerCli);
        rootServerCli.analyze(new FindText(wantedOutput));
    }
    public static void verifyLinuxOSParamsViaRootText(String command, RootServerCli rootServerCli) throws Exception{


        InvokeUtils.invokeCommand(null, command, rootServerCli);
    }



    public static void verifyLinuxOSParamsViaRootText(String command, String [] wantedOutput, RootServerCli rootServerCli) throws Exception{

        InvokeUtils.invokeCommand(null, command, rootServerCli);
        for (String string : wantedOutput) {
            rootServerCli.analyze(new FindText(string));
        }
    }



    /**
     * Connect with root
     * Invoke "command"
     * Use analyze with Regex to find output
     * @throws Exception
     */
    public static void verifyLinuxOSParamsViaRootRegex(String command, String wantedOutputReg, RootServerCli rootServerCli) throws Exception{
        InvokeUtils.invokeCommand(null, command, rootServerCli);
        rootServerCli.analyze(new FindRegex(wantedOutputReg));
    }

    /**
     *	The function verifies that the command via root user isn't returned the unwanted output
     * */
    public static void verifyLinuxOSParamsNotExistViaRootRegex(String command, String unWantedOutputReg, RootServerCli rootServerCli) throws Exception{


        InvokeUtils.invokeCommand(null, command, rootServerCli);

        if(RegexUtils.isStringContainsThePattern(unWantedOutputReg, rootServerCli.getTestAgainstObject().toString())){
            BaseTestUtils.reporter.report("The pattern : "+unWantedOutputReg+" was found", Reporter.FAIL);
        }
        else {
            BaseTestUtils.reporter.report("The pattern : "+unWantedOutputReg+" was not found");
        }
    }


    /**
     * Try to move to dirStr via root user
     * Fail if text 'No such file or directory' found
     * Check output values
     * @param rootServerCli
     * @throws Exception
     */
    public static void verifyDirectoryExists(String dirStr, RootServerCli rootServerCli) throws Exception{

        try{
            BaseTestUtils.reporter.startLevel("Verify directory exists");
            InvokeUtils.invokeCommand(null, "cd " + dirStr, rootServerCli, CliCommand.getDefaultTimeout(), false, false, true, "No such file or directory");
            InvokeUtils.invokeCommand(null, "cd ~", rootServerCli, CliCommand.getDefaultTimeout(), false, false, true, "No such file or directory");//IzikP: setting prompt back to home dir
        }
        finally{
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Try to move to dirStr via root user
     * Pass if text 'No such file or directory' found
     * Check output values
     * @param rootServerCli
     * @throws Exception
     */
    public static void verifyDirectoryNotExists(String dirStr, RootServerCli rootServerCli) throws Exception{

        InvokeUtils.invokeCommand(null, dirStr, rootServerCli);
        rootServerCli.analyze(new FindText("No such file or directory"));

    }

    public static boolean isIptableContainsKey(String key, int expectedEntries, RootServerCli rootServerCli) throws Exception {
        InvokeUtils.invokeCommand("iptables --list | grep " + key + " | grep -v trap", rootServerCli);
        String pattern = "ACCEPT.*(snmp).*";
        List<String> iptableEntries = com.radware.vision.test_utils.RegexUtils.fromStringToArrayWithPattern(pattern, rootServerCli.getTestAgainstObject().toString());
        if(iptableEntries != null && iptableEntries.size() == expectedEntries) {
            return true;
        }
        return false;
    }



}
