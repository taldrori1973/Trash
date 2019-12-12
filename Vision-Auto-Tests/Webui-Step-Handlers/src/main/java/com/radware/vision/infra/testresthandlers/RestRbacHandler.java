package com.radware.vision.infra.testresthandlers;

import basejunit.RestTestBase;
import com.radware.automation.tools.utils.ValidationUtils;
import com.radware.insite.model.dto.tree.ThinDeviceTransformerDTO;
import com.radware.novis.dp.model.common.GeneralRequest;
import com.radware.novis.dp.model.common.ReportScope;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.DeviceType;
import com.radware.utils.DeviceUtils;
import com.radware.utils.TreeUtils;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.utils.device.alteon.AlteonOperationsUtils;
import com.radware.utils.device.appwall.AppWallOperationsUtils;
import com.radware.utils.device.dp.DpOperationsUtils;
import com.radware.utils.scheduler.ScheduledTasksUtils;
import com.radware.utils.templates.TemplatesUtils;
import com.radware.utils.vision.dashboards.dashboards.DashboardsUtils;
import com.radware.vision.automation.tools.exceptions.restapi.HttpSessionNotFoundException;
import testhandlers.Device;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import static com.radware.restcore.utils.enums.DeviceType.Alteon;
import static com.radware.restcore.utils.enums.DeviceType.DefensePro;
import static com.radware.restcore.utils.enums.HttpMethodEnum.GET;
import static com.radware.restcore.utils.enums.HttpMethodEnum.POST;

public class RestRbacHandler {


    public static String validateRbacOperation(String operation, String access) throws IOException, HttpSessionNotFoundException {

        VisionRestClient visionRestClient = RestTestBase.visionRestClient;

        visionRestClient.setIgnoreResponseCodeValidation(true);

        boolean actionResult = true;
        String errorMessage = "";
        operation = operation.toUpperCase();

        ThinDeviceTransformerDTO device = null;
        switch (operation) {


            case "ADD/EDIT DEVICE":

                Map<String, String> jsonBody = new HashMap();
                jsonBody.put("ip", "1.1.1.1");
                jsonBody.put("type", "Alteon");

                Device.addDevice(visionRestClient, null, "1.1.1.1", Alteon, jsonBody);
                Device.updateDevice(visionRestClient, "1.1.1.1", "Alteon", null);
                Device.deleteDeviceByName(visionRestClient, "Alteon");

                break;

            case "LOCK DEVICE":
                device = DeviceUtils.getDeviceByType(visionRestClient, DeviceType.Alteon);
                DeviceUtils.lockCommand(visionRestClient, device.getManagementIp());
                DeviceUtils.unlockCommand(visionRestClient, device.getManagementIp());


                break;

            case "CONFIGURATION PERSPECTIVE":

                device = DeviceUtils.getDeviceByType(visionRestClient, DefensePro);
                if (device != null) {
                    DeviceScalarUtils.getScalarValueByKey(visionRestClient, device.getManagementIp(), "rsWSDSyslogGlobalStatus");

                } else return "could not found device in the tree of type DefensePro";


                break;


            case "MONITORING PERSPECTIVE":

                device = DeviceUtils.getDeviceByType(visionRestClient, DefensePro);
                if (device != null) {
                    visionRestClient.runBasicRestRequest(GET, "/mgmt/device/byip/".concat(device.getManagementIp()).
                            concat("/monitor/dot3adAggPortTable?"), "");
                } else return "could not found device in the tree of type DefensePro";

                break;


            case "SECURITY MONITORING PERSPECTIVE":

                device = DeviceUtils.getDeviceByType(visionRestClient, DefensePro);
                if (device != null) {
                    //Build the request body
                    GeneralRequest generalRequest = new GeneralRequest();
                    ReportScope reportScope = new ReportScope();
                    reportScope.setDevices(Arrays.asList(DeviceUtils.getDeviceOrmid(visionRestClient, device.getName())));
                    reportScope.setRange(8600L);
                    generalRequest.setReportScope(reportScope);
                    //session id required
                    try {
                        visionRestClient.getHttpSession().setJsessionidRH(true);
                    } catch (HttpSessionNotFoundException e) {
//                        Ignore
                    }

                    visionRestClient.securityMonitoringCommands.dpDashboardCommands.getAttacksCommand("{  \n" +
                            "   \"reportScope\":{  \n" +
                            "      \"range\":86400,\n" +
                            "      \"devices\":[  \n" +
                            "         \"2c91238461995daa0161b29fde8600d4\"\n" +
                            "      ],\n" +
                            "      \n" +
                            "      \"policies\":[  \n" +
                            "\n" +
                            "      ]\n" +
                            "   }\n" +
                            "}");

                } else return "could not found device in the tree of type DefensePro";
                break;
            case "DPM":

                visionRestClient.runBasicRestRequest(GET, "/mgmt/applications/dpm?validate",
                        "");
                break;

            case "VISION SETTINGS - DEVICE RESOURCE":

                visionRestClient.mgmtCommands.visionCommands.getDeviceBackups();


                break;

            case "ALERT BROWSER":
                visionRestClient.mgmtCommands.visionCommands.getAlerts();
                break;


            case "SCHEDULER":
                ScheduledTasksUtils.getScheduledTasks(visionRestClient);
                break;


            case "OPERATOR TOOLBOX":
                visionRestClient.mgmtCommands.visionCommands.getToolboxScripts("?assigntodashboard=true");
                break;

            case "LOAD NEW APPSHAPE":

                device = DeviceUtils.getDeviceByType(visionRestClient, DeviceType.Alteon);
                if (device != null) {
                    DeviceUtils.lockCommand(visionRestClient, device.getManagementIp());
                    //add app shape
                    visionRestClient.runBasicRestRequest(POST, "/mgmt/appshape/instances",
                            "{\n" +
                                    "\"Info\": [\n" +
                                    "{\n" +
                                    "\"device\":\"172.17.163.7\",\n" +
                                    "\"name\":\"aaaa\",\n" +
                                    "\"type\":\"Common_Web_Application\"\n" +
                                    "} \n" +
                                    "], \n" +
                                    "\"Parameters\": [\n" +
                                    "{\n" +
                                    "\"name\":\"aaaa\",\n" +
                                    "\"lastSynchDate\":\"\",\n" +
                                    "\"isValid\":false,\n" +
                                    "\"vipAddress\":\"1.1.1.1\",\n" +
                                    "\"virtId\":\"\",\n" +
                                    "\"slbMetric\":\"roundrobin\",\n" +
                                    "\"healthCheck\":\"tcp\",\n" +
                                    "\"cacheId\":\"\",\n" +
                                    "\"isCaching\":true,\n" +
                                    "\"comppolId\":\"\",\n" +
                                    "\"isCompression\":true,\n" +
                                    "\"isConnectionMng\":false,\n" +
                                    "\"sslId\":\"\",\n" +
                                    "\"isSsl\":false,\n" +
                                    "\"certId\":\"\",\n" +
                                    "\"realServers\": [\n" +
                                    "{\n" +
                                    "\"address\":\"2.2.2.2\",\n" +
                                    "\"rport\":80\n" +
                                    "} \n" +
                                    "] \n" +
                                    "} \n" +
                                    "] \n" +
                                    "}");


                    visionRestClient.deleteCommand("/mgmt/appshape/instances/aaaa", true);
                } else return "could not found device in the tree of type Alteon";
                break;


            case "DP TEMPLATES":

                TemplatesUtils.getTemplates(visionRestClient);

                break;
            case "PHYSICAL TAB":
                TreeUtils.getPhysicalTree(visionRestClient);
                break;

            case "DP OPERATIONS":
                device = DeviceUtils.getDeviceByType(visionRestClient, DeviceType.DefensePro);
                if (device != null) {
                    DeviceUtils.lockCommand(visionRestClient, device.getManagementIp());
                    DpOperationsUtils.updateDpPolices(visionRestClient, device.getManagementIp());
                } else return "could not found device in the tree of type DefensePro";


                break;
            case "ALTEON OPERATIONS":
                device = DeviceUtils.getDeviceByType(visionRestClient, DeviceType.Alteon);
                if (device != null) {
                    DeviceUtils.lockCommand(visionRestClient, device.getManagementIp());
                    AlteonOperationsUtils.apply(visionRestClient, device.getManagementIp());
                } else return "could not found device in the tree of type Alteon";


                break;
            case "APPWALL OPERATIONS":
                device = DeviceUtils.getDeviceByType(visionRestClient, DeviceType.Alteon);
                if (device != null) {
                    DeviceUtils.lockCommand(visionRestClient, device.getManagementIp());
                    AppWallOperationsUtils.apply(visionRestClient, device.getManagementIp());
                } else {
                    return "could not found device in the tree of type AppWall";
                }

                break;


            case "SECURITY CONTROL CENTER":

                DashboardsUtils.SecurityControlCenter.getDefensePro(visionRestClient);


                break;


            case "APP SLA DASHBOARD":

                break;


            case "AMS":
                BasicRestOperationsHandler.visionRestApiRequest(visionRestClient, POST, "VRMReporter->reports-ext->DP_ATTACK_REPORTS");
                break;


            case "ADC":
                BasicRestOperationsHandler.visionRestApiRequest(visionRestClient, POST, "DPM_Dashboard->ADC_MONITORING_LATEST_REPORTS");
                break;

            default:
                return "";

        }


        actionResult = visionRestClient.getLastHttpStatusCode() == 200 ? true : false;


        //unlock device in case it's locked
        if (device != null) {
            DeviceUtils.unlockCommand(visionRestClient, device.getManagementIp());
        }


        if (!ValidationUtils.checkIfMatches(actionResult, access))
            return operation.concat(" Failed ");

        else return "";
    }


}
