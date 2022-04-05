package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;

/**
 * @author Hadar Elbaz
 */

public class StringParametersUtils {


    public static String stringArrayParamsToString(String[] params) throws Exception {

        String newStringParameters = "";
        for (String parameter : params) {
            ParamsValidations.validateStringNotEmpty(parameter);
            newStringParameters += " " + parameter;
        }

        return newStringParameters;
    }


}
