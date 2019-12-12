package com.radware.vision.infra.testhandlers.alteon.configuration.system.Snmp.SnmpV3;

import com.radware.automation.webui.webpages.configuration.system.snmp.snmpv3.*;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by VadymS on 5/28/2015.
 */
public class SnmpV3TableActionHandler extends BaseHandler {


    public static void addNotify(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        NotifyTags notifyTags = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mNotifyTags();
        notifyTags.openPage();
//        notifyTags.addNotifyTag(testProperties.get("TagName"), testProperties.get("Tag"));
        notifyTags.addNotifyTag();
        notifyTags.submit();
    }

    public static void delNotify(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        NotifyTags notifyTags = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mNotifyTags();
        notifyTags.openPage();
        notifyTags.deleteNotifyTag(testProperties.get("TagName"));


    }
    public static void viewNotify(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        NotifyTags notifyTags = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mNotifyTags();
        notifyTags.openPage();
//        notifyTags.viewNotifyTag(testProperties.get("RowNumber"));

    }
    public static void duplicateNotify(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        NotifyTags notifyTags = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mNotifyTags();
        notifyTags.openPage();
//        notifyTags.duplicateNotifyTag(testProperties.get("RowNumber"), testProperties.get("TagName"), testProperties.get("Tag"));
        notifyTags.submit();
    }




    public static void addUSMUsers(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        USMUsers usmusers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mUSMUsers();
        usmusers.openPage();
        usmusers.addUser();
        usmusers.setUsername(testProperties.get("userName"));
        if (testProperties.get("authProtocol").equals("MD5") || testProperties.get("authProtocol").equals("SHA")) {
//            usmusers.setAuthProtocol(testProperties.get("authProtocol"));
//            usmusers.setPassField(testProperties.get("authenticationPassword"), WebUIStrings.getAuthPass());
//            usmusers.setPassField(testProperties.get("confAuthenticationPassword"), WebUIStrings.getAuthPassConfirm());
        } if (testProperties.get("authProtocol").equals("None")){
//            usmusers.setAuthProtocol(testProperties.get("authProtocol"));
        }

        if (testProperties.get("privacyProtocol").equals("DES")) {
//            usmusers.setPrivacyProtocol(testProperties.get("privacyProtocol"));
//            usmusers.setPassField(testProperties.get("privacyPassword"),WebUIStrings.getPrivacyPass());
//            usmusers.setPassField(testProperties.get("confPrivacyPassword"),WebUIStrings.getPrivacyPassConfirm());
        }  if (testProperties.get("privacyProtocol").equals("None")) {
//            usmusers.setPrivacyProtocol(testProperties.get("privacyProtocol"));
        }
        usmusers.submit();
    }

    public static void delUSMUsers(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        USMUsers usmusers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mUSMUsers();
        usmusers.openPage();
        usmusers.deleteUser(testProperties.get("userName"));


    }
    public static void viewUSMUsers(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        USMUsers usmusers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mUSMUsers();
        usmusers.openPage();
//        usmusers.viewUser(testProperties.get("RowNumber"));

    }
    public static void duplicateUSMUsers(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        USMUsers usmusers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mUSMUsers();
        usmusers.openPage();
//        usmusers.duplicateUser(testProperties.get("RowNumber"));
        usmusers.setUsername(testProperties.get("userName"));
        if (testProperties.get("authProtocol").equals("MD5") || testProperties.get("authProtocol").equals("SHA")) {
//            usmusers.setAuthProtocol(testProperties.get("authProtocol"));
//            usmusers.setPassField(testProperties.get("authenticationPassword"), WebUIStrings.getAuthPass());
//            usmusers.setPassField(testProperties.get("confAuthenticationPassword"), WebUIStrings.getAuthPassConfirm());
        } if (testProperties.get("authProtocol").equals("None")){
//            usmusers.setAuthProtocol(testProperties.get("authProtocol"));
        }

        if (testProperties.get("privacyProtocol").equals("DES")) {
//            usmusers.setPrivacyProtocol(testProperties.get("privacyProtocol"));
//            usmusers.setPassField(testProperties.get("privacyPassword"),WebUIStrings.getPrivacyPass());
//            usmusers.setPassField(testProperties.get("confPrivacyPassword"),WebUIStrings.getPrivacyPassConfirm());
        }  if (testProperties.get("privacyProtocol").equals("None")) {
//            usmusers.setPrivacyProtocol(testProperties.get("privacyProtocol"));
        }
        usmusers.submit();

    }



    public static void addViewTree(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ViewTrees viewTrees = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mViewTrees();
        viewTrees.openPage();
        viewTrees.addViewTree();
        if (testProperties.get("viewTreeNameInput").equals("From List")) {
//            viewTrees.setFromList();
//            viewTrees.setNameFromList(testProperties.get("viewTreeNameRow"));
            viewTrees.setSubtree(testProperties.get("subTree"));
            viewTrees.setMask(testProperties.get("mask"));
//            viewTrees.setType(testProperties.get("viewTreeType"));
        }
        if (testProperties.get("viewTreeNameInput").equals("User-Defined Value")) {
//            viewTrees.setUserDefined();
//            viewTrees.setName(testProperties.get("viewTreeName"));
            viewTrees.setSubtree(testProperties.get("subTree"));
            viewTrees.setMask(testProperties.get("mask"));
//            viewTrees.setType(testProperties.get("viewTreeType"));
        }
        viewTrees.submit();



    }

    public static void delViewTree(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ViewTrees viewTrees = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mViewTrees();
        viewTrees.openPage();
        viewTrees.deleteUser(testProperties.get("rowNumber"));

    }
    public static void editViewTree(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ViewTrees viewTrees = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mViewTrees();
        viewTrees.openPage();
        viewTrees.editViewTree(testProperties.get("rowNumber"));
        viewTrees.setMask(testProperties.get("mask"));
//        viewTrees.setType(testProperties.get("viewTreeType"));
        viewTrees.submit();


    }
    public static void duplicateViewTree(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ViewTrees viewTrees = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mViewTrees();
        viewTrees.openPage();
//        viewTrees.duplicateViewTree(testProperties.get("rowNumber"));
        if (testProperties.get("viewTreeNameInput").equals("From List")) {
//            viewTrees.setFromList();
//            viewTrees.setNameFromList(testProperties.get("viewTreeNameRow"));
            viewTrees.setSubtree(testProperties.get("subTree"));
            viewTrees.setMask(testProperties.get("mask"));
//            viewTrees.setType(testProperties.get("viewTreeType"));
        }
        if (testProperties.get("viewTreeNameInput").equals("User-Defined Value")) {
//            viewTrees.setUserDefined();
//            viewTrees.setName(testProperties.get("viewTreeName"));
            viewTrees.setSubtree(testProperties.get("subTree"));
            viewTrees.setMask(testProperties.get("mask"));
//            viewTrees.setType(testProperties.get("viewTreeType"));
        }
        viewTrees.submit();

    }



    public static void addGroup(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Groups groups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mGroups();
        groups.openPage();
        groups.addGroup();
//        groups.setSecurityModel(testProperties.get("securityModel"));
//        groups.setUSMUserName(testProperties.get("usmUserRow"));
        if (testProperties.get("groupNameInput").equals("From List")) {
//            groups.setFromList();
//            groups.setNameFromList(testProperties.get("groupNameRow"));
        }

        if (testProperties.get("groupNameInput").equals("User-Defined Value")) {
//            groups.setUserDefined();
            groups.setName(testProperties.get("groupName"));
        }
        groups.submit();
    }

    public static void delGroup(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Groups groups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mGroups();
        groups.openPage();
        groups.deleteGroup(testProperties.get("rowNumber"));


    }
    public static void viewGroup(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Groups groups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mGroups();
        groups.openPage();
//        groups.viewGroup(testProperties.get("rowNumber"));

    }
    public static void duplicateGroup(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Groups groups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mGroups();
        groups.openPage();
//        groups.duplicateGroup(testProperties.get("rowNumber"));
//        groups.setSecurityModel(testProperties.get("securityModel"));
//        groups.setUSMUserName(testProperties.get("usmUserRow"));
        if (testProperties.get("groupNameInput").equals("From List")) {
//            groups.setFromList();
//            groups.setNameFromList(testProperties.get("groupNameRow"));
        }

        if (testProperties.get("groupNameInput").equals("User-Defined Value")) {
//            groups.setUserDefined();
            groups.setName(testProperties.get("groupName"));
        }
        groups.submit();

    }




    public static void addAccess(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Access access = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mAccess();
        access.openPage();
        access.addAccess();
        access.setName(testProperties.get("groupNameRow"));
//        access.setContextPrefix(testProperties.get("contextPrefix"));
//        access.setSecurityModel(testProperties.get("securityModel"));
//        access.setSecurityLevel(testProperties.get("accessSecurityLevel"));
//        access.setMatchType(testProperties.get("accessMatchType"));
        access.setReadViewName(testProperties.get("readViewNameRow"));
        access.setWriteViewName(testProperties.get("writeViewNameRow"));
        access.setNotifyViewName(testProperties.get("notifyViewNameRow"));
        access.submit();


    }

    public static void delAccess(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Access access = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mAccess();
        access.openPage();
//        access.deleteGroup(testProperties.get("rowNumber"));


    }
    public static void viewAccess(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Access access = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mAccess();
        access.openPage();
//        access.viewGroup(testProperties.get("rowNumber"));

    }
    public static void duplicateAccess(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Access access = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mAccess();
        access.openPage();
//        access.duplicateGroup(testProperties.get("rowNumber"));
        access.setName(testProperties.get("groupNameRow"));
//        access.setContextPrefix(testProperties.get("contextPrefix"));
//        access.setSecurityModel(testProperties.get("securityModel"));
//        access.setSecurityLevel(testProperties.get("accessSecurityLevel"));
//        access.setMatchType(testProperties.get("accessMatchType"));
        access.setReadViewName(testProperties.get("readViewNameRow"));
        access.setWriteViewName(testProperties.get("writeViewNameRow"));
        access.setNotifyViewName(testProperties.get("notifyViewNameRow"));
        access.submit();
    }


    public static void addCommunity(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Communities communities = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mCommunities();
        communities.openPage();
        communities.addCommunity();
        communities.setIndex(testProperties.get("index"));
//        communities.setCommunityName(testProperties.get("communityName"));
        communities.setSecurityName(testProperties.get("securityName"));
        communities.setTransportTag(testProperties.get("transportTag"));
        communities.submit();

    }

    public static void delCommunity(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Communities communities = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mCommunities();
        communities.openPage();
        communities.deleteCommunity(testProperties.get("rowNumber"));



    }
    public static void viewCommunity(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        Communities communities = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mCommunities();
        communities.openPage();
//        communities.viewCommunity(testProperties.get("rowNumber"));
    }
    public static void duplicateCommunity(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Communities communities = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mCommunities();
        communities.openPage();
//        communities.duplicateCommunity(testProperties.get("rowNumber"));
        communities.setIndex(testProperties.get("index"));
//        communities.setCommunityName(testProperties.get("communityName"));
        communities.setSecurityName(testProperties.get("securityName"));
        communities.setTransportTag(testProperties.get("transportTag"));
        communities.submit();


    }






    public static void addTargetParameters(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetParameters targetParameters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetParameters();
        targetParameters.openPage();
        targetParameters.addTargetParameter();
        targetParameters.setName(testProperties.get("targetName"));
//        targetParameters.setMessageProcessingModel(testProperties.get("messageProcessingModel"));
//        targetParameters.setSecurityModel(testProperties.get("securityModel"));
        targetParameters.setUsmUserName(testProperties.get("usmUserRow"));
//        targetParameters.setSecurityLevel(testProperties.get("targetParametersSecurityLevel"));
        targetParameters.submit();



    }

    public static void delTargetParameters(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetParameters targetParameters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetParameters();
        targetParameters.openPage();
//        targetParameters.deleteTargetParameters(testProperties.get("rowNumber"));



    }
    public static void viewTargetParameters(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetParameters targetParameters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetParameters();
        targetParameters.openPage();
//        targetParameters.viewTargetParameters(testProperties.get("rowNumber"));
    }
    public static void duplicateTargetParameters(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TargetParameters targetParameters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetParameters();
        targetParameters.openPage();
//        targetParameters.duplicateTargetParameters(testProperties.get("rowNumber"));
        targetParameters.setName(testProperties.get("targetName"));
//        targetParameters.setMessageProcessingModel(testProperties.get("messageProcessingModel"));
//        targetParameters.setSecurityModel(testProperties.get("securityModel"));
        targetParameters.setUsmUserName(testProperties.get("usmUserRow"));
//        targetParameters.setSecurityLevel(testProperties.get("targetParametersSecurityLevel"));
        targetParameters.submit();

    }





    public static void addTargetAddress(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetAddresses targetAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetAddresses();
        targetAddresses.openPage();
        targetAddresses.addTargetAddresses();
//        targetAddresses.setIndex(testProperties.get("AddressIndex"));
        targetAddresses.setName(testProperties.get("AddressName"));
        if(testProperties.get("ipVersion").equals("IPv4")){
            targetAddresses.setTransportAddressIpv4(testProperties.get("TransportIP"));
        }
        if(testProperties.get("ipVersion").equals("IPv6")){
            targetAddresses.setTransportAddressIpv6(testProperties.get("TransportIP"));
        }

//        targetAddresses.setTransportAddressPort(testProperties.get("TransportPort"));
        targetAddresses.setTagList(testProperties.get("TagList"));
        targetAddresses.setTargetParametersName(testProperties.get("TargetParametersNameRow"));
//        targetAddresses.setTrapFeature(testProperties.get("TrapFeatures"));
        targetAddresses.submit();


    }

    public static void delTargetAddress(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetAddresses targetAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetAddresses();
        targetAddresses.openPage();
//        targetAddresses.deleteTargetAddresses(testProperties.get("rowNumber"));


    }
    public static void editTargetAddress(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        TargetAddresses targetAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetAddresses();
        targetAddresses.openPage();
//        targetAddresses.editTargetAddress(testProperties.get("rowNumber"));
        targetAddresses.setName(testProperties.get("AddressName"));
        if(testProperties.get("ipVersion").equals("IPv4")){
            targetAddresses.setTransportAddressIpv4(testProperties.get("TransportIP"));
        }
        if(testProperties.get("ipVersion").equals("IPv6")){
            targetAddresses.setTransportAddressIpv6(testProperties.get("TransportIP"));
        }

//        targetAddresses.setTransportAddressPort(testProperties.get("TransportPort"));
        targetAddresses.setTagList(testProperties.get("TagList"));
        targetAddresses.setTargetParametersName(testProperties.get("TargetParametersNameRow"));
//        targetAddresses.setTrapFeature(testProperties.get("TrapFeatures"));
        targetAddresses.submit();


    }
    public static void duplicateTargetAddress(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TargetAddresses targetAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetAddresses();
        targetAddresses.openPage();
//        targetAddresses.duplicateTargetAddresses(testProperties.get("rowNumber"));
//        targetAddresses.setIndex(testProperties.get("AddressIndex"));
        targetAddresses.setName(testProperties.get("AddressName"));
        if(testProperties.get("ipVersion").equals("IPv4")){
            targetAddresses.setTransportAddressIpv4(testProperties.get("TransportIP"));
        }
        if(testProperties.get("ipVersion").equals("IPv6")){
            targetAddresses.setTransportAddressIpv6(testProperties.get("TransportIP"));
        }

//        targetAddresses.setTransportAddressPort(testProperties.get("TransportPort"));
        targetAddresses.setTagList(testProperties.get("TagList"));
        targetAddresses.setTargetParametersName(testProperties.get("TargetParametersNameRow"));
//        targetAddresses.setTrapFeature(testProperties.get("TrapFeatures"));
        targetAddresses.submit();



    }

}
