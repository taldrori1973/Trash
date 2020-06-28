package com.radware.vision.thirdPartyAPIs.jenkins.models;

import com.radware.vision.thirdPartyAPIs.jenkins.pojos.BuildPojo;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.JobPojo;
import lombok.Data;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
public class JenkinsAPI {
    public JobPojo getJobInfo(String jobName) {

        return null;
    }

    public BuildPojo getBuildInfo(String jobName, Integer buildNumber) {
        return null;
    }
}
