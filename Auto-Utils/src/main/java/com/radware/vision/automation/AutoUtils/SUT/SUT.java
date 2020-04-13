package com.radware.vision.automation.AutoUtils.SUT;

import lombok.Data;

@Data
public class SUT {


    private static final SUT instance = new SUT();

    private SUT() {
    }

    public static public static SUT getInstance() {
        return instance;
    }
}
