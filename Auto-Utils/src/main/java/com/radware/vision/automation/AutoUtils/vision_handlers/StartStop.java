package com.radware.vision.automation.AutoUtils.vision_handlers;

public enum StartStop {
	
	START("Start"),
	STOP("Stop"),
	OTHER("Other");
	
	public String startOrStop;

    private StartStop(String startOrStop) {
            this.startOrStop = startOrStop;
    }
}
