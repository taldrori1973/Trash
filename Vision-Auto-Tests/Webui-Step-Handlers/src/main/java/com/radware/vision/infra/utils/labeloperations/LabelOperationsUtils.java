package com.radware.vision.infra.utils.labeloperations;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.infra.enums.GlobalConstants;
import com.radware.vision.infra.enums.WebWidgetType;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;

import static com.radware.automation.tools.utils.FileUtils.getFileSeparator;

/**
 * Created by AviH on 08/02/2016.
 */

public class LabelOperationsUtils {
    private static final String LINUX_GREP_UTIL = "/bin/grep";
    private static final String WINDOWS_GREP_UTIL = "findstr";
    private static final String fileTypeExtension = "xml";

    public static Set<String> findVisionFilesByLabelName(String label, WebWidgetType fieldType, ServerCliBase localServerCli) {
        StringBuilder command = new StringBuilder();
        String findStr = null;
        boolean isLinux = FileUtils.isLinux();
        Set<String> files;
        try {
            String currentNavigationFolder = FileUtils.getAbsoluteClassesPath() + GlobalConstants.CLIENT_DEVICE_DRIVERS_OUTPUT_FOLDER.getValue() + getFileSeparator() + "*";
            findStr = buildFindStr(isLinux, label, fieldType);
            if (isLinux) {
                command.append(LINUX_GREP_UTIL).append(" ").append(findStr).append(" ").append(currentNavigationFolder);
                command.append("\n");
                files = invokeLinuxCommand(command.toString(), localServerCli);
            } else {
                currentNavigationFolder = currentNavigationFolder.replace("/", "\\");
                command.append(WINDOWS_GREP_UTIL).append(" ").append(findStr).append(" ").append(currentNavigationFolder);
                files = invokeWindowsCommand(command.toString(), label);
            }

        } catch (Exception e) {
            String errMsg = "Failed to execute find command for " + findStr + ", Error: " + e.getMessage();
             throw new RuntimeException(errMsg);
        }
        return files;
    }

    private static String buildFindStr(boolean isLinux, String label, WebWidgetType fieldType) {
        String findStr = null;
        if (isLinux) {
            switch (fieldType) {
                case Tab:
                    findStr = " \"label=\\\"" + label + "\\\"\" ";
                    break;
                case Text:
                    findStr = " \"label=\\\"" + label + "\\\"\" ";
                    break;
                case Checkbox:
                    findStr = " \"label=\\\"" + label + "\\\"\" ";
                    break;
                case Dropdown:
                    findStr = " \"label=\\\"" + label + "\\\"\" ";
                    break;
                case RadioButton:
                    findStr = " \"value=\\\"" + label + "\\\"\" ";
                    break;
                case DualList:
                    findStr = " \"label=\\\"" + label + "\\\"\" ";
                    break;
                case Table:
                    findStr = " \"[rowName|label]=\\\"" + label + "\\\"\" ";
                    break;
            }
        } else {
            switch (fieldType) {
                case Tab:
                    findStr = "/C:label=\\\"" + label + "\\\"";
                    break;
                case Text:
                    findStr = "/C:label=\\\"" + label + "\\\"";
                    break;
                case Checkbox:
                    findStr = "/C:label=\\\"" + label + "\\\"";
                    break;
                case Dropdown:
                    findStr = "/C:label=\\\"" + label + "\\\"";
                    break;
                case RadioButton:
                    findStr = "/C:value=\\\"" + label + "\\\"";
                    break;
                case DualList:
                    findStr = "/C:label=\\\"" + label + "\\\"";
                    break;
                case Table:
                    findStr = "/C:=\\\"" + label + "\\\"";
                    break;
            }
        }
        return findStr;
    }

    public static List<String> findDeviceFilesByLabelName(String deviceDriverId, String label, WebWidgetType fieldType, RootServerCli radwareServer) {
        List<String> files = new ArrayList<String>();
        String findStr = fieldType == WebWidgetType.RadioButton ? " \"value=\\\"" + label + "\\\"\" " : " \"label=\\\"" + label + "\\\"\" ";
        String remoteCommand = LINUX_GREP_UTIL + findStr + FileUtils.REMOTE_DEVICE_DRIVERS_REPOSITORY_PATH + deviceDriverId + "/client/*";
        try {
            CliOperations.runCommand(radwareServer, remoteCommand);
            List<String> outputResult = radwareServer.getCmdOutput();
            for (String line : outputResult) {
                if (line.contains("Is a directory")) continue;
                String[] tmp = line.split(":");
                if (tmp.length > 1) {
                    files.add(tmp[0]);
                }
            }
        } catch (Exception e) {
            String errMsg = "Failed to execute find command for " + findStr + ", Error: " + e.getMessage();
            throw new RuntimeException(errMsg);
        }
        return files;
    }

    private static Set<String> invokeLinuxCommand(String command, ServerCliBase localServerCli) throws Exception {
        Set<String> files = new HashSet<String>();
        localServerCli.setProtocol(CliConnectionImpl.EnumConnectionType.SSH.value());
        CliOperations.runCommand(localServerCli,command, 10 * 1000, false, false, true, null, false);
        String result = localServerCli.getTestAgainstObject().toString();
        List<String> commandOutput = result != null ? Arrays.asList(result.split("\n")) : new ArrayList<String>();
        String file = "";

        for (String line : commandOutput) {
            file = line.split(":")[0];
            if (!file.contains(fileTypeExtension)) {
                continue;
            }
            file = file.substring(file.lastIndexOf("/") + 1);
            files.add(file);
        }
        return files;
    }

    private static Set<String> invokeWindowsCommand(String command, String label) throws IOException {
        Set<String> files = new HashSet<String>();
        ProcessBuilder builder = new ProcessBuilder(new String[] {"CMD", "/C", command});
        final Process process = builder.start();
        InputStream is = process.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(isr);
        String line;
        String file = "";
        while ((line = br.readLine()) != null) {
            if (line.contains(label)) {
                file = line.split(":")[1];
                file = file.substring(file.lastIndexOf("\\") + 1);
                files.add(file);
            }
        }
        process.destroy();
        return files;
    }
}
