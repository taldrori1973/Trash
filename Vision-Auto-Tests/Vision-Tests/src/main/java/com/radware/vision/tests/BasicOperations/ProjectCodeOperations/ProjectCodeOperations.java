package com.radware.vision.tests.BasicOperations.ProjectCodeOperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import jsystem.framework.TestProperties;
import junit.framework.SystemTestCase4;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

/**
 * Created by urig on 6/17/2015.
 */
public class ProjectCodeOperations extends SystemTestCase4 {

    String targetFolder;
    ProjectNameEnum projectNameEnum;
    ProjectVersionEnum projectVersionEnum;

    static List<String> copiedTargetClassesSubfolders;
    static List<String> copiedTargetSubfolders;

    static {
        copiedTargetClassesSubfolders = Arrays.asList(new String[]{"annotations", "autogen", "basejunit", "browserprofiles", "C#apps", "clientdevicedrivers", "com",
                "enums", "externals", "global", "inputfiles", "org", "systemobjects", "templatePolicies", "testhandlers", "testutils", "basicoperations", "tests"});
        copiedTargetSubfolders = Arrays.asList(new String[]{"antrun", "dependency-maven-plugin-markers", "maven-archiver", "maven-status", "surefire"});
    }

    enum ProjectVersionEnum {
        Version_3_20("3.20"),
        Version_3_30("3.30"),
        Version_3_40("3.40");

        String projectVersion;

        ProjectVersionEnum(String projectVersion) {
            this.projectVersion = projectVersion;
        }

        public String getProjectVersion() {
            return  this.projectVersion;
        }
    }

    enum ProjectNameEnum {
        WebUI("WebUITests"),
        ReSTAPI("RestTests"),
        MasterAuto("Master-Automation");

        String projectName;

        ProjectNameEnum(String projectName) {
            this.projectName = projectName;
        }

        public String getProjectName() {
            return  this.projectName;
        }
    }

    @Test
    @TestProperties(name = "Copy Jsystem Project", paramsInclude = {"targetFolder", "projectNameEnum", "projectVersionEnum"})
    public void copyJsystemProject() {
        String sourceFolder = "\\\\10.205.191.200\\Shared\\JSystem" + "\\" + projectNameEnum.getProjectName() + "\\" + projectVersionEnum.getProjectVersion();
        String xcopyCommand = "cmd /c start xcopy" + " ";
        String deleteCommand = "cmd /c start del" + " " + "/s" + " ";
        String folderSuffix;
        try {
            // Delete .class files
            Runtime.getRuntime().exec(deleteCommand + targetFolder + "\\*.class").waitFor();
            // Delete *.jar files
            Runtime.getRuntime().exec(deleteCommand + targetFolder + "\\lib\\*.jar").waitFor();

            folderSuffix = "\\" + "target" + "\\" + "classes" + "\\";
            for(String targetClassesSubfolder : copiedTargetClassesSubfolders) {
                Thread.sleep(1000);
                Runtime.getRuntime().exec(xcopyCommand + sourceFolder + folderSuffix + targetClassesSubfolder + " " + targetFolder + folderSuffix + targetClassesSubfolder + " " + "/E /Y /I");
            }
            folderSuffix = "\\" + "target" + "\\";
            for(String targetSubfolder : copiedTargetSubfolders) {
                Runtime.getRuntime().exec(xcopyCommand + sourceFolder + folderSuffix + targetSubfolder + " " + targetFolder + folderSuffix + targetSubfolder + " " + "/E /Y /I").waitFor();
            }

            Runtime.getRuntime().exec(xcopyCommand + sourceFolder + "\\" + "target\\*.jar" + " " + targetFolder + "\\" + "target" + " " + "/E /Y /I").waitFor();
            Runtime.getRuntime().exec(xcopyCommand + sourceFolder + "\\" + "target\\classes\\jsystem.properties" + " " + targetFolder + "\\" + "target\\classes" + " " + " /Y").waitFor();
            Runtime.getRuntime().exec(xcopyCommand + sourceFolder + "\\" + "target\\classes\\AlertsAllType.sh" + " " + targetFolder + "\\" + "target\\classes\\AlertsAllType.sh" + " " + " /Y").waitFor();

            // Create the src/main/resources folder
            Runtime.getRuntime().exec("cmd /c start mkdir " + targetFolder + "\\" + "src\\main\\resources").waitFor();
            // Copy jar files
            Runtime.getRuntime().exec(xcopyCommand + sourceFolder + "\\" + "lib" + " " + targetFolder + "\\" + "lib" + " " + "/E /Y /I").waitFor();
            BaseTestUtils.report("All files from: " + sourceFolder + " were successfully copied to: " + targetFolder, Reporter.PASS);
        }
        catch(Exception e) {
            BaseTestUtils.report("Failed in copying project files." + e.getMessage(), Reporter.FAIL);
        }

    }

    public String getTargetFolder() {
        return targetFolder;
    }

    public void setTargetFolder(String targetFolder) {
        this.targetFolder = targetFolder;
    }

    public ProjectVersionEnum getProjectVersionEnum() {
        return projectVersionEnum;
    }

    public void setProjectVersionEnum(ProjectVersionEnum projectVersionEnum) {
        this.projectVersionEnum = projectVersionEnum;
    }

    public ProjectNameEnum getProjectNameEnum() {
        return projectNameEnum;
    }

    public void setProjectNameEnum(ProjectNameEnum projectNameEnum) {
        this.projectNameEnum = projectNameEnum;
    }
}
