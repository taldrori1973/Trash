package com.radware.vision.infra.base.pages.defensepro.configuration.setup;

import com.radware.vision.infra.base.pages.defensepro.configuration.setup.globalparameters.GlobalParameters;

/**
 * Created by moaada on 7/27/2017.
 */
public class Setup {

    public GlobalParameters globalParameters() {
        return (GlobalParameters) new GlobalParameters().openPage();
    }
}
