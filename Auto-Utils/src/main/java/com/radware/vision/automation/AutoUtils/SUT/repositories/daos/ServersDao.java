package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers.ExternalServersPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers.ServerPojo;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import java.util.Objects;
import java.util.Optional;

public class ServersDao {

    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";

    private static ServersDao _instance;


    private ExternalServersPojo externalServersPojo;

    public ServersDao(String externalServersFileName) {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        SystemProperties systemProperties = SystemProperties.get_instance();
        this.externalServersPojo = JsonUtilities.loadJsonFile(
                systemProperties.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_SETUPS_FILES_PATH_PROPERTY), externalServersFileName)
                ), ExternalServersPojo.class
        );
    }

    public static ServersDao get_instance(String externalServersFileName) {
        if (Objects.isNull(_instance)) {
            _instance = new ServersDao(externalServersFileName);
        }
        return _instance;
    }


    public Optional<ServerPojo> findServerById(String serverId) {
        return this.externalServersPojo.getServers().stream().filter(serverPojo -> serverPojo.getServerId().equals(serverId)).findFirst();
    }
}
