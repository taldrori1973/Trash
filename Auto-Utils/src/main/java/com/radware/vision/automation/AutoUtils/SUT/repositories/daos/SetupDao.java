package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.SetupPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class SetupDao {

    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";

    private static SetupDao _instance;


    private SetupPojo setupPojo;

    public SetupDao(String setupFileName) {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        SystemProperties systemProperties = SystemProperties.get_instance();
        if(setupFileName==null) setupFileName = "defaultSetup.json";
        this.setupPojo = JsonUtilities.loadJsonFile(
                systemProperties.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_SETUPS_FILES_PATH_PROPERTY), setupFileName)
                ), SetupPojo.class
        );
    }

    public static SetupDao get_instance(String setupFileName) {
        if (Objects.isNull(_instance)) {
            _instance = new SetupDao(setupFileName);
        }
        return _instance;
    }


    //    DAO
    public Optional<Site> findSiteByName(String siteName) {
        return setupPojo.getTree().getSites().stream().filter(site -> site.getName().equals(siteName)).findAny();
    }

    public Optional<TreeDeviceNode> findDeviceById(String deviceId) {
        return setupPojo.getTree().getDevices().stream().filter(treeDeviceNode -> treeDeviceNode.getDeviceId().equals(deviceId)).findAny();
    }

    public List<TreeDeviceNode> findAllDevices() {
        return setupPojo.getTree().getDevices();
    }

    public List<Site> findAllSites() {
        return setupPojo.getTree().getSites();
    }

    public boolean isDeviceExistById(String deviceId) {
        Optional<TreeDeviceNode> filtered = this.setupPojo.getTree().getDevices().stream().filter(treeDeviceNode -> treeDeviceNode.getDeviceId().equals(deviceId)).findFirst();
        return filtered.isPresent();
    }

    public String getSetupId() {
        return this.setupPojo.getSetupId();
    }

    public String getDeviceParentSite(String deviceId) {
        Optional<TreeDeviceNode> device = this.findDeviceById(deviceId);
        return device.map(TreeDeviceNode::getParentSite).orElse(null);
    }
    public List<String> getSimulators() {
        return this.setupPojo.getSimulatorSet();
    }

    public String getDefenseFlowid() {
        return this.setupPojo.getDefenseFlowId();
    }

    public String getFNMId() {
        return this.setupPojo.getFnmId();
    }


}
