package com.radware.vision.thirdPartyAPIs.jFrog.models;

import lombok.Data;

import java.net.URI;
import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:18 PM
 */
@Data
public class Child extends ArtifactModel {
    private List<Child> children;
    private boolean isFolder;
    private FileType type;
    private URI downloadUri;
    private String size;
}
