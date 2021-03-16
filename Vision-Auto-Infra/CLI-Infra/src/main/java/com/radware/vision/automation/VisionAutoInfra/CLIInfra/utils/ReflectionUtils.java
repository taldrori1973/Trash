package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;



import java.lang.reflect.Method;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.LicenseVisionUtils;

/**
 * Created by stanislava on 11/6/2016.
 */
public class ReflectionUtils {
    public static Class[] classArray;
    public static Object invokePrivateMethod(String methodName, Object... args){
        LicenseVisionUtils licenseVisionUtils = new LicenseVisionUtils();
        Method privateMethod;
        Object invokeResult;
        try {
            setClassArray(args);
            privateMethod = LicenseVisionUtils.class.getDeclaredMethod(methodName, classArray);
            privateMethod.setAccessible(true);
            invokeResult = privateMethod.invoke(licenseVisionUtils, args);
        }catch(Exception e){
            throw new RuntimeException("" + e.getStackTrace());
        }

        return invokeResult;
    }
    public static void setClassArray(Object... args){
        classArray = new Class[args.length];
        for(int i = 0;i < args.length;i++){
            classArray[i] = args[i].getClass();
        }
    }
}
