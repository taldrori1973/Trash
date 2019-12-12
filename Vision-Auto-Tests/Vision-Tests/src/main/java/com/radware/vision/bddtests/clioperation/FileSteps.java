package com.radware.vision.bddtests.clioperation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.LinuxFileServer;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.cli.FilesHandler;
import cucumber.api.java.en.When;
import enums.SUTEntryType;
import org.apache.commons.lang3.exception.ExceptionUtils;


import java.util.StringJoiner;

/**
 * Created by MoaadA on 1/6/2019.
 */
public class FileSteps extends BddCliTestBase {

    /**
     * copies a file using scp method
     *
     * @param srcPath - source file path
     * @param srcMachine - source machine SUT object
     * @param destMachine - destination machine SUT object
     * @param destPath - destination path
     */
    @When("^CLI copy \"(.*)\" from \"(.*)\" to \"(.*)\" \"(.*)\"$")
    public void scp(String srcPath, SUTEntryType srcMachine, SUTEntryType destMachine, String destPath) {
        ServerCliBase srcSession = getSUTEntryTypeByServerCliBase(srcMachine);
        ServerCliBase destSession = getSUTEntryTypeByServerCliBase(destMachine);
        try {
            new FilesHandler().scp(srcPath, srcSession, destSession, destPath);
        } catch (Exception e) {
            StringJoiner errorMessage = new StringJoiner("\n");
            errorMessage.add("Error copying a file using scp method")
                    .add("Source file : " + srcPath)
                    .add("Source machine : " + srcMachine)
                    .add("Destination file : " + destPath)
                    .add("Destination machine : " + destMachine)
                    .add("\n").add("\n");
            BaseTestUtils.report(errorMessage.toString() + ExceptionUtils.getStackTrace(e), Reporter.FAIL);
        }
    }

    @When("^CLI copy file by user \"(root|radware)\" \"(.*)\" from \"(.*)\" to \"(.*)\" \"(.*)\"$")
    public void copyLinuxFile(String optinalUserGenericLinux, String srcPath, String srcMachine, String destMachine, String destPath) throws Exception {
        LinuxFileServer ServerCli;
        if (optinalUserGenericLinux.equals("root")) {
            ServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(srcMachine)).getHost(), "root", "radware");
            ServerCli.init();
        } else {
            ServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(srcMachine)).getHost(), "radware", "radware");
            ServerCli.init();
        }


        try {
            new FilesHandler().scp(srcPath, ServerCli, getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(destMachine)), destPath);
        } catch (Exception e) {
            StringJoiner errorMessage = new StringJoiner("\n");
            errorMessage.add("Error copying a file using scp method")
                    .add("Source file : " + srcPath)
                    .add("Source machine : " + srcMachine)
                    .add("Destination file : " + destPath)
                    .add("Destination machine : " + destMachine)
                    .add("\n").add("\n");
            BaseTestUtils.report(errorMessage.toString() + ExceptionUtils.getStackTrace(e), Reporter.FAIL);
        }
    }

}
