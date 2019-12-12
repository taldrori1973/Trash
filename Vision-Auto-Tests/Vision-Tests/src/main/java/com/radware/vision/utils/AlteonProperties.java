package com.radware.vision.utils;

import com.radware.vision.infra.enums.VisionProperties;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class AlteonProperties {
	private static final String PROPERTIES_FILE_NAME = "alteon.properties";
    private Properties properties = new Properties();
	
	private static AlteonProperties instance = null;

	private AlteonProperties() throws Exception {
			String outputFolder = "/global/";
			String currentFolder = ScreensUtils.class.getProtectionDomain().getCodeSource().getLocation().getPath() + outputFolder;
			if(currentFolder.contains(".jar")) {
				outputFolder = "/target/classes" + outputFolder;
				currentFolder = currentFolder.subSequence(1, currentFolder.indexOf("/lib")).toString() + outputFolder;
			}
			FileInputStream in = new FileInputStream(currentFolder.concat(PROPERTIES_FILE_NAME));
			this.properties.load(in);
			in.close();
	}

	public static AlteonProperties getInstance() throws Exception {
		if (instance == null)
			instance = new AlteonProperties();
		return instance;
	}

	public String getProperty(String key) {
		return this.properties.getProperty(key);
	}

	public String getProperty(VisionProperties.PropertyKeys key) {
		return getProperty(key.toString());
	}

	private void setProperty(String key, String value) throws IOException {
		this.properties.setProperty(key, value);
		saveProperties();
	}

	public void setProperty(VisionProperties.PropertyKeys key, String value)
			throws IOException {
		setProperty(key.toString(), value);
	}

	private void removeProperty(String key) throws IOException {
		this.properties.remove(key);
		saveProperties();
	}

	public void removeProperty(VisionProperties.PropertyKeys key)
			throws IOException {
		removeProperty(key.toString());
	}

	private void saveProperties() throws IOException {
		FileOutputStream out = new FileOutputStream("alteon.properties");
		this.properties.store(out, "---Alteon Properties File---");
		out.close();
	}

	public void clearProperties() throws IOException {
		this.properties.clear();
		saveProperties();
	}
}
