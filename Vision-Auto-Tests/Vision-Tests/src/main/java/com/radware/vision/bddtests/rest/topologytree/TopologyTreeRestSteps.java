package com.radware.vision.bddtests.rest.topologytree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.infra.testresthandlers.TopologyTreeRestHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.List;

public class TopologyTreeRestSteps extends BddRestTestBase {


    @Given("^REST Delete \"(.*)\" device with index (\\d+) from topology tree$")
    public void deleteDeviceByManagementIp(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            TopologyTreeRestHandler.deleteDeviceByManagementIp(restTestBase.getVisionRestClient(), deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Delete device: " + deviceIp, e);
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
     * @param request   Request from Properties file
     * @param deviceIp
     * @param newValue
     */
    @Then("^REST Update a scalar \"([^\"]*)\" value of Request \"([^\"]*)\" on the device Ip \"([^\"]*)\" with the new scalar value \"([^\"]*)\"$")
    public void restUpdateAScalarValueOfRequestOnTheDeviceIpWithTheNewScalarValue(String scalarName, String request, String deviceIp, String newValue) {

        TopologyTreeRestHandler.updateDeviceScalar(scalarName, request, deviceIp, newValue);

    }

}
