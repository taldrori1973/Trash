package com.radware.vision.thirdPartyAPIs.jFrog.models;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 2:58 PM
 */
public enum FileType {
    OVA(".*-D-\\d(.*)-(.*)-C-(.*).ova"),
    QCOW2(".*-D-\\d(.*)-(.*)-C-(.*).qcow2"),
    UPGRADE(".*-(.*)-D-\\d(.*)-(.*)-C-(.*).tar.gz"),
    //TODO still not supported
    OVA_BASIC("Vision-\\d(.*)_Basic.ova"),
    ODSVL2("Vision-\\d(.*)-usb-boot-ODSVL2-\\d(.*).tar.gz"),
    KVM("Vision-\\d(.*).KVM_\\d(.*)_prod.qcow2"),
    ISO_USB("APSoluteVision-USB-\\d(.*)-x86_64.iso "),
    ISO_SERIAL("APSoluteVision-Serial_console-\\d(.*)-x86_64.iso");

    private String extension;
    FileType(String extension) {
        this.extension = extension;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }
}
