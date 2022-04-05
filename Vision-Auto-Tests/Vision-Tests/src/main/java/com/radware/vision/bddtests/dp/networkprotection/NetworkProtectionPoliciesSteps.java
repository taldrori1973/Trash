package com.radware.vision.bddtests.dp.networkprotection;


import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.networkprotection.NetworkProtectionPoliciesHandler;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.networkprotection.NetworkProtectionPoliciesHandler.Direction;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.networkprotection.NetworkProtectionPoliciesHandler.Status;
import com.radware.vision.infra.testhandlers.dptemplates.enums.PolicyAction;
import com.radware.vision.infra.testhandlers.dptemplates.enums.PolicyWebQuarantine;
import cucumber.api.java.en.And;


public class NetworkProtectionPoliciesSteps extends DpNTestBase {


    public NetworkProtectionPoliciesSteps() throws Exception {
    }

    @And("^UI Create network Policy with deviceType \"([^\"]*)\" and deviceIndex (\\d+) and policyName \"([^\"]*)\" and PolicyStatus \"([^\"]*)\" and Direction \"([^\"]*)\" and Action \"([^\"]*)\"$")
    public void createNetworkPolicy(String deviceType,int deviceIndex, String policyName, String policyStatus, Direction direction, PolicyAction Action) throws Exception {

        SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(deviceType);
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, deviceIndex);
        try {
            NetworkProtectionPoliciesHandler.createNetworkPolicy(deviceInfo.getDeviceName(),policyName,policyStatus,"","","",direction,"",
                    "", "", "", "", "", "", "",
                    "", "", Action, Status.Disable, Status.Disable, Status.Disable, Status.Disable, PolicyWebQuarantine.DISABLE, dpUtils);
        } catch (Exception e) {}
    }

    }
