package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;

import java.util.List;
import java.util.Optional;

public class SetupDao {

    private Setup setup;

    public SetupDao(Setup setup) {
        this.setup = setup;
    }

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
