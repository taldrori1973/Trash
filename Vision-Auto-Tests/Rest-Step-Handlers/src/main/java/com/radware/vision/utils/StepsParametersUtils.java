package com.radware.vision.utils;

import org.apache.commons.lang.math.NumberUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.automation.tools.basetest.BaseTestUtils.report;
import static com.radware.automation.tools.basetest.Reporter.FAIL;

public class StepsParametersUtils {
    public static Map<String, String> setRunTimeValues(final Map<String, String> parametersMap, final Map<String, String> runTimeParameters, final Pattern runTimeValuesPattern) {
        Map<String, String> parametersMapCopy = new HashMap<>(parametersMap);
        for (String key : parametersMap.keySet()) {
            Matcher matcher = runTimeValuesPattern.matcher(parametersMap.get(key));
            if (matcher.matches()) {
                String variable = matcher.group(1);
                if (!runTimeParameters.containsKey(variable)) report("The Variable " + variable + "is not exist", FAIL);
                parametersMapCopy.put(key, runTimeParameters.get(variable));
            }
        }
        return parametersMapCopy;
    }

    public static List<BodyEntry> setRunTimeValuesOfBodyEntries(final List<BodyEntry> bodyEntries, final Map<String, String> runTimeParameters, final Pattern runTimeValuesPattern) {
        List<BodyEntry> bodyEntryCopy = new ArrayList<>(bodyEntries);
        for (BodyEntry entry : bodyEntryCopy) {//entry like |jsonPath|"${id}" or ${id}|
            Matcher matcher = runTimeValuesPattern.matcher(entry.getValue());
            if (matcher.matches()) {
                String variable = matcher.group(1);
                if (!runTimeParameters.containsKey(variable)) report("The Variable " + variable + "is not exist", FAIL);
                String value = runTimeParameters.get(variable);

                entry.setValue(entry.getValue().replaceAll(String.format("\\$\\{%s\\}", variable), value));
            }
        }
        return bodyEntryCopy;

    }

    public static Object valueOf(String value) {
        if (value.startsWith("\"") && value.endsWith("\"")) return value.substring(1, value.length() - 1);
        if (value.equalsIgnoreCase("null")) return null;
        if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false")) return Boolean.valueOf(value);
        if (NumberUtils.isNumber(value)) return NumberUtils.createNumber(value);
        throw new IllegalArgumentException(String.format("The value %s data type is not supported , the supported data types are: %s",
                value, "String , for example:\"value\"\nnull\nboolean\nnumber"));
    }
}
