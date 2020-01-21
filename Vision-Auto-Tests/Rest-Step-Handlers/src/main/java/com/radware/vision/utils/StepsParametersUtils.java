package com.radware.vision.utils;

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
        for (BodyEntry entry : bodyEntryCopy) {
            Matcher matcher = runTimeValuesPattern.matcher(entry.getValue());
            if (matcher.matches()) {
                String variable = matcher.group(1);
                if (!runTimeParameters.containsKey(variable)) report("The Variable " + variable + "is not exist", FAIL);
                entry.setValue(runTimeParameters.get(variable));
            }
        }
        return bodyEntryCopy;

    }
}