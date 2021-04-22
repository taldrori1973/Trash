package com.radware.vision.automation.AutoUtils.vision_handlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.cli.AlteonServer;
import com.radware.automation.tools.cli.LinuxFileServer;
import jsystem.framework.system.SystemObjectImpl;

public class VisionCli extends SystemObjectImpl{
	
	public VisionServer visionServer;
	public LinuxFileServer linuxFileServer;
	public AlteonServer alteonServer;
	public int numberOfTests= 0;
	public final int maxNumberOfTests = 15;

    String testProject;

    @Override
	public void init() throws Exception {
    	BaseTestUtils.reporter.startLevel("Init VisionCli");
		super.init();
		BaseTestUtils.reporter.report("Init VisionCli");
		BaseTestUtils.reporter.stopLevel();
    }

    public String getTestProject() {
        return testProject;
    }

    public void setTestProject(String testProject) {
        this.testProject = testProject;
    }
}
