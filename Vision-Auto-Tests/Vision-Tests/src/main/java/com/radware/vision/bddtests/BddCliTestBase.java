package com.radware.vision.bddtests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.base.VisionUITestBase;


public class BddCliTestBase extends VisionUITestBase {

    public BddCliTestBase() {
        try {
//            super.coreInit();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Init", e);
        }
    }
}
