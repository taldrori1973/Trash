package com.radware.vision.setup;

public interface Setup {
    public void buildSetup() throws Exception;

    public void validateSetupIsReady() throws Exception;

    public void restoreSetup() throws Exception;

}
