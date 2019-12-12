package com.radware.vision.infra.enums.controlbaritems;

import com.radware.vision.infra.enums.DeviceType4Group;
import com.radware.vision.infra.enums.enumsutils.Element;
import com.radware.vision.infra.enums.enumsutils.EnumsUtils;

public class Utils {


    public static Element getEnumInstanceForDeviceControlBarItem(DeviceType4Group deviceType, String item) {

        String deviceTypeAsString = deviceType.getDeviceType();
        switch (deviceTypeAsString) {

            case "Alteon":
            case "LinkProof NG":
                return EnumsUtils.getEnumByElementName(AlteonAndLinkProofNG.class, item);
            case "AppWall":
                return EnumsUtils.getEnumByElementName(AppWall.class, item);
            case "DefensePro":
                return EnumsUtils.getEnumByElementName(DefensePro.class, item);

        }

        return null;
    }

    public static Class<? extends Enum<? extends Element>> getDeviceClass(DeviceType4Group deviceType) {

        String device = deviceType.getDeviceType();
        switch (device) {
            case "Alteon":
            case "LinkProof NG":
                return AlteonAndLinkProofNG.class;
            case "AppWall":
                return AppWall.class;
            case "DefensePro":
        }
        return DefensePro.class;
    }
}
