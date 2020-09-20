package com.radware.vision.thirdPartyAPIs.jFrog.models;

import lombok.Data;

import java.net.URI;
import java.util.Date;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:18 PM
 */
@Data
public class JFrogFileModel  {
    private String repo;
    private URI path;
    private Date created;
    private Date lastModified;
    private Date lastUpdated;
    private URI uri;
    private FileType type;
    private URI downloadUri;
    private String size;
}
