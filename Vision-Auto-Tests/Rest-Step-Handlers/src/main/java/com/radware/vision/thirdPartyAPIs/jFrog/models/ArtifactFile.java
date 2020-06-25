package com.radware.vision.thirdPartyAPIs.jFrog.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.net.URI;
import java.util.Date;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ArtifactFile {
    private FileType type;
    private String repo;
    private URI path;
    private Date created;
    private Date lastModified;
    private Date lastUpdated;
    private URI downloadUri;
    private String size;
    private URI uri;

//    checksums
//    originalChecksums

}
