package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.environments.Environment;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.environments.Environments;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import java.util.ArrayList;
import java.util.List;

public class EnvironmentsDao {
    private static final String SUT_ENVIRONMENTS_FILES_PATH_PROPERTY = "SUT.environments.path";
    private static final String ENVIRONMENTS_FILE_NAME = "environments.json";

    private static EnvironmentsDao _instance = new EnvironmentsDao();
    private Environments environmentsPojo;
    private List<Environment> allEnvironments;

    public EnvironmentsDao() {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        SystemProperties systemProperties = SystemProperties.get_instance();
        this.environmentsPojo = JsonUtilities.loadJsonFile(
                systemProperties.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_ENVIRONMENTS_FILES_PATH_PROPERTY), ENVIRONMENTS_FILE_NAME)
                ),
                Environments.class
        );

        loadAllEnvironments();
    }

    private void loadAllEnvironments() {
        this.allEnvironments = new ArrayList<>();
        allEnvironments.addAll(environmentsPojo.getEnvironments());
    }

    public static EnvironmentsDao get_instance() {
        return _instance;
    }

    public List<Environment> findAllEnvironments() {
        return this.allEnvironments;
    }
}
