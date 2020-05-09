package com.radware.vision.restBddTests;

import com.radware.vision.RestStepResult;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTree;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTreeImpl;
import com.radware.vision.infra.visionDatabase.jdbc.vision_ng_schema.daos.VisionLicenseDao;
import com.radware.vision.infra.visionDatabase.jdbc.vision_ng_schema.entities.VisionLicense;
import com.radware.vision.utils.BodyEntry;
import cucumber.api.java.en.Then;

import java.util.ArrayList;
import java.util.List;

public class Demo extends BddRestTestBase {
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
    public void mariaDbTest() throws Exception {
//        JDBCConnectionSingleton jdbcConnectionSingleton=JDBCConnectionSingleton.getInstance();
//        Connection dbConnection = jdbcConnectionSingleton.getDBConnection(VisionDBSchema.VISION_NG);

        VisionLicenseDao visionLicenseDao=new VisionLicenseDao();
        List<VisionLicense> all = visionLicenseDao.getAll();
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
}
