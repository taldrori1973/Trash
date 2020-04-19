package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;

import java.util.List;
import java.util.Optional;

public class SetupDao {

    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";

    private static SetupDao _instance = new SetupDao();


    private Setup setup;

    public SetupDao(String setupFileName) {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        this.setup = JsonUtilities.loadJsonFile(
                String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_SETUPS_FILES_PATH_PROPERTY), setupFileName), Setup.class
        );
    }

    public static SetupDao get_instance() {
        return _instance;
    }


    //    DAO
    public Optional<Site> findSiteByName(String siteName) {
        return setup.getTree().getSites().stream().filter(site -> site.getName().equals(siteName)).findAny();
    }

    public Optional<TreeDeviceNode> findDeviceById(String deviceId) {
        return setup.getTree().getDevices().stream().filter(treeDeviceNode -> treeDeviceNode.getDeviceId().equals(deviceId)).findAny();
    }

    public List<TreeDeviceNode> findAllDevices() {
        return setup.getTree().getDevices();
    }

    public List<Site> findAllSites() {
        return setup.getTree().getSites();
    }

    public boolean isDeviceExistById(String deviceId) {
        Optional<TreeDeviceNode> filtered = this.setup.getTree().getDevices().stream().filter(treeDeviceNode -> treeDeviceNode.getDeviceId().equals(deviceId)).findFirst();
        return filtered.isPresent();
    }

    public String getSetupId() {
        return this.setup.getSetupId();
    }
}
