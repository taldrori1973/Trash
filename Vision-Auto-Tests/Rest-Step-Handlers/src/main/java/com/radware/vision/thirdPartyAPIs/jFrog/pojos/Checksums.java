package com.radware.vision.thirdPartyAPIs.jFrog.pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Checksums{
    public String sha1;
    public String md5;
    public String sha256;
}