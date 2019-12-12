package com.radware.vision.infra.utils;

/**
 * Created by moaada on 7/25/2017.
 */
public class WebUIStringsDp {

    public static final String TOPICS_NODE = "TopicsNode_dp.";
    public static final String TPOICS_STACK = "TopicsStack_dp.";
    public static final String SETUP = "setup.";
    public static final String TREE = "tree.";
    public static final String GLOBAL_PARAMETERS = "globalparams-content";
    public static final String BLACK_WHITE_LIST = "blackwhitelist.";
    public static final String BLACK_LIST = "blacklist-content";


    //Configuration.setup

    public static String getSetup() {

        return WebUIStringsVision.GWT_DEBUG + TPOICS_STACK + SETUP;
    }

    public static String getGlobalParameters() {

        return WebUIStringsVision.GWT_DEBUG + TOPICS_NODE + SETUP + TREE + GLOBAL_PARAMETERS;
    }

    public static String getBlackList() {

        return WebUIStringsVision.GWT_DEBUG + TOPICS_NODE + BLACK_WHITE_LIST + TREE + BLACK_LIST;
    }


}
