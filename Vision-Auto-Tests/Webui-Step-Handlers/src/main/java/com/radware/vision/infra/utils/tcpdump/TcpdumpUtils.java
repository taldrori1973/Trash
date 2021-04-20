package com.radware.vision.infra.utils.tcpdump;

import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.utils.DeviceUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by AviH on 11/04/2016.
 */
public class TcpdumpUtils {
    //counter to be added and if less then 2 fail the test

    public static void runTcpdumpInterval(String tcpdumpCommand, long timeInterval, long timeIntervalThreshold, RootServerCli cli) {
        String lastLine = "";
        long lastTime = 0;
        boolean atLeastTwoEventsToCompare = false;
        try {
            CliOperations.runCommand(cli, tcpdumpCommand, 30 * 60 * 1000, true);
            ArrayList<String> outputs = cli.getCmdOutput();

            for (String line : outputs) {
                long time = getTimeLine(line);
                if (time > 0 && lastTime != 0) {   // Compare the two time lines
                    atLeastTwoEventsToCompare = true;
                    long diff = time - lastTime;
                    if ((diff - timeIntervalThreshold) > timeInterval || (diff + timeIntervalThreshold) < timeInterval) {
                        String errMsg = String.format("The tcpdump line interval are big than the expected.\n line 1: %s\n line2: %s", lastLine, line);
                        throw new RuntimeException(errMsg);
                    }
                }
                lastLine = line;
                lastTime = time;
            }
            if(!atLeastTwoEventsToCompare){
                String errMsg = String.format("Less then Two relevant events. Nothing to compare");
                throw new RuntimeException(errMsg);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error at tcpdump interval utils: " + e.getMessage());
        }
    }


    public static void runTcpdumpValues(String tcpdumpCommand, String[] expectedValues, RootServerCli cli) {
         try {
             List<String> values =  new ArrayList<String>();
             Collections.addAll(values, expectedValues);

             ArrayList<String> outputs = runTcpDumpCommand(tcpdumpCommand, cli);
             validateTcpDumpOutputs(values, outputs);

        } catch (Exception e) {
            throw new RuntimeException("Error at tcpdump values utils: " + e.getMessage());
        }
    }
    public static ArrayList<String> runTcpDumpCommand(String tcpdumpCommand, RootServerCli cli){
        ArrayList<String> outputs = new ArrayList<>();
        try {
            CliOperations.runCommand(cli, tcpdumpCommand, 30 * 60 * 1000, true);
            outputs = cli.getCmdOutput();

        }catch(Exception e){
            throw new RuntimeException("Error at tcpdump values utils: " + e.getMessage());
        }
        return outputs;
    }

    public static int getTcpdumpCommandCount(String tcpdumpCommand, RootServerCli cli, String searchedText) {
        ArrayList<String> commandResult = runTcpDumpCommand(tcpdumpCommand, cli);
        int searchedTextInstances = 0;
        for(String dumpLine : commandResult) {
            if(dumpLine.contains(searchedText)) {
                searchedTextInstances++;
            }
        }
        return searchedTextInstances;
    }

    public static void validateTcpDumpOutputs(List<String> values, ArrayList<String> outputs){
        for (Iterator<String> iterator = values.iterator(); iterator.hasNext();) {
            String value = iterator.next();
            for (String line : outputs) {
                if (line.contains(value)) {
                    iterator.remove();
                    break;
                }
            }
        }
        if (!values.isEmpty()) {
            String errMsg = String.format("The tcpdump missing values: %s,\nTcpdump outputs: %s", values, outputs);
            throw new RuntimeException(errMsg);
        }
    }

    private static long getTimeLine(String line) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
            String timeStr = line.substring(0, 8);
            Date date = format.parse(timeStr);
            return date.getTime() / 1000;
        } catch (Exception e) {
            return 0;
        }
    }

    public static void validateVisionDeviceEvent(String tcpDumpCommand, String[] expectedValues, RootServerCli cli, VisionRestClient visionRestClient, String deviceIp, HttpMethodEnum requestType, String urlBasic, String body){
        List<String> values =  new ArrayList<String>();
        Collections.addAll(values, expectedValues);

        GetTcpDumpOutputThread thread = new GetTcpDumpOutputThread(tcpDumpCommand, cli);
        thread.start();
        if(deviceIp != null || !deviceIp.equals("")) {
            DeviceUtils.lockCommand(visionRestClient, deviceIp);
        }
        try {
            visionRestClient.runBasicRestRequest(requestType, urlBasic, body);

            thread.join();
        }catch(Exception e){
            throw new RuntimeException("Error at tcpdump values utils: " + e.getMessage());
        }
        validateTcpDumpOutputs(values, thread.getTcpDumpOutputs());
    }

    //===========================
    public static void validateTcpdumpVisionDeviceEventsInterval(String tcpDumpCommand, long timeInterval, long timeIntervalThreshold, RootServerCli cli, VisionRestClient visionRestClient, String deviceIp, HttpMethodEnum requestType, String urlBasic, String body) {
        String lastLine = "";
        long lastTime = 0;
        boolean atLeastTwoEventsToCompare = false;

        GetTcpDumpOutputThread thread = new GetTcpDumpOutputThread(tcpDumpCommand, cli);
        thread.start();
        if(deviceIp != null || !deviceIp.equals("")) {
            DeviceUtils.unlockCommand(visionRestClient, deviceIp);
            DeviceUtils.lockCommand(visionRestClient, deviceIp);
        }
        try {
            visionRestClient.runBasicRestRequest(requestType, urlBasic, body);
            thread.join();
            //InvokeUtils.invokeCommand(null, tcpDumpCommand, cli, 30 * 60 * 1000, true);
            //ArrayList<String> outputs = cli.getCmdOutput();

            for (String line : thread.getTcpDumpOutputs()) {
                long time = getTimeLine(line);
                if (time > 0 && lastTime != 0) {   // Compare the two time lines
                    atLeastTwoEventsToCompare = true;
                    long diff = time - lastTime;
                    if ((diff - timeIntervalThreshold) > timeInterval || (diff + timeIntervalThreshold) < timeInterval) {
                        String errMsg = String.format("The tcpdump line interval are big than the expected.\n line 1: %s\n line2: %s", lastLine, line);
                        throw new RuntimeException(errMsg);
                    }
                }
                lastLine = line;
                lastTime = time;
            }
            if(!atLeastTwoEventsToCompare){
                String errMsg = String.format("Less then Two relevant events. Nothing to compare");
                throw new RuntimeException(errMsg);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error at tcpdump interval utils: " + e.getMessage());
        }
    }


    public static void validateTcpdumpVisionDeviceEventsCount(String tcpDumpCommand, RootServerCli cli, VisionRestClient visionRestClient, String deviceIp, HttpMethodEnum requestType, String urlBasic, String body, String expectedText, int expectedTextCount) {
        GetTcpDumpOutputThread thread = new GetTcpDumpOutputThread(tcpDumpCommand, cli);
        thread.start();
        if(deviceIp != null || !deviceIp.equals("")) {
            DeviceUtils.unlockCommand(visionRestClient, deviceIp);
            DeviceUtils.lockCommand(visionRestClient, deviceIp);
        }
        try {
            visionRestClient.runBasicRestRequest(requestType, urlBasic, body);
            thread.join();
            ArrayList<String> tcpDump = thread.getTcpDumpOutputs();
            int searchedTextInstances = 0;
            for(String dumpLine : tcpDump) {
                if(dumpLine.contains(expectedText)) {
                    searchedTextInstances++;
                }
            }
            if(searchedTextInstances != expectedTextCount) {
                throw new RuntimeException("Tcpdump count validation failed: " + "\n" + "Found: " + tcpDump.size() + ", Expected: " + expectedTextCount);
            }

        } catch (Exception e) {
            throw new RuntimeException("Error at tcpdump interval utils: " + e.getMessage());
        }
    }
}
