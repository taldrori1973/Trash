package com.radware.vision.thirdPartyAPIs.jFrog;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.automation.tables.AutoTestBaseLineTable;
import com.radware.vision.restAPI.JFrogRestAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactChildPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFilePojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFolderPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactPojo;
import com.radware.vision.thirdPartyAPIs.jenkins.JenkinsAPI;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.BuildPojo;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.JobPojo;
import models.RestResponse;
import models.StatusCode;
import org.modelmapper.ModelMapper;

import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:36 PM
 */
public class RepositoryService {
    private static String JENKINS_JOB_TEMPLATE = "kvision_images_cron_%s";

    private ObjectMapper objectMapper;

    private JFrogRestAPI jFrogRestAPI;

    public RepositoryService(String repoName) throws IOException {
        this.objectMapper = new ObjectMapper();
        this.jFrogRestAPI = new JFrogRestAPI("jFrogBuildsArtifactory", repoName);
    }


    public JFrogFileModel getFile(FileType fileType, String version, String branch, Integer build) throws Exception {
        ArtifactFolderPojo buildPojo;
        String jenkinsJob;

        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);

        ArtifactFolderPojo versionPojo = getVersion(artifactPojo, version);

        ArtifactFolderPojo branchPojo = getBranch(versionPojo, branch);

        if (branchPojo == null) {
            jenkinsJob = String.format(JENKINS_JOB_TEMPLATE, "master");
            buildPojo = getFile(versionPojo, build, fileType, jenkinsJob);//build under version
        } else {
            jenkinsJob = String.format(JENKINS_JOB_TEMPLATE, branch);
            buildPojo = getFile(branchPojo, build, fileType, jenkinsJob);//build under branch
        }
        ArtifactFilePojo filePojo = getFile(buildPojo, fileType);
        ModelMapper modelMapper = new ModelMapper();
        JFrogFileModel jFrogFileModel = modelMapper.map(filePojo, JFrogFileModel.class);
        jFrogFileModel.setType(fileType);
        return jFrogFileModel;
    }

    public JFrogFileModel getFile(FileType fileType, Integer build, String branch) throws Exception {

        ArtifactFolderPojo buildPojo;
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath() + fileType.toString();
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo branchPojo = getBranch(artifactPojoFolder, branch.toLowerCase());// in Artifactory all folders are lower case
        if (branchPojo == null) {
            buildPojo = getFile(artifactPojoFolder, build, fileType, "dev");//build under version
        } else {
            buildPojo = getFile(branchPojo, build, fileType, branch);//build under branch
        }
        ArtifactFilePojo filePojo = getFile(buildPojo, fileType);
        ModelMapper modelMapper = new ModelMapper();
        JFrogFileModel jFrogFileModel = modelMapper.map(filePojo, JFrogFileModel.class);
        jFrogFileModel.setType(fileType);
        return jFrogFileModel;
    }

    public JFrogFileModel getFileFromLastExtendedBuild(FileType fileType, String branch) throws Exception {

        ArtifactFolderPojo buildPojo;
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath() + fileType.toString();
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo branchPojo = getBranch(artifactPojoFolder, branch.toLowerCase());// in Artifactory all folders are lower case
        String path = branchPojo.getPath().getPath().substring(1) + "/" + getLastSuccessfulExtendedBuild(branchPojo, branch);
        buildPojo = getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFilePojo filePojo = getFile(buildPojo, fileType);
        ModelMapper modelMapper = new ModelMapper();
        JFrogFileModel jFrogFileModel = modelMapper.map(filePojo, JFrogFileModel.class);
        jFrogFileModel.setType(fileType);
        return jFrogFileModel;
    }


    private ArtifactFilePojo getFile(ArtifactFolderPojo buildPojo, FileType fileType) throws Exception {
        List<ArtifactChildPojo> filterByFileType = buildPojo.getChildren().stream().filter(artifactChildPojo ->
                artifactChildPojo.getUri().getPath().substring(1).matches(fileType.getExtension())).collect(Collectors.toList());
        if (filterByFileType.size() == 0)
            throw new Exception(String.format("No File with extension %s was found", fileType.getExtension()));
        if (filterByFileType.size() > 1) throw new Exception(
                String.format("%d Files with extension %s were found: %s\n Please Customize Filtering Method at %s Class",
                        filterByFileType.size(),
                        fileType.getExtension(),
                        filterByFileType.toString(),
                        this.getClass().getName()
                ));
        String path = String.format("%s%s", buildPojo.getPath().getPath().substring(1), filterByFileType.get(0).getUri().toString());
        fileType.setFileName(filterByFileType.get(0).getUri().toString().substring(1));
        return getPojo(path, StatusCode.OK, ArtifactFilePojo.class);
    }


    private ArtifactFolderPojo getFile(ArtifactFolderPojo buildParent, Integer build, FileType fileType, String jenkinsJob) throws Exception {
        if (build != 0) {//specific build
            Integer buildID = getBuildIDByDeployID(buildParent, fileType, build, jenkinsJob);
            if(buildID == null)
                throw new Exception(String.format("The Build \"%s\" is building or failed", build));
            String path = buildParent.getPath().getPath().substring(1) + "/" + buildID;
//            if (isChildExistByUri(buildParent.getChildren(), build.toString()) && containsFileType(fileType, path)) {//build exist and contains the the file type
                //ArtifactFolderPojo buildsFolderPojo = getBranch(buildParent, fileType.toString());
                Integer parentBuildNumber = getParentBuildNumber(path);
//                BuildPojo buildInfo = JenkinsAPI.getBuildInfo(jenkinsJob, build);//get build data from jenkins
                BuildPojo buildInfo = JenkinsAPI.getBuildInfo(String.format(JENKINS_JOB_TEMPLATE, jenkinsJob), parentBuildNumber);
//                if the build still building or finish building not successfully
                if (buildInfo.isBuilding() || !buildInfo.getResult().equals("SUCCESS"))
                    throw new Exception(String.format("The Build \"%s\" is building or failed", build));

                return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
//            } else
//                throw new Exception(String.format("The Build \"%s\" not found under %s OR the build not contains \"%s\" file type", build, buildParent.getPath().getPath(), fileType.getExtension()));
        } else {//latest build
            build = getLastSuccessfulBuild(buildParent, fileType, jenkinsJob);
            String path = buildParent.getPath().getPath().substring(1) + "/" + build;
            return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
        }
    }

    private Integer getBuildIDByDeployID(ArtifactFolderPojo buildParent, FileType fileType, Integer deployID, String jenkinsJob)
    {
        Set<Integer> buildsNumbers = buildParent.getChildren().stream().map(buildChildPojo -> Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))).collect(Collectors.toSet());
        Stack<Integer> builds = countingSort(buildsNumbers);

        Integer last;

        while (!builds.isEmpty()) {
            last = builds.pop();

            try {
                String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
                ArtifactFolderPojo buildPojo = getPojo(buildPath, StatusCode.OK, ArtifactFolderPojo.class);
                ArtifactFilePojo filePojo = getFile(buildPojo, FileType.valueOf(fileType.toString().toUpperCase()));
                Pattern p = Pattern.compile(String.format("%d-%s-D-([\\d]+)-", last, jenkinsJob));
                Matcher m = p.matcher(filePojo.getPath().getPath());
                while (m.find()) {
                    Integer buildDeployID = Integer.parseInt(m.group(1));
                    if(buildDeployID.equals(deployID))
                        return last;
                }
            }
            catch (Exception e){}
        }
        //throw new Exception("No Success Build was found ");

        return null;
    }

    private Integer getLastSuccessfulBuild(ArtifactFolderPojo buildParent, FileType fileType, String jenkinsJob) throws Exception {
//        build array of builds number
        Set<Integer> buildsNumbers = buildParent.getChildren().stream().map(buildChildPojo -> Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))).collect(Collectors.toSet());
        Stack<Integer> builds = countingSort(buildsNumbers);

        Integer last;

        while (!builds.isEmpty()) {
            last = builds.pop();
            String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
            if (containsFileType(fileType, buildPath)) {
//                BuildPojo buildInfo = JenkinsAPI.getBuildInfo(jenkinsJob, last);
                BuildPojo buildInfo = JenkinsAPI.getBuildInfoCvision(jenkinsJob, last);
                if (buildInfo.isBuilding()) continue;
                if (buildInfo.getResult().equals("SUCCESS")) return last;
            }
        }
        throw new Exception("No Success Build was found ");
    }

    private Stack<Integer> countingSort(Set<Integer> buildsNumbers) {
        int minBuildNumber = buildsNumbers.stream().min(Integer::compareTo).orElse(0);//for example 601
        int maxBuildNumber = buildsNumbers.stream().max(Integer::compareTo).orElse(0);//for example 610

        int buildsNumbersRange = maxBuildNumber - minBuildNumber + 1;//610-601+1=10

        Integer[] counterArray = new Integer[buildsNumbersRange];//build array of size 10 [0..9]
        buildsNumbers.forEach(buildNumber -> counterArray[buildNumber - minBuildNumber] = 1);

        Stack<Integer> priorityQueue = new Stack<>();
        for (int i = 0; i < counterArray.length; i++) {
            if (counterArray[i] != null) priorityQueue.push(i + minBuildNumber);
        }
        return priorityQueue;
    }

    private boolean containsFileType(FileType fileType, String buildPath) throws Exception {
        ArtifactFolderPojo buildPojo = getPojo(buildPath, StatusCode.OK, ArtifactFolderPojo.class);
        return buildPojo.getChildren().stream().anyMatch(artifactChildPojo -> artifactChildPojo.getUri().getPath().substring(1).matches(fileType.getExtension()));
    }

    private ArtifactFolderPojo getBranch(ArtifactFolderPojo branchParent, String branch) throws Exception {
        ArtifactFolderPojo branchPojo;
        if (branch == null) return null;//No branch in the hierarchy

        if (isChildExistByUri(branchParent.getChildren(), branch)) {
            String path = branchParent.getPath().getPath().substring(1) + "/" + branch;

            branchPojo = getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
        } else
            throw new Exception(String.format("The Branch \"%s\" not found under %s", branch, branchParent.getPath().getPath()));
        return branchPojo;
    }

    private ArtifactFolderPojo getVersion(ArtifactPojo artifactPojo, String version) throws Exception {
        ArtifactFolderPojo versionPojo;
        if (!version.equals("Latest")) {
            if (isChildExistByUri(artifactPojo.getChildren(), version)) {
                String path = artifactPojo.getPath().getPath().substring(1) + "/" + version;
                versionPojo = getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
            } else throw new Exception(String.format("The Version \"%s\" not found", version));
        } else {//Latest Version will be decided by created date

//            Map Artifact Children to Version Pojo Array
            String artifactPath = artifactPojo.getPath().getPath().substring(1);
            List<ArtifactFolderPojo> versionsPojos = artifactPojo.getChildren().stream().map(child -> {
                try {
                    return getPojo(artifactPath + child.getUri().getPath(), StatusCode.OK, ArtifactFolderPojo.class);
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }).collect(Collectors.toList());

            Optional<ArtifactFolderPojo> lastVersion = versionsPojos.stream().max((version1, version2) -> version1.getCreated().compareTo(version2.getCreated()));
            return lastVersion.orElseThrow(Exception::new);
        }
        return versionPojo;
    }

    private boolean isChildExistByUri(List<ArtifactChildPojo> children, String child) {
        return children.stream().anyMatch(artifactChildPojo -> artifactChildPojo.getUri().getPath().equals("/" + child));
    }


    private <T> T getPojo(String path, StatusCode expectedStatusCode, Class<T> clazz) throws Exception {
        RestResponse restResponse = jFrogRestAPI.sendRequest(path, expectedStatusCode);
        return objectMapper.readValue(restResponse.getBody().getBodyAsString(), clazz);
    }


    private Integer getLastSuccessfulExtendedBuild(ArtifactFolderPojo buildParent, String jenkinsJob) throws Exception {
//        build array of builds number
        Set<Integer> buildsNumbers = buildParent.getChildren().stream().map(buildChildPojo -> Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))).collect(Collectors.toSet());
        Stack<Integer> builds = countingSort(buildsNumbers);
        Integer lastParentSuccessfulBuild = getLastParentSuccessfulBuild(jenkinsJob);
        Integer last;
        while (!builds.isEmpty()) {
            last = builds.pop();
            String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
            Integer parentBuild = getParentBuildNumber(buildPath);
            if (parentBuild == null) continue;
            if (parentBuild.equals(lastParentSuccessfulBuild)) {
                return last;
            }
        }
        throw new Exception("No Success Build was found ");
    }

    private Integer getLastSuccessfulExtendedDeployID(ArtifactFolderPojo buildParent, String jenkinsJob) throws Exception {
//        build array of builds number
        Set<Integer> buildsNumbers = buildParent.getChildren().stream().map(buildChildPojo -> Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))).collect(Collectors.toSet());
        Stack<Integer> builds = countingSort(buildsNumbers);
        Integer lastParentSuccessfulBuild = getLastParentSuccessfulBuild(jenkinsJob);
        Integer last;
        while (!builds.isEmpty()) {
            last = builds.pop();
            String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
            Integer parentBuild = getParentBuildNumber(buildPath);
            if (parentBuild == null) continue;
            if (parentBuild == lastParentSuccessfulBuild) {
                ArtifactFolderPojo buildPojo = getPojo(buildPath, StatusCode.OK, ArtifactFolderPojo.class);
                String fileType = buildPath.split("/")[0];
                ArtifactFilePojo filePojo = getFile(buildPojo, FileType.valueOf(fileType.toUpperCase()));
                Pattern p = Pattern.compile(String.format("%d-%s-D-([\\d]+)-", last, jenkinsJob));
                Matcher m = p.matcher(filePojo.getPath().getPath());
                while(m.find()) {
                    try {
                        return Integer.parseInt(m.group(1));
                    }
                    catch (Exception e){}
                }
            }
        }
        throw new Exception("No Success Build was found ");
    }

    private Integer getLastParentSuccessfulBuild(String jenkinsJob)
    {
        Integer lastParentBuildNumber = null;

        try {
            JobPojo jobPojo = JenkinsAPI.getJobInfo(String.format(JENKINS_JOB_TEMPLATE, jenkinsJob));
            lastParentBuildNumber = jobPojo.getLastSuccessfulBuild();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lastParentBuildNumber;
    }

    private Integer getParentBuildNumber(String buildPath)
    {
        try {
            Map<String, String> queryParams = new HashMap<>();
            queryParams.put("repoKey", jFrogRestAPI.getRepoName());
            queryParams.put("path", String.format("%s/manifest.yaml", buildPath));
            RestResponse restResponse = jFrogRestAPI.sendRequest("Get Artifact Properties", queryParams, StatusCode.OK);
            String key = "\"build.parentNumber\",\"value\":\"";
            String jsonAsString = restResponse.getBody().getBodyAsString();
            Integer i = jsonAsString.indexOf(key);
            if(i<0) return null;
            Integer j = jsonAsString.indexOf("\"", i + key.length()+1);
            if(j<0) return null;
            String parentBuildNumberString = jsonAsString.substring(i+key.length(), j);
            return Integer.parseInt(parentBuildNumberString);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean isExtended(String path) {
        try {
            Map<String, String> queryParams = new HashMap<>();
            if (path == null) path = "";
            queryParams.put("repoKey", jFrogRestAPI.getRepoName());
            queryParams.put("path", String.format("%s/cm.version.txt", path));
            RestResponse restResponse = jFrogRestAPI.sendRequest("Get Artifact Properties", queryParams, StatusCode.OK);
            return restResponse.getBody().getBodyAsString().toLowerCase().contains("extended");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }


    public int getLastExtendedBuildNumberFromBranch(String branch) throws Exception {
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath();
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo branchPojo = getBranch(artifactPojoFolder, branch);
        return getLastSuccessfulExtendedBuild(branchPojo, branch);
    }

    public int getLastExtendedBuildNumberFromBranch(String branch, String setupMode) throws Exception {
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath() + setupMode.toUpperCase();
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo branchPojo = getBranch(artifactPojoFolder, branch);
        return getLastSuccessfulExtendedBuild(branchPojo, branch);
    }

    public int getLastExtendedDeployNumberFromBranch(String branch, String setupMode) throws Exception {
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath() + ((setupMode!=null)?setupMode.toUpperCase():"");
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo branchPojo = getBranch(artifactPojoFolder, branch);
        Integer lastSuccessfulExtendedBuild = getLastSuccessfulExtendedDeployID(branchPojo, branch);
        return lastSuccessfulExtendedBuild;
    }

    public JFrogFileModel getFileUnderVersion(FileType fileType, String version) throws Exception {

        ArtifactFolderPojo buildPojo;
        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);
        String artifactPojoPtah = artifactPojo.getPath().getPath();
        ArtifactFolderPojo artifactPojoFolder = getPojo(artifactPojoPtah, StatusCode.OK, ArtifactFolderPojo.class);
        ArtifactFolderPojo versionPojo = getBranch(artifactPojoFolder, version.toLowerCase());// in Artifactory all folders are lower case
        buildPojo = getFileFromJfrog(versionPojo, fileType);//build under branch
        ArtifactFilePojo filePojo = getFile(buildPojo, fileType);
        ModelMapper modelMapper = new ModelMapper();
        JFrogFileModel jFrogFileModel = modelMapper.map(filePojo, JFrogFileModel.class);
        jFrogFileModel.setType(fileType);
        return jFrogFileModel;
    }

    private ArtifactFolderPojo getFileFromJfrog(ArtifactFolderPojo buildParent, FileType fileType) throws Exception {
        Integer build = getLastSuccessfulBuildUnderOldVersion(buildParent, fileType);
        String path = buildParent.getPath().getPath().substring(1) + "/" + build;
        return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
    }

    private Integer getLastSuccessfulBuildUnderOldVersion(ArtifactFolderPojo buildParent, FileType fileType) throws Exception {
        Set<Integer> buildsNumbers = buildParent.getChildren().stream().map(buildChildPojo -> Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))).collect(Collectors.toSet());
        Stack<Integer> builds = countingSort(buildsNumbers);
        Integer last;
        while (!builds.isEmpty()) {
            last = builds.pop();
            String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
            if (containsFileType(fileType, buildPath)) return last;
        }
        throw new Exception("No Success Build was found ");
    }

}
