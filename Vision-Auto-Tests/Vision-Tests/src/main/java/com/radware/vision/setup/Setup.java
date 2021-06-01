package com.radware.vision.setup;

import org.json.simple.parser.ParseException;

public interface Setup {
    public void buildSetup() throws NoSuchFieldException, ParseException;

    public void validateSetupIsReady();

    public void restoreSetup() throws Exception;

}
