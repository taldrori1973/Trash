package com.radware.vision.setup;

public interface Setup {
    public void buildSetup();

    public void validateSetupIsReady();

    public void restoreSetup() throws Exception;

}
