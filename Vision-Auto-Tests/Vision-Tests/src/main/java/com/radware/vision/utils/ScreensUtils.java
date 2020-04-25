package com.radware.vision.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.vision.VisionUtils;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;

public class ScreensUtils {

	public static String getScreenXml(VisionRestClient visionRestClient, String screenName) {
        return VisionUtils.getVisionScreenFileContent(visionRestClient, screenName);
    }

    public static String getOperationXml(VisionRestClient visionRestClient, String operationName) {
        return VisionUtils.getVisionOperationFileContent(visionRestClient, operationName);
    }

    public static String getAppShapeScreenXml(VisionRestClient visionRestClient, String screenName) {
        return VisionUtils.getAppShapeScreenXml(visionRestClient, screenName.replace(".xml", ""));
    }

    public static HashMap<String, String> getClientScreeList() {
        HashMap<String, String> filesNames = new HashMap<String, String>();

		try {
            String deviceDriverFile = IOUtils.toString(ScreensUtils.class.getResourceAsStream("/inputfiles/" + DeviceDriverFIleTypes.ClientDeviceDriverFiles.getDeviceDriverFileType()));
            String appShapeDeviceDriverFile = IOUtils.toString(ScreensUtils.class.getResourceAsStream("/inputfiles/" + DeviceDriverFIleTypes.AppShapeDeviceDriverFiles.getDeviceDriverFileType()));
            String fileSplitter = deviceDriverFile.contains("\r") ? "\r\n" : "\n";
            for (String file : deviceDriverFile.split(fileSplitter)) {
                filesNames.put(file, DeviceDriverFIleTypes.ClientDeviceDriverFiles.getDeviceDriverFileType());
            }
            fileSplitter = appShapeDeviceDriverFile.contains("\r") ? "\r\n" : "\n";
            for (String file : appShapeDeviceDriverFile.split(fileSplitter)) {
                filesNames.put(file, DeviceDriverFIleTypes.AppShapeDeviceDriverFiles.getDeviceDriverFileType());
            }

		} catch (IOException ioe) {
			// Ignore
		}
		return filesNames;
	}

	public static void writeClientDeviceDriverFiles(VisionRestClient visionRestClient, String deviceDriverOutputFolder, String navigationDriverOutputFolder, String serverHierarchyDriverOutputFolder) {
        HashMap<String, String> deviceDriversList = getClientScreeList();
        String currentFolder = ScreensUtils.class.getProtectionDomain().getCodeSource().getLocation().getPath() + deviceDriverOutputFolder;
		String currentNavigationFolder = ScreensUtils.class.getProtectionDomain().getCodeSource().getLocation().getPath() + navigationDriverOutputFolder;
		String currentServerHierarchyFolder = ScreensUtils.class.getProtectionDomain().getCodeSource().getLocation().getPath() + serverHierarchyDriverOutputFolder;

        String screens = "screens/";
        String operations = "operations/";
        currentFolder = FileUtils.getAbsoluteClassesPath() + FileUtils.getDelimiter() + deviceDriverOutputFolder;
        currentNavigationFolder = FileUtils.getAbsoluteClassesPath() + FileUtils.getDelimiter() + navigationDriverOutputFolder;
        currentServerHierarchyFolder = FileUtils.getAbsoluteClassesPath() + FileUtils.getDelimiter() + serverHierarchyDriverOutputFolder;
        for (String currentKey : deviceDriversList.keySet()) {
            String currentDriverContent = "";
            try {
                if (deviceDriversList.get(currentKey).equals(DeviceDriverFIleTypes.ClientDeviceDriverFiles.getDeviceDriverFileType())) {
                    if (currentKey.startsWith(screens)) {
                        currentKey = currentKey.substring(screens.length());
                        currentDriverContent = getScreenXml(visionRestClient, currentKey);
                    } else if (currentKey.startsWith(operations)) {
                        currentKey = currentKey.substring(operations.length());
                        currentDriverContent = getOperationXml(visionRestClient, currentKey);
                    }
                } else if (deviceDriversList.get(currentKey).equals(DeviceDriverFIleTypes.AppShapeDeviceDriverFiles.getDeviceDriverFileType())) {
                    currentDriverContent = getAppShapeScreenXml(visionRestClient, currentKey);
                }
                String filePathPrefix = "";
                if (currentKey.equals("navigation.xml")) {
                    filePathPrefix = currentNavigationFolder;
                } else if (currentKey.equals("version_hierarchy.xml")) {
                    filePathPrefix = currentServerHierarchyFolder;
                }
                else {
                    filePathPrefix = currentFolder;
                }
                String filePath = filePathPrefix + "/" + currentKey;
                currentDriverContent = currentDriverContent.replaceAll("[^\\x00-\\x7F]", "");
                FileUtils.writeToFile(filePath, currentDriverContent);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage() + "\n" + e.getCause() + "\n" + Arrays.asList(e.getStackTrace()) + "\n" + e.getClass().getCanonicalName(), Reporter.PASS);
                continue;
            }
        }
	}

    public enum DeviceDriverFIleTypes {

        ClientDeviceDriverFiles("ClientDeviceDriverFiles.txt"), AppShapeDeviceDriverFiles("AppShapeDeviceDriverFiles.txt");

        String deviceDriverFileType = null;

        private DeviceDriverFIleTypes(String deviceDriverFileType) {
            this.deviceDriverFileType = deviceDriverFileType;
        }

        public String getDeviceDriverFileType() {
            return this.deviceDriverFileType;
        }
    }
}
