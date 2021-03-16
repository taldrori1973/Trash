package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.java;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.java.certificate_algorithm.CertificateAlgorithm;

/**
 * Created by AviH on 10/04/2016.
 */
public class Java extends Builder {

    public Java(String prefix) {
        super(prefix);
    }

    public CertificateAlgorithm certificateAlgorithm() { return new CertificateAlgorithm(build()); }

    @Override
    public String getCommand() {
        return " java";
    }
}
