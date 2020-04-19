package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;

public class SutDao {

    private SUTPojo sutPojo;

    public SutDao(SUTPojo sutPojo) {
        this.sutPojo = sutPojo;
    }

    public String getSutId() {
        return this.sutPojo.getSetupFile();
    }
}
