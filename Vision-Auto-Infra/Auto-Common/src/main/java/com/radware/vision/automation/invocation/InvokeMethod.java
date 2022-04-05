package com.radware.vision.automation.invocation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;

import java.lang.reflect.InvocationTargetException;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.automation.base.TestBase.sutManager;

public class InvokeMethod {
    private static Object generate(String className, String method, Object... args) {
        Object returnObj = null;
        try {
            Class<?> myClass = Class.forName(className);
            Object obj = myClass.newInstance();
            java.lang.reflect.Method setNameMethod = obj.getClass().getMethod(method, String.class);
            returnObj = setNameMethod.invoke(obj, args); // pass arg
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return returnObj;
    }

    /**
     * @param originStr - String that includes method name and all args
     * @return - an object of the execution
     */
    public static Object invokeMethodFromText(String originStr) {
        Pattern pattern = Pattern.compile("#(.*)\\((.*)\\);");
        Matcher matcher = pattern.matcher(originStr);
        if (!matcher.find())
            return originStr;
        String method = matcher.group(1);
        Object[] params = matcher.group(2).split(",");

        String className, invokeValue = "";
        switch (method) {
            //converts from device set_id -> IP to hex
            case "convertIpToHexa":
                className = "com.radware.vision.bddtests.utils.SimulatorUtils";
                Optional<TreeDeviceManagementDto> deviceOpt = sutManager.getTreeDeviceManagement(String.valueOf(params[0]));
                invokeValue = (String) generate(className, method, deviceOpt.get().getManagementIp());
                break;
            case "getSUTValue":
                className = "com.radware.vision.bddtests.utils.Variables";
                invokeValue = (String) generate(className, method, params);
                break;
            default:
                return null;
        }

        return originStr.replace(matcher.group(), invokeValue);
    }
}
