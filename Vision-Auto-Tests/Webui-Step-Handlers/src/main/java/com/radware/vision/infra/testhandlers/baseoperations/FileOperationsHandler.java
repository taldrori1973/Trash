package com.radware.vision.infra.testhandlers.baseoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;

import java.io.FileNotFoundException;

public class FileOperationsHandler {

    public static void deleteDownloadedFile(String fileName) {
        try {
            String fullFileName;
            if (FileUtils.isLinux()) {
                fullFileName = FileUtils.JENKINS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
            } else {
                fullFileName = FileUtils.WINDOWS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
            }
            boolean isExist;
            FileUtils.deleteFile(fullFileName);
            isExist = FileUtils.isFileExist(fullFileName, 2000);
            if (isExist) {
                BaseTestUtils.report("File not deleted: " + fileName, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete the downloaded file: " + fileName, e);
        }
    }

    public static void validateDownloadedFileExistence(String fileName) {
        String fullFileName;
        boolean isExist;
        if (FileUtils.isLinux()) {
            fullFileName = FileUtils.JENKINS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
            isExist = FileUtils.isFileExist(fullFileName, 30000);
        } else {
            fullFileName = FileUtils.WINDOWS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
            isExist = FileUtils.isFileExist(fullFileName, 30000);
        }

        if (!isExist) {
            BaseTestUtils.report("File not found: " + fileName, Reporter.FAIL);
        }
    }

    public static void validateDownloadedFileSize(String fileName, long expectedFileSize) {
        String fullFileName;
        long actualFileSize = -1;
        try {
            if (FileUtils.isLinux()) {
                fullFileName = FileUtils.JENKINS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
                actualFileSize = FileUtils.getFileSize(fullFileName, 30000);
            } else {
                fullFileName = FileUtils.WINDOWS_LOCAL_DOWNLOAD_DIRECTORY + fileName;
                actualFileSize = FileUtils.getFileSize(fullFileName, 30000);
            }
        } catch (FileNotFoundException e) {
            BaseTestUtils.report("File not found: ", e);
        }
        catch (Exception e)
        {
            BaseTestUtils.report("Failed to validate the file size: ", e);
        }

        if(!(actualFileSize == expectedFileSize)){
            BaseTestUtils.report("wrong file size, expected size: " + expectedFileSize + ", and actual size: " + actualFileSize , Reporter.FAIL);
        }
    }


}
