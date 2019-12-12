package com.radware.vision.infra.utils;

/**
 * Created by moaada on 7/27/2017.
 */
public class WebUIStringsAlteon {

    public static String TPOICS_NODE_APPLICATION_DELIVERY = "TopicsNode_Application_Delivery.";
    public static String TOPICS_STACK_CONFIGURATION = "TopicsStack_Configuration.";
    public static String NODE_0 = "Node0.";
    public static String REAL_SERVERS_NEW_CONTENT = "Real_Servers_new-content";
    public static String APPLICATION_SERVICES_14 = "Application_Services14.";
    public static String APPLICATION_DELIVERY = "Application_Delivery";
    public static String SERVER_RESOURCES_CONTET = "ServerResources-content";


    //Configuration.Application Delivery

    public static String getApplicationDelivery() {
        return WebUIStringsVision.GWT_DEBUG + TOPICS_STACK_CONFIGURATION + APPLICATION_DELIVERY;
    }

    //Configuration.Application Delivery.Server Resources
    public static String getServerResources() {

        return WebUIStringsVision.GWT_DEBUG + TPOICS_NODE_APPLICATION_DELIVERY + WebUIStringsDp.TREE + APPLICATION_SERVICES_14 + SERVER_RESOURCES_CONTET;
    }

    public static String getServerResourcesRealServers() {

        return WebUIStringsVision.GWT_DEBUG + TPOICS_NODE_APPLICATION_DELIVERY + WebUIStringsDp.TREE + NODE_0 + REAL_SERVERS_NEW_CONTENT;


    }


}
