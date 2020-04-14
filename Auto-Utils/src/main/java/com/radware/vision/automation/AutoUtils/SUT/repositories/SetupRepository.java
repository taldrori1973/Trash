package com.radware.vision.automation.AutoUtils.SUT.repositories;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;

import java.util.List;
import java.util.Optional;

public class SetupRepository {

    private Setup setup;

    public SetupRepository(Setup setup) {
        this.setup = setup;
    }

    public Optional<Site> findSiteByName(String siteName) {
        return setup.getSites().stream().filter(site -> site.getName().equals(siteName)).findAny();
    }

    public Optional<Device> findDeviceById(String deviceId) {
        return setup.getDevices().stream().filter(device -> device.getDeviceId().equals(deviceId)).findAny();
    }

    public List<Device> findAllDevices() {
        return setup.getDevices();
    }

    public List<Site> findAllSites() {
        return setup.getSites();
    }

}
