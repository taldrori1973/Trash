package com.radware.bddtests;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.AfterClass;
import org.junit.runner.RunWith;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

/**
 * Created by AviH on 30-Nov-17.
 */
@RunWith(Cucumber.class)
@CucumberOptions(format = {"pretty", "html:target/cucumber", "json:target/cucumber.json"},
        glue = {"com.radware.vision.bddtests", "com.radware.vision.restBddTests"},
        features = {"src/test/resources/Features", "src/test/resources/ServerFeatures"},
        strict = true,
        tags = {"@Functional"})
public class RunVisionBddTests {
    @AfterClass
    public static void afterFeature() {
        try
        {
            String ip = "";
            Enumeration en = NetworkInterface.getNetworkInterfaces();
            while (en.hasMoreElements()) {
                NetworkInterface i = (NetworkInterface) en.nextElement();
                for (Enumeration en2 = i.getInetAddresses(); en2.hasMoreElements();) {
                    InetAddress addr = (InetAddress) en2.nextElement();
                    if (!addr.isLoopbackAddress()) {
                        if (addr instanceof Inet4Address) {
                            ip = addr.getHostAddress();
                            break;
                        }
                    }
                }
            }
            String command = Menu.system().database().access().revoke().build() + " " + ip;
            CliOperations.runCommand(TestBase.getServersManagement().getRadwareServerCli().get(), command);
        }
        catch (Exception ignored){}
    }
}
