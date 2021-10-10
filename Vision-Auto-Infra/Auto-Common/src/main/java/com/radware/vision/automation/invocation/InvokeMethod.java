package com.radware.vision.automation.invocation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;

import java.lang.reflect.InvocationTargetException;
import java.util.Optional;

import static com.radware.vision.automation.base.TestBase.sutManager;

public class InvokeMethod {
    private static Object generate(String className, String method, Object... args){
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
     *
     * @param method - String that includes method name and all args
     * @return - an object of the execution
     */
    public static Object invokeMethod(String method){
        Object[] parameters = method.substring(method.indexOf("(") + 1, method.indexOf(");")).trim().split(",");
        method = method.substring(method.indexOf("#") + 1, method.indexOf("("));
        switch (method){
            //converts from device set_id -> IP to hex
            case "convertIpToHexa":
                String className = "com.radware.vision.bddtests.utils.SimulatorUtils";
                Optional<TreeDeviceManagementDto> deviceOpt= sutManager.getTreeDeviceManagement((String) parameters[0]);
                return generate(className, method, deviceOpt.get().getManagementIp());
            default:
                break;
        }
        return null;
    }
}
