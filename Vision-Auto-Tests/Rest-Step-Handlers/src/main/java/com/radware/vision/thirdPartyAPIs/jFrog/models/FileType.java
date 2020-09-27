package com.radware.vision.thirdPartyAPIs.jFrog.models;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 2:58 PM
 */
public enum FileType {
//    OVA("ova"),
    OVA("Vision-\\d(.*)_prod.ova"),
    OVA_APM("Vision-with-APM-\\d(.*)_prod.ova"),
    UPGRADE("Upgrade_Vision-\\d(.*).upgrade"),
    UPGRADE_APM("Upgrade_Vision-with-APM-\\d(.*).upgrade"),
    ODSVL2("Vision-\\d(.*)-usb-boot-ODSVL2-\\d(.*).tar.gz"),
    KVM("Vision-\\d(.*).KVM_\\d(.*)_prod.qcow2"),
    KVM_APM("Vision-with-APM-\\d(.*).KVM_\\d(.*)_prod.qcow2"),
    ISO_USB("APSoluteVision-USB-\\d(.*)-x86_64.iso "),
    ISO_SERIAL("APSoluteVision-Serial_console-\\d(.*)-x86_64.iso");

    private String extension;
    private String fileName;
    FileType(String extension) {
        this.extension = extension;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public String getFileName() {
        return fileName;
    }

}
