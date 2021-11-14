package com.radware.vision.bddtests.rest.topologytree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testresthandlers.TopologyTreeRestHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.apache.tools.ant.taskdefs.Sleep;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static models.config.DevicesConstants.*;

public class TopologyTreeRestSteps extends TestBase {


    @Given("^REST Delete device (\\w+) from topology tree$")
    public void deleteDeviceByManagementIp(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            TopologyTreeRestHandler.deleteDeviceByManagementIp(restTestBase.getVisionRestClient(), deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Delete device: " + deviceIp, e);
        }
    }

    @Then("^REST Delete device with SetID \"(\\w+)\" from topology tree$")
    public void deleteDeviceBySetID(String setID) {
        String deviceIp = "";
        try {
            deviceIp = TestBase.getSutManager().getTreeDeviceManagement(setID).get().getManagementIp();
            TopologyTreeRestHandler.deleteDeviceByManagementIp(restTestBase.getVisionRestClient(), deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Delete device: " + deviceIp, e);
        }
    }

    @Then("^REST Add Simulators$")
    public void addSimulators() {
        List<TreeDeviceManagementDto> simulators = sutManager.getSimulators();
        if (simulators.isEmpty()) {
            BaseTestUtils.report("No Alteon simulators available, please add set to SUT.", Reporter.FAIL);
        }
        try {
            simulators.forEach(sim -> {
                String setId = sim.getDeviceSetId();
                String parentSite = TestBase.getSutManager().getDeviceParentSite(sim.getDeviceId());
                this.restAddDeviceToTopologyTreeWithAndManagementIPWithOptionalValues(setId, parentSite);
            });
            //Todo: KVISION delete this WA when applications issue fixed (sleep added to wait until all simulators are connected)
            Thread.sleep(60* 1000);
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "docker restart config_kvision-configuration-service_1");
        } catch (Exception e) {
            BaseTestUtils.report("Failed to add Alteon simulators " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^REST Delete Simulators$")
    public void deleteSimulators() {
        List<TreeDeviceManagementDto> simulators = sutManager.getSimulators();
        if (simulators.isEmpty()) {
            BaseTestUtils.report("No Alteon simulators available, please add set to SUT.", Reporter.FAIL);
        }
        try {
            simulators.forEach(sim -> {
                this.restDeleteDeviceByIP(sim.getDeviceName());
            });
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete Alteon simulators " + e.getMessage(), Reporter.FAIL);
        }
    }


    /**
     * Should Login with Rest API Before Using this step
     *
     * @param type      Device Type : DEFENSE_PRO | ALTEON | LINKPROOF | AppWall
     * @param name      Device Name
     * @param ip        Device management Ip
     * @param site      The Name of the Parent Folder (should be already exist).
     * @param dataTable this is optional for set non default values of the following attributes
     *                  cliPassword="admin"
     *                  cliPort="22"
     *                  cliUsername="admin"
     *                  exclusivelyReceiveDeviceEvents="false"
     *                  httpPassword="admin"
     *                  httpsPassword="admin"
     *                  httpsUsername="admin"
     *                  httpUsername="admin"
     *                  registerDeviceEvents="true"
     *                  snmpV1ReadCommunity="public"
     *                  snmpV1WriteCommunity="private"
     *                  snmpV2ReadCommunity="public"
     *                  snmpV2WriteCommunity="private"
     *                  snmpV3AuthenticationProtocol="SHA"
     *                  snmpV3PrivacyProtocol="DES"
     *                  snmpVersion="SNMP_V2"
     *                  verifyHttpCredentials="true"
     *                  verifyHttpsCredentials="true"
     *                  `   visionMgtPort="G1"
     * @Example :
     * Then REST Add "Alteon" Device To topology Tree with Name "Alteon101" and Management IP "50.50.101.35" into site "Default"
     * | attribute     | value    |
     * | visionMgtPort | G2       |
     * | httpPassword  | radware1 |
     * | httpsPassword | radware1 |
     */

    @Then("^REST Add \"(.*)\" Device To topology Tree with Name \"(.*)\" and Management IP \"(.*)\" into site \"(.*)\"$")
    public void restAddDeviceToTopologyTreeWithAndManagementIPWithOptionalValues(String type, String name, String ip, String site, List<TopologyTreeRestHandler.Data> dataTable) {
        TopologyTreeRestHandler.addDeviceToTopologyTree(type, name, ip, site, dataTable);
    }

    @Then("^REST Add device with (SetId|DeviceID) \"(.*?)\"(?: into site \"(.*)\")?$")
    public void restAddDeviceToTopologyTreeWithAndManagementIPWithOptionalValues(String idType, String id, String site) {
        TreeDeviceManagementDto device =
                        (idType.equals("SetId"))?TestBase.getSutManager().getTreeDeviceManagement(id).get():
                        (idType.equals("DeviceID"))?TestBase.getSutManager().getTreeDeviceManagementFromDevices(id).get():null;
        String type = device.getDeviceType();
        String name = device.getDeviceName();
        String ip = device.getManagementIp();
        if (site == null) site = TestBase.getSutManager().getDeviceParentSite(device.getDeviceId());

        List<TopologyTreeRestHandler.Data> dataTable = new ArrayList<>();

        for (Map.Entry<String, String> entry : device.getDeviceSetupData().entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            if (value != null && !value.equals(""))
                dataTable.add(new TopologyTreeRestHandler.DataAdapter(key, value));
        }

        TopologyTreeRestHandler.addDeviceToTopologyTree(type, name, ip, (site!=null)?site:"Default", dataTable);
    }

    @Then("^REST Add \"(.*)\" site To topology Tree under \"(.*)\" site$")
    public void restAddSiteToTopologyTree(String site, String name) {
        TopologyTreeRestHandler.addSiteToTopologyTree(site, name);
    }

    /**
     * Should Login with Rest API Before Using this step
     *
     * @param deviceIp Device management Ip
     */
    @Then("^REST Delete Device By IP \"([^\"]*)\"$")
    public void restDeleteDeviceByIP(String deviceIp) {
        TopologyTreeRestHandler.deleteDeviceByIp(restTestBase.getVisionRestClient(), deviceIp);
    }


    /**
     * @param scalarName scalar Name to update , see the List
     *                   name
     *                   managementIp
     *                   type
     *                   cliPassword
     *                   cliPort
     *                   cliUsername
     *                   exclusivelyReceiveDeviceEvents
     *                   httpPassword
     *                   httpsPassword
     *                   httpsUsername
     *                   httpUsername
     *                   registerDeviceEvents
     *                   snmpV1ReadCommunity
     *                   snmpV1WriteCommunity
     *                   snmpV2ReadCommunity
     *                   snmpV2WriteCommunity
     *                   snmpV3AuthenticationProtocol
     *                   snmpV3PrivacyProtocol
     *                   snmpVersion
     *                   verifyHttpCredentials
     *                   verifyHttpsCredentials
     *                   visionMgtPort
     * @param request    Request from Properties file
     * @param deviceIp
     * @param newValue
     */
    @Then("^REST Update a scalar \"([^\"]*)\" value of Request \"([^\"]*)\" on the device Ip \"([^\"]*)\" with the new scalar value \"([^\"]*)\"$")
    public void restUpdateAScalarValueOfRequestOnTheDeviceIpWithTheNewScalarValue(String scalarName, String request, String deviceIp, String newValue) {

        TopologyTreeRestHandler.updateDeviceScalar(scalarName, request, deviceIp, newValue);

    }

}
