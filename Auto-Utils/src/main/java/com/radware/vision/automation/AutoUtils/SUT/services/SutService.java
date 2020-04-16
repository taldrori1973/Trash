package com.radware.vision.automation.AutoUtils.SUT.services;

import com.radware.vision.automation.AutoUtils.SUT.repositories.DevicesDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.SetupDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.SutDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;


public class SutService {

    private DevicesDao devicesDao;
    private SetupDao setupDao;
    private SutDao sutDao;

    public SutService(Devices devicesPojo, SUTPojo sutPojo, Setup setupPojo) {
        this.devicesDao = new DevicesDao(devicesPojo);
        this.setupDao = new SetupDao(setupPojo);
        this.sutDao = new SutDao(sutPojo);
    }

    public String getSetupId() {
        return setupDao.getSetupId();
    }
}
