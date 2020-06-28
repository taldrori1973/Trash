package com.radware.vision.thirdPartyAPIs.jenkins.pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers.JobPojoDeserializer;
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
    private Integer firstBuild;
    private Integer lastBuild;
    private Integer lastCompletedBuild;
    private Integer lastFailedBuild;
    private Integer lastStableBuild;
    private Integer lastSuccessfulBuild;
    private Integer lastUnstableBuild;
    private Integer nextBuildNumber;

    @JsonDeserialize(using = JobPojoDeserializer.class)
    private List<Integer> builds;
}
