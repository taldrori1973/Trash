package com.radware.vision.thirdPartyAPIs.jFrog.pojos;

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
public class ArtifactFilePojo {
    private String repo;
    private URI path;
    private Date created;
    private String createdBy;
    private Date lastModified;
    private String modifiedBy;
    private Date lastUpdated;
    private URI downloadUri;
    private String mimeType;
    private String size;
    private URI uri;

//    checksums
//    originalChecksums

}
