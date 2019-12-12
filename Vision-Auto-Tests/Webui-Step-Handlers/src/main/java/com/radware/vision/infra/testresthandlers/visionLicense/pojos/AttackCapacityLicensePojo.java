package com.radware.vision.infra.testresthandlers.visionLicense.pojos;

import java.util.List;

/**
 * POJO For "mgmt/system/config/itemlist/attack/capacity/license" - returns Attack Capacity License as Follow:
 * {
 * "lastCalculationDate": 1563183395525,
 * "allowedAttackCapacityGbps": 6,
 * "requiredDevicesAttackCapacityGbps": 18,
 * "licensedDeviceOrmidList": [
 * "2c912402634578df01636e5f17b701f9",
 * "2c9124e563b0d06d0163b1ffcae8000b",
 * "2c9124e563b0d06d0163b20261ae001d"
 * ],
 * "hasDemoLicense": false,
 * "licenseViolated": true,
 * "inGracePeriod": true,
 * "attackCapacityMaxLicenseExist": false
 * }
 * <p>
 * and      /mgmt/system/config/item/licenseinfo - returns all License Types:
 * <p>
 * {
 * "attackCapacityLicense": {
 * "message": "The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the Attack Capacity license. Contact Radware Technical Support to purchase additional Attack Capacity licenses within 27 days. In 27 days, the system will only support the attack Capacity corresponding to the license.",
 * "timeToExpiration": 27,
 * "additionalMessage": [],
 * "licenseViolation": true,
 * "neededConfirmation": true,
 * "isInGracePeriod": true,
 * "hasDemoLicense": false
 * }
 * }
 */


public class AttackCapacityLicensePojo {

    private long lastCalculationDate;

    private int allowedAttackCapacityGbps;

    private int requiredDevicesAttackCapacityGbps;

    private List<String> licensedDeviceOrmidList;

    private boolean hasDemoLicense;

    private boolean licenseViolated;

    private boolean inGracePeriod;

    private boolean attackCapacityMaxLicenseExist;


    private String message;

    private int timeToExpiration;

    private List<String> additionalMessage;

    private boolean licenseViolation;
    private boolean neededConfirmation;

    private boolean isInGracePeriod;

    public long getLastCalculationDate() {
        return lastCalculationDate;
    }

    public void setLastCalculationDate(long lastCalculationDate) {
        this.lastCalculationDate = lastCalculationDate;
    }

    public int getAllowedAttackCapacityGbps() {
        return allowedAttackCapacityGbps;
    }

    public void setAllowedAttackCapacityGbps(int allowedAttackCapacityGbps) {
        this.allowedAttackCapacityGbps = allowedAttackCapacityGbps;
    }

    public int getRequiredDevicesAttackCapacityGbps() {
        return requiredDevicesAttackCapacityGbps;
    }

    public void setRequiredDevicesAttackCapacityGbps(int requiredDevicesAttackCapacityGbps) {
        this.requiredDevicesAttackCapacityGbps = requiredDevicesAttackCapacityGbps;
    }

    public List<String> getLicensedDeviceOrmidList() {
        return licensedDeviceOrmidList;
    }

    public void setLicensedDeviceOrmidList(List<String> licensedDeviceOrmidList) {
        this.licensedDeviceOrmidList = licensedDeviceOrmidList;
    }

    public boolean isHasDemoLicense() {
        return hasDemoLicense;
    }

    public void setHasDemoLicense(boolean hasDemoLicense) {
        this.hasDemoLicense = hasDemoLicense;
    }

    public boolean isLicenseViolated() {
        return licenseViolated;
    }

    public void setLicenseViolated(boolean licenseViolated) {
        this.licenseViolated = licenseViolated;
    }

    public boolean isInGracePeriod() {
        return inGracePeriod;
    }

    public void setInGracePeriod(boolean inGracePeriod) {
        this.inGracePeriod = inGracePeriod;
    }

    public boolean getIsInGracePeriod() {
        return isInGracePeriod;
    }

    public void setIsInGracePeriod(boolean isInGracePeriod) {
        this.isInGracePeriod = isInGracePeriod;
    }

    public boolean isAttackCapacityMaxLicenseExist() {
        return attackCapacityMaxLicenseExist;
    }

    public void setAttackCapacityMaxLicenseExist(boolean attackCapacityMaxLicenseExist) {
        this.attackCapacityMaxLicenseExist = attackCapacityMaxLicenseExist;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getTimeToExpiration() {
        return timeToExpiration;
    }

    public void setTimeToExpiration(int timeToExpiration) {
        this.timeToExpiration = timeToExpiration;
    }

    public List<String> getAdditionalMessage() {
        return additionalMessage;
    }

    public void setAdditionalMessage(List<String> additionalMessage) {
        this.additionalMessage = additionalMessage;
    }

    public boolean isLicenseViolation() {
        return licenseViolation;
    }

    public void setLicenseViolation(boolean licenseViolation) {
        this.licenseViolation = licenseViolation;
    }

    public boolean isNeededConfirmation() {
        return neededConfirmation;
    }

    public void setNeededConfirmation(boolean neededConfirmation) {
        this.neededConfirmation = neededConfirmation;
    }


}
