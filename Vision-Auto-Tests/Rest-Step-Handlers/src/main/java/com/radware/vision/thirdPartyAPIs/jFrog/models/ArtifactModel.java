package com.radware.vision.thirdPartyAPIs.jFrog.models;

import lombok.Data;

import java.net.URI;
import java.util.Date;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 3:27 PM
 */
@Data
public abstract class ArtifactModel {
    private String repo;
    private URI path;
    private Date created;
    private Date lastModified;
    private Date lastUpdated;
    private URI uri;

}
