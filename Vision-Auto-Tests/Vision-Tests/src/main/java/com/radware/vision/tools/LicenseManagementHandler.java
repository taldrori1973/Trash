package com.radware.vision.tools;

import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.jsonparsers.impl.GenericJSonParsers;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.infra.enums.VisionLicenses;
import com.radware.vision.pojomodel.security.VisionLicensePojo;
import com.radware.vision.utils.ReflectionUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ashrafa on 7/4/2017.
 * Copied to this Project by MohamadI on 30/03/2020
 */
public class LicenseManagementHandler {
    public static String generateVisionActivationLicenseKey(String macAddress) throws Exception {
        String licenseKey;
        String licensePrefix = VisionLicenses.ACTIVATION.getLicensePrefixPattern();
        licenseKey = licensePrefix + ReflectionUtils.invokePrivateMethod("generateLicenseString", macAddress, licensePrefix);
        return licenseKey;
    }

    private static String getPhysicalManagement(RadwareServerCli radwareCli) throws Exception {
        String baseCommand = "net ip get";
        InvokeUtils.invokeCommand(baseCommand, radwareCli);
        ArrayList cmdOutput = radwareCli.getCmdOutput();
        for (Object outputLine : cmdOutput) {
            if (outputLine.toString().contains("*"))
                return outputLine.toString().split("\\*")[0].trim();
        }

        return null;
    }

    private static String getFromToPeriod(String fromDate, String toDate) {
        String fromToPeriod = "";
        if (!fromDate.equals("") && !toDate.equals("")) {
            fromToPeriod = ("-").concat(fromDate).concat("-").concat(toDate);
        }

        return fromToPeriod;
    }

    public static List<String> getLicenses(VisionRestClient visionRestClient) {
        visionRestClient.login();
        String result = visionRestClient.mgmtCommands.visionCommands.getVisionLicense();
        List<VisionLicensePojo> licensePojo = GenericJSonParsers.getInstance().parseJsonList(result, VisionLicensePojo.class);
        List<String> licenseStr = new ArrayList<>();

        for (VisionLicensePojo license : licensePojo) {
            licenseStr.add(license.getLicenseStr());
        }
        return licenseStr;
    }

    public static boolean isInstalled(VisionRestClient visionRestClient, String licensePrefix) {

        return getLicenses(visionRestClient).stream()
                .filter(license -> license.startsWith(licensePrefix))
                .findFirst().isPresent();
    }
}
