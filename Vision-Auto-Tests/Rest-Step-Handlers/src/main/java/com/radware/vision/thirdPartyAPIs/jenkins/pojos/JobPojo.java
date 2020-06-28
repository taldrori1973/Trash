package com.radware.vision.thirdPartyAPIs.jenkins.pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers.JobPojoBuildDeserializer;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers.JobPojoBuildsArrayDeserializer;
import lombok.Data;

import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class JobPojo {

    private String name;
    private Integer nextBuildNumber;

    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer firstBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastCompletedBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastFailedBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastStableBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastSuccessfulBuild;
    @JsonDeserialize(using = JobPojoBuildDeserializer.class)
    private Integer lastUnstableBuild;

    @JsonDeserialize(using = JobPojoBuildsArrayDeserializer.class)
    private List<Integer> builds;
}
