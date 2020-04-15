package com.radware.vision.automation.AutoUtils.SUT.repositories;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;

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

    public Optional<Device> findDeviceById(String deviceId) {
        return setup.getTree().getDevices().stream().filter(device -> device.getDeviceId().equals(deviceId)).findAny();
    }

    public List<Device> findAllDevices() {
        return setup.getTree().getDevices();
    }

    public List<Site> findAllSites() {
        return setup.getTree().getSites();
    }

    public boolean isDeviceExistById(String deviceId) {
        Optional<Device> filtered = this.setup.getTree().getDevices().stream().filter(device -> device.getDeviceId().equals(deviceId)).findFirst();
        return filtered.isPresent();
    }
}
