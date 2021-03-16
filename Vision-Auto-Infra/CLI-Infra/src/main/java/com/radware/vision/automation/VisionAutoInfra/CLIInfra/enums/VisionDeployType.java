package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

public enum VisionDeployType {
    ISO("APSoluteVision-%s-%s-x86_64.iso"),
    ISO_SERIAL("APSoluteVision-Serial_console-%s-%s-x86_64.iso"),
    ISO_USB("APSoluteVision-USB-%s-%s-x86_64.iso "),
    KVM("Vision-%s.KVM_%s_prod.qcow2"),
    KVM_APM("Vision-with-APM-%s.KVM_%s_prod.qcow2"),
    ODSVL2("Vision-%s-usb-boot-ODSVL2-%s.tar.gz"),
    UPGRADE("Upgrade_Vision-%s_and_later-%s-%s.upgrade"), //APSoluteVision-4.XX.00-518-x86_64.iso
    UPGRADE_APM("Upgrade_Vision-with-APM-%s_and_later-%s-%s.upgrade"),
    VM("Vision-%s.VMware_%s_prod.ova"),
    VM_APM("Vision-with-APM-%s.VMware_%s_prod.ova"),
    ANY("any");

    private String visionDeployType;

    VisionDeployType(String visionDeployType) {
        this.visionDeployType = visionDeployType;
    }
            public String getVisionDeployType() {
            return this.visionDeployType;
        }

}
