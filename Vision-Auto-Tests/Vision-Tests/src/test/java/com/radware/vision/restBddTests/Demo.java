package com.radware.vision.restBddTests;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.databases.mariaDB.GenericCRUD;
import com.radware.vision.automation.databases.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.databases.mariaDB.client.VisionDBSchema;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTree;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTreeImpl;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import com.radware.vision.utils.BodyEntry;
import cucumber.api.java.en.Then;

import java.sql.SQLException;
import java.util.*;

public class Demo extends TestBase {
    @Then("^Send request$")
    public void sendRequest() throws NoSuchFieldException {
//        CurrentVisionRestAPI genericVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemConfigItemList.json", "Get Local Users");
//
//        RestResponse response = genericVisionRestAPI.sendRequest();
//        System.out.println();
//
//        VisionConfigurations visionConfigurations = new VisionConfigurations();
//        VisionConfigurations.getBuild();

    }


    @Then("^MariaDb Test$")
    public void mariaDbTest() throws SQLException, JDBCConnectionException {
        try {
//        Insert New Record to licenses table
            //                Insert Map
            LinkedHashMap<String, Object> record = new LinkedHashMap<>();
            record.put("row_id", "8a7480a771e6ee660171e6f16df80111");
            record.put("ormversion", 1);
            record.put("name", null);
            record.put("description", "TEST Maria DB");
            record.put("license_str", "vision-activation-maria");
            record.put("product_name", "vision");
            record.put("feature_name", "vision maria");
            record.put("license_activation_date", "2020-05-13 00:25:14");
            record.put("is_expired", false);

            int i = GenericCRUD.insertRecord(VisionDBSchema.VISION_NG, "vision_license", record);

            System.out.println("\n number of records inserted : " + i);

//          Get the record inserted
            JsonNode jsonNode = GenericCRUD.selectTable(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'");
            System.out.println("\n The new record is :\n" + jsonNode.toPrettyString());


//            Update is expired
            int updateNumber = GenericCRUD.updateSingleValue(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'", "is_expired", true);
            System.out.println("\n number of records updated : " + updateNumber);
            JsonNode jsonNode2 = GenericCRUD.selectTable(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'", "feature_name", "is_expired");

            System.out.println("\n The feature_name and is_expired after updated  :\n" + jsonNode2.toPrettyString());


//            Update Multiple

            Map<String, Object> mapOfUpdates = new HashMap<>();
            mapOfUpdates.put("is_expired", false);
            mapOfUpdates.put("description", "This is Updated Value");
            int multiUpdate = GenericCRUD.updateGroupOfValues(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'", mapOfUpdates);
            System.out.println("\n number of records updated : " + multiUpdate);
            JsonNode jsonNode3 = GenericCRUD.selectTable(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'");

            System.out.println("\n Record After Update :\n" + jsonNode3.toPrettyString());


//            Select One Value
            String description = GenericCRUD.selectSingleValue(VisionDBSchema.VISION_NG, "description", "vision_license", "license_str='vision-activation-maria'");
            System.out.println("\nThe Description Value Is: " + description);

//          Select All Table
            JsonNode allTable = GenericCRUD.selectAllTable(VisionDBSchema.VISION_NG, "vision_license");
            System.out.println("\nAll Table: \n" + allTable.toPrettyString());


//           Delete the new added record

            int deleted = GenericCRUD.deleteRecords(VisionDBSchema.VISION_NG, "vision_license", "license_str='vision-activation-maria'");

            System.out.println("\n number of records Deleted : " + deleted);

            //          Select All Table after delete
            allTable = GenericCRUD.selectAllTable(VisionDBSchema.VISION_NG, "vision_license");
            System.out.println("\nAll Table after delete: \n" + allTable.toPrettyString());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }


    }

    @Then("^SUT Test$")
    public void sutTest() throws Exception {
        TopologyTree topologyTree = new TopologyTreeImpl();

        RestStepResult result = topologyTree.addDevice("Alteon_Set_1");

        List<BodyEntry> bodyEntries = new ArrayList<>();
        bodyEntries.add(new BodyEntry("$.deviceSetup.deviceAccess.cliPassword", "1456"));
        bodyEntries.add(new BodyEntry("$.deviceSetup.deviceAccess.httpUsername", "httpUsername"));
        bodyEntries.add(new BodyEntry("$.deviceSetup.deviceAccess.snmpV2ReadCommunity", "snmpV2ReadCommunity"));
        bodyEntries.add(new BodyEntry("$.name", "alteon"));

        topologyTree.updateDevice("Alteon_Set_1", bodyEntries);

        topologyTree.deleteDevice("Alteon_Set_1");
//        RestStepResult result = topologyTree.deleteSite("aaa");
//        if (result.getStatus().equals(RestStepResult.Status.FAILED))
//            BaseTestUtils.report(result.getMessage(), Reporter.FAIL);
//        try {

//            System.out.println(topologyTree.getSiteOrmId("Default"));
//            System.out.println(topologyTree.getSiteOrmId("AW_site"));
//            System.out.println(topologyTree.getSiteOrmId("AW_si"));
//            System.out.println(topologyTree.getSiteOrmId("AW_site"));
//        } catch (Exception e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }


//        get device management
//        SUTManager sutManager = TestBase.getSutManager();
//        Optional<TreeDeviceManagementDto> deviceManagementOpt = sutManager.getTreeDeviceManagement("Alteon_Set_1");
//        if (!deviceManagementOpt.isPresent())
//            BaseTestUtils.report(String.format("No Device with \"%s\" Set ID was found in this setup", "Alteon_Set_1"), Reporter.FAIL);
//        TreeDeviceManagementDto deviceManagementDto = deviceManagementOpt.get();
//
////      get json of the device using the deviceId from device management
//        Optional<JsonNode> alteonRequestBodyAsJson = sutManager.getAddTreeDeviceRequestBodyAsJson(deviceManagementDto.getDeviceId());
//        if (!alteonRequestBodyAsJson.isPresent()) throw new Exception("");
//        ObjectNode alteonRequestBody = (ObjectNode) alteonRequestBodyAsJson.get();
//
////        get parentOrmId
////          return the device parent site name
//        String deviceParentSite = sutManager.getDeviceParentSite(deviceManagementDto.getDeviceId());
//
//        // now send Rest Request to topology tree and extract the ormId of the site by site name
//
////        lets assume that the parentOrmId is 123
//
//        alteonRequestBody.put("parentOrmID", "123");
//        String asString = alteonRequestBody.toString();
//        System.out.println(asString);
////        Optional<LinuxFileServer> linuxFileServerOpt = serversManagement.getLinuxFileServer();
////        LinuxFileServer linuxFileServer = null;
////        if (linuxFileServerOpt.isPresent()) {
////            linuxFileServer = linuxFileServerOpt.get();
////        }
////        try {
////            assert linuxFileServer != null;
////            InvokeUtils.invokeCommand(null, "ls", linuxFileServer, 60 * 1000);
////            updateLastOutput(linuxFileServer);
////        } catch (Exception e) {
////            BaseTestUtils.report("Failed to run the command:   With the following exception: " + e.getMessage(), Reporter.FAIL);
////        }


    }

    private static void updateLastOutput(ServerCliBase cliBase) {
        CliOperations.lastOutput = cliBase.getTestAgainstObject() != null ? cliBase.getTestAgainstObject().toString() : "";
        CliOperations.resultLines = cliBase.getCmdOutput();
        CliOperations.lastRow = cliBase.getLastRow();


    }

    @Then("^Validate pojo Paesing$")
    public void validatePojoPaesing() throws JsonProcessingException {
        try {
            JFrogFileModel build = JFrogAPI.getBuild(FileType.OVA, "kvision-images-snapshot-local", null, null, 0);
            System.out.println(build);
            JFrogFileModel build2 = JFrogAPI.getBuild(FileType.OVA, "kvision-images-release-local", null, null, 0);
            System.out.println(build2);
            JFrogFileModel build3 = JFrogAPI.getBuild(FileType.OVA, "kvision-images-release-local", null, "release", 0);
            System.out.println(build3);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(),Reporter.FAIL);
        }


    }
}
