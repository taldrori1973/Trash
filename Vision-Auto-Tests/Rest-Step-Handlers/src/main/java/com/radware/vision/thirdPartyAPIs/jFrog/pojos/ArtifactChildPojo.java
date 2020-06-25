package com.radware.vision.thirdPartyAPIs.jFrog.pojos;

import lombok.Data;

import java.nio.file.Path;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:52 PM
 */
@Data
public class ArtifactChildPojo {

    private Path uri;
    private boolean folder;

}
