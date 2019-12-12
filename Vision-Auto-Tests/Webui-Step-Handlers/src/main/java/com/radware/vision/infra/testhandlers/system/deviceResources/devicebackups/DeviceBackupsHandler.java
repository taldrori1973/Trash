package com.radware.vision.infra.testhandlers.system.deviceResources.devicebackups;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.deviceresources.DeviceResources;
import com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups;

/**
 * Created by stanislava on 4/21/2015.
 */
public class DeviceBackupsHandler {

    public static void downloadSelectedFile(String fileName, String columnName) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        DeviceResources deviceResources = menuPane.openSystemDeviceResources();
        com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups deviceBackups = deviceResources.deviceBackupsMenu();
        WebUITable table = deviceBackups.getDeviceBackupsTable();
        //table.setWaitForTableToLoad(false);
        //table.analyzeTable("span");
        if (fileName != null && !fileName.equals("")) {
            table.clickRowByKeyValue(columnName, fileName);
            deviceBackups.downloadSelectedFileClick();
        }
    }

    public static void deleteDeviceBackups(){
        DeviceBackups deviceBackups = openDeviceBackupMenu();
        WebUITable table = deviceBackups.getDeviceBackupsTable();
        table.deleteAll();
    }

    private static DeviceBackups openDeviceBackupMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemDeviceResources().deviceBackupsMenu();
    }
}
