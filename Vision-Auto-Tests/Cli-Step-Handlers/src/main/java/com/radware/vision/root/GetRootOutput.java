package com.radware.vision.root;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;
import jsystem.framework.report.Reporter;
import utils.RegexUtils;

import java.util.ArrayList;

public class GetRootOutput {

    /**
     * get size of directory
     * return full output ( not only number )
     * @throws Exception
     */
    public static String getDirSize(String dir, RootServerCli rootServerCli ) throws Exception{
        CliOperations.runCommand(rootServerCli, "du -sb " + dir);

        ArrayList<String> lines = RegexUtils.fromStringToArrayWithPattern("(\\d+)\\s+", rootServerCli.getTestAgainstObject().toString());

        return lines.get(0);
    }

    /**
     * this function send cli command via root, after it sends the query and after it looks for inputToFind in the returned data  
     * */
    public static void sqlQueryAndValidate(RootServerCli rootServerCli, String Command, String Query, String inputToFind) throws Exception {

        CliOperations.runCommand(rootServerCli, Command);
        CliOperations.runCommand(rootServerCli, Query);
        rootServerCli.analyze(new FindText(inputToFind));

    }


    /**
     * get size of directory by the directory name 
     * return full output ( not only number )
     * @throws Exception
     */
    public static String getDirSize(String fileName, String dir, RootServerCli rootServerCli ) throws Exception{
        CliOperations.runCommand(rootServerCli, "du -b " + dir);

        return (String) RegexUtils.fromStringToArrayWithPattern("(\\d+)\\s+", rootServerCli.getTestAgainstObject().toString(), fileName);
    }


    /**
     * ls plus the wanted string and return it without the first and the last line
     *
     * */
    public static String getLsString(String stringForUsingInLs, RootServerCli rootServerCli ) throws Exception{
        
        BaseTestUtils.reporter.startLevel("via root : ls " + stringForUsingInLs);
        CliOperations.runCommand(rootServerCli, "ls " + stringForUsingInLs);

        String queryResult = rootServerCli.getTestAgainstObject().toString();

        String [] queryResultArr = queryResult.split("\n");
        String resultFromTheFunction = "";
        for (int i=1;i+1<queryResultArr.length;i++) {
            resultFromTheFunction+=queryResultArr[i];
        }
        BaseTestUtils.reporter.stopLevel();
        return resultFromTheFunction;
    }

    public static void getLsString(String stringForUsingInLs, RootServerCli rootServerCli , String stringForFinding) throws Exception{
        try{

            BaseTestUtils.reporter.startLevel("root user : find string "+stringForFinding+" in ls cmd ");
            CliOperations.runCommand(rootServerCli, "ls " + stringForUsingInLs);
            rootServerCli.analyze(new  FindText(stringForFinding));
        }
        finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void getLsStringAndNotFindTheResult(String resultNotToFind, String stringForUsingInLs, RootServerCli rootServerCli ) throws Exception{
        BaseTestUtils.reporter.startLevel("get Ls String and verify that the wanted result isn't inside");
        if (getLsString(stringForUsingInLs, rootServerCli).contains(resultNotToFind)) {
            BaseTestUtils.reporter.report(resultNotToFind+" was found.", Reporter.FAIL);
        }
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * ls plus the wanted string and return
     *
     * */


    public static void getLsStringWithRegex(String stringForUsingInLs, RootServerCli rootServerCli , String stringForFinding) throws Exception{

        CliOperations.runCommand(rootServerCli, "ls " + stringForUsingInLs);
        rootServerCli.analyze(new FindRegex(stringForFinding));

    }


    /**
     * return the cat result of file + grep of specific String and returns array of lines
     * @author izikp
     * @throws Exception
     *
     * */
    public static String[] getLinuxCatGrep(RootServerCli rootServerCli, String filePath,String textToGrep) throws Exception{


        CliOperations.runCommand(rootServerCli, "cat " + filePath + " | grep " + textToGrep);
        String[] lines = rootServerCli.getTestAgainstObject().toString().split("\\r\\n");
        String[] resultLines = new String [lines.length];
        for (int i=1;i<lines.length-1;i++) {
            resultLines[i-1]=lines[i];
        }
        return resultLines;
    }


}
