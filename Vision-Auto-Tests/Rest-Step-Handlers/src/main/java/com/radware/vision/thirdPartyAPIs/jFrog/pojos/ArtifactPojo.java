package com.radware.vision.thirdPartyAPIs.jFrog.pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.joda.time.DateTime;

import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ArtifactPojo {

    private String repo;
    private String path;
    private DateTime created;
    private DateTime lastModified;
    private DateTime lastUpdated;
    private List<ArtifactChildPojo> children;
    private String uri;
}
