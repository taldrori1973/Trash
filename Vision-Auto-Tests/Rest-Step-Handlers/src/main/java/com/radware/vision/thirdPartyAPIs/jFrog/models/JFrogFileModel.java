package com.radware.vision.thirdPartyAPIs.jFrog.models;

import lombok.Data;

import java.net.URI;
import java.util.Date;
import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:18 PM
 */
@Data
public class JFrogFileModel extends ArtifactModel {
    private String repo;
    private URI path;
    private Date created;
    private Date lastModified;
    private Date lastUpdated;
    private URI uri;
    private List<JFrogFileModel> JFrogFileModels;
    private boolean isFolder;
    private FileType type;
    private URI downloadUri;
    private String size;
}
