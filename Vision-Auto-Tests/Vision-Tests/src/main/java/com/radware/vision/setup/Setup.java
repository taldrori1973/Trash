package com.radware.vision.setup;

public interface Setup {
    public void buildSetup() throws Exception;

    public void validateSetupIsReady();

    public void restoreSetup() throws Exception;

}
