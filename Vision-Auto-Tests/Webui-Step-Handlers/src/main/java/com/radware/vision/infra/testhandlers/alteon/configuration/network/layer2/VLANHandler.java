package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2;

import com.radware.automation.webui.webpages.configuration.network.layer2.vlan.Vlan;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/11/2015.
 */
public class VLANHandler extends BaseHandler {

    public static void addVLAN(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Vlan vlan = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mVlan();
        vlan.openPage();
        vlan.addVLAN();
        if (testProperties.get("VLANState").equals("Enable")){vlan.enableVLAN();}
        if (testProperties.get("VLANState").equals("Disable")){vlan.disableVLAN();}
        vlan.setVLANId(testProperties.get("VLANId"));
        vlan.setVlanName(testProperties.get("VLANName"));
        vlan.selectVLANSettingTab();
        if (testProperties.get("VLANPorts") != null || !testProperties.get("VLANPorts").equals("")){
            vlan.selectPorts(testProperties.get("VLANPorts"));
        }
        vlan.selectIPv6LinkLocalAddressGeneration(testProperties.get("IPv6LinkLocalAddressGenerationState"));
        vlan.setIPv6LinkLocalAddress(testProperties.get("IPv6LinkLocalAddress"));
        vlan.setSpanningTreeGroup(testProperties.get("SpanningTreeGroup"));
        vlan.selectSourceMacLearning(testProperties.get("SourceMACLearning"));
        vlan.setTrafficContract(testProperties.get("TrafficContract"));
        vlan.selectIPv6NeighborDiscoveryTab();
        vlan.selectRouterAdvertisement(testProperties.get("RouterAdvertisement"));
        vlan.setRetransmissionInterval(testProperties.get("RetransmissionInterval"));
        vlan.setMinInterval(testProperties.get("MinIntervalRouterAdvertisements"));
        vlan.setMaxInterval(testProperties.get("MaxIntervalRouterAdvertisements"));
        vlan.setMTU(testProperties.get("MTU"));
        vlan.setCurrentHopLimit(testProperties.get("CurrentHopLimit"));
        vlan.selectManagedAddress(testProperties.get("ManagedAddressConfigurationFlag"));
        vlan.selectOtherAddress(testProperties.get("OtherAddressConfigurationFlag"));
        vlan.setReachableTime(testProperties.get("ReachableTime"));
        vlan.setLifeTime(testProperties.get("LifeTime"));
        vlan.setPreferredTime(testProperties.get("PreferredLifeTime"));
        vlan.setValidTime(testProperties.get("ValidLifeTime"));
        vlan.selectOnLink(testProperties.get("OnLinkFlagInPrefixState"));
        vlan.selectAutonomousAddress(testProperties.get("AutonomousAddressPrefixState"));
        vlan.submit();

    }



    public static void editVLAN(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Vlan vlan = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mVlan();
        vlan.openPage();
        vlan.editVLAN(testProperties.get("rowNumber"));
        if (testProperties.get("VLANState").equals("Enable")){vlan.enableVLAN();}
        if (testProperties.get("VLANState").equals("Disable")){vlan.disableVLAN();}
        vlan.setVlanName(testProperties.get("VLANName"));
        vlan.selectVLANSettingTab();
        if (testProperties.get("UnSelectPorts") != null ||!testProperties.get("UnSelectPorts").equals("")){
            vlan.unSelectPorts(testProperties.get("UnSelectPorts"));
        }
        if (testProperties.get("VLANPorts") != null || !testProperties.get("VLANPorts").equals("")){
            vlan.selectPorts(testProperties.get("VLANPorts"));
        }
        vlan.selectIPv6LinkLocalAddressGeneration(testProperties.get("IPv6LinkLocalAddressGenerationState"));
        vlan.setIPv6LinkLocalAddress(testProperties.get("IPv6LinkLocalAddress"));
        vlan.setSpanningTreeGroup(testProperties.get("SpanningTreeGroup"));
        vlan.selectSourceMacLearning(testProperties.get("SourceMACLearning"));
        vlan.setTrafficContract(testProperties.get("TrafficContract"));
        vlan.selectIPv6NeighborDiscoveryTab();
        vlan.selectRouterAdvertisement(testProperties.get("RouterAdvertisement"));
        vlan.setRetransmissionInterval(testProperties.get("RetransmissionInterval"));
        vlan.setMinInterval(testProperties.get("MinIntervalRouterAdvertisements"));
        vlan.setMaxInterval(testProperties.get("MaxIntervalRouterAdvertisements"));
        vlan.setMTU(testProperties.get("MTU"));
        vlan.setCurrentHopLimit(testProperties.get("CurrentHopLimit"));
        vlan.selectManagedAddress(testProperties.get("ManagedAddressConfigurationFlag"));
        vlan.selectOtherAddress(testProperties.get("OtherAddressConfigurationFlag"));
        vlan.setReachableTime(testProperties.get("ReachableTime"));
        vlan.setLifeTime(testProperties.get("LifeTime"));
        vlan.setPreferredTime(testProperties.get("PreferredLifeTime"));
        vlan.setValidTime(testProperties.get("ValidLifeTime"));
        vlan.selectOnLink(testProperties.get("OnLinkFlagInPrefixState"));
        vlan.selectAutonomousAddress(testProperties.get("AutonomousAddressPrefixState"));
        vlan.submit();

    }




    public static void duplicateVLAN(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Vlan vlan = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mVlan();
        vlan.openPage();
        vlan.duplicateVLAN(testProperties.get("rowNumber"));
        if (testProperties.get("VLANState").equals("Enable")){vlan.enableVLAN();}
        if (testProperties.get("VLANState").equals("Disable")){vlan.disableVLAN();}
        vlan.setVLANId(testProperties.get("VLANId"));
        vlan.setVlanName(testProperties.get("VLANName"));
        vlan.selectVLANSettingTab();
        if (testProperties.get("UnSelectPorts") != null ||!testProperties.get("UnSelectPorts").equals("")){
            vlan.unSelectPorts(testProperties.get("UnSelectPorts"));
        }
        if (testProperties.get("VLANPorts") != null || !testProperties.get("VLANPorts").equals("")){
            vlan.selectPorts(testProperties.get("VLANPorts"));
        }
        vlan.selectIPv6LinkLocalAddressGeneration(testProperties.get("IPv6LinkLocalAddressGenerationState"));
        vlan.setIPv6LinkLocalAddress(testProperties.get("IPv6LinkLocalAddress"));
        vlan.setSpanningTreeGroup(testProperties.get("SpanningTreeGroup"));
        vlan.selectSourceMacLearning(testProperties.get("SourceMACLearning"));
        vlan.setTrafficContract(testProperties.get("TrafficContract"));
        vlan.selectIPv6NeighborDiscoveryTab();
        vlan.selectRouterAdvertisement(testProperties.get("RouterAdvertisement"));
        vlan.setRetransmissionInterval(testProperties.get("RetransmissionInterval"));
        vlan.setMinInterval(testProperties.get("MinIntervalRouterAdvertisements"));
        vlan.setMaxInterval(testProperties.get("MaxIntervalRouterAdvertisements"));
        vlan.setMTU(testProperties.get("MTU"));
        vlan.setCurrentHopLimit(testProperties.get("CurrentHopLimit"));
        vlan.selectManagedAddress(testProperties.get("ManagedAddressConfigurationFlag"));
        vlan.selectOtherAddress(testProperties.get("OtherAddressConfigurationFlag"));
        vlan.setReachableTime(testProperties.get("ReachableTime"));
        vlan.setLifeTime(testProperties.get("LifeTime"));
        vlan.setPreferredTime(testProperties.get("PreferredLifeTime"));
        vlan.setValidTime(testProperties.get("ValidLifeTime"));
        vlan.selectOnLink(testProperties.get("OnLinkFlagInPrefixState"));
        vlan.selectAutonomousAddress(testProperties.get("AutonomousAddressPrefixState"));
        vlan.submit();




    }
    public static void delVLAN(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Vlan vlan = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mVlan();
        vlan.openPage();
        vlan.deleteVLAN(testProperties.get("rowNumber"));

    }

}

