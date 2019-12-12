package com.radware.vision.infra.utils;

public class DeviceVisionWebUIUtils {
	public static AlteonWebUIUtils alteonUtils;
	public static DpWebUIUtils dpUtils;

	public static void init() {
		dpUtils = new DpWebUIUtils();
		dpUtils.setUp();
		alteonUtils = new AlteonWebUIUtils();
		alteonUtils.setUp();
	}
}
