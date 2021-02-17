package com.radware.vision.thirdPartyAPIs.jFrog;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.restAPI.JFrogRestAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactChildPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFilePojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFolderPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactPojo;
import com.radware.vision.thirdPartyAPIs.jenkins.JenkinsAPI;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.BuildPojo;
import models.RestResponse;
import models.StatusCode;
import org.modelmapper.ModelMapper;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.Stack;
import java.util.stream.Collectors;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:36 PM
 */
public class RepositoryService {
    private static String JENKINS_JOB_TEMPLATE = "kvision_k8s_deploy_%s";

    private ObjectMapper objectMapper;

    private JFrogRestAPI jFrogRestAPI;

    public RepositoryService(String repoName) throws IOException {
        this.objectMapper = new ObjectMapper();
        this.jFrogRestAPI = new JFrogRestAPI("jFrogBuildsArtifactory",repoName);
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
        ModelMapper modelMapper=new ModelMapper();
        JFrogFileModel jFrogFileModel = modelMapper.map(filePojo, JFrogFileModel.class);
        jFrogFileModel.setType(fileType);
        return jFrogFileModel;
    }

    private ArtifactFilePojo getFile(ArtifactFolderPojo buildPojo, FileType fileType) throws Exception {
        List<ArtifactChildPojo> filterByFileType = buildPojo.getChildren().stream().filter(artifactChildPojo -> artifactChildPojo.getUri().getPath().endsWith(fileType.getExtension())).collect(Collectors.toList());
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

        return getPojo(path,StatusCode.OK,ArtifactFilePojo.class);
    }


    private ArtifactFolderPojo getFile(ArtifactFolderPojo buildParent, Integer build, FileType fileType, String jenkinsJob) throws Exception {
        if (build != 0) {//specific build
            String path = buildParent.getPath().getPath().substring(1) + "/" + build;
            if (isChildExistByUri(buildParent.getChildren(), build.toString()) && containsFileType(fileType, path)) {//build exist and contains the the file type

                BuildPojo buildInfo = JenkinsAPI.getBuildInfo(jenkinsJob, build);//get build data from jenkins

//                if the build still building or finish building not successfully
                if (buildInfo.isBuilding() || !buildInfo.getResult().equals("SUCCESS"))
                    throw new Exception(String.format("The Build \"%s\" is building or failed", build));

                return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
            } else
                throw new Exception(String.format("The Build \"%s\" not found under %s OR the build not contains \"%s\" file type", build, buildParent.getPath().getPath(), fileType.getExtension()));
        } else {//latest build

            build = getLastSuccessfulBuild(buildParent, fileType, jenkinsJob);
            String path = buildParent.getPath().getPath().substring(1) + "/" + build;
            return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);

        }
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
                BuildPojo buildInfo = JenkinsAPI.getBuildInfo(jenkinsJob, last);
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
        return buildPojo.getChildren().stream().anyMatch(artifactChildPojo -> artifactChildPojo.getUri().getPath().endsWith(fileType.getExtension()));
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
}