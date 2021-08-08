package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Hadar Elbaz
 */

public class ParamsValidations {

    public static void validateStringNotEmpty(String str) throws Exception{

        if (str == null || str.equals("")){
            throw new Exception("One or more arguments were not initialized");
        }
    }

    public static void validateIpStructure(String ip) throws Exception{
        validateStringNotEmpty(ip);
        Matcher matcher = Pattern.compile("\\d+\\.\\d+\\.\\d+\\.\\d+").matcher(ip);
        if(!matcher.find()) {
            throw new Exception("Parameter with value: " + ip + ", doesn't has ip structure");
        }
    }

    /**
     * @param speed
     * @throws Exception
     */
    public static void validateNumberValue(int speed, ArrayList<Integer> numbers) throws Exception {
        for (int number: numbers){
            if (number == speed){
                return;
            }
        }
        throw new Exception("Parameter with value " + speed + " is out of range " + numbers.toString());
    }

}
