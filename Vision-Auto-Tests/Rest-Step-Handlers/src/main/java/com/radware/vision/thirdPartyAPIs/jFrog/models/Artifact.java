package com.radware.vision.thirdPartyAPIs.jFrog.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactChildPojo;
import lombok.Data;

import java.net.URI;
import java.util.Date;
import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Artifact {

    private String repo;
    private URI path;
    private Date created;
    private Date lastModified;
    private Date lastUpdated;
    private List<ArtifactChildPojo> children;
    private URI uri;
}
