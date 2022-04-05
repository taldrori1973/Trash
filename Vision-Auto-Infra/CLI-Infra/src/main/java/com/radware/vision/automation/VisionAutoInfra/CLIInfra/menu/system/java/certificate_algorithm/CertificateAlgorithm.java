package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.java.certificate_algorithm;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * Created by AviH on 10/04/2016.
 */
public class CertificateAlgorithm extends Builder {

    public CertificateAlgorithm(String prefix) {
        super(prefix);
    }

    public Get get(){
        return new Get(build());
    }

    public Set set() {
        return new Set(build());
    }

    @Override
    public String getCommand() {
        return " certificate-algorithm";
    }
}
