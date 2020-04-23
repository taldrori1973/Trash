package com.radware.vision.tests.Alteon.Configuration.System.ManagementAccess;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess.ManagementAccessHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by moaada on 7/27/2017.
 */
public class ManagementAccessTests extends WebUITestBase {

    String idleTimeout;
    TopologyTreeTabs topologyTree;


    @Test
    @TestProperties(name = "Set idle idleTimeout", paramsInclude = {"deviceName", "idleTimeout", "topologyTree"})
    public void setIdleTimeout() throws TargetWebElementNotFoundException {
        ManagementAccessHandler.updateIdleTimeout(getDeviceName(), topologyTree.getTopologyTreeTab(), idleTimeout);
        if (ManagementAccessHandler.getIdleTimeout(getDeviceName(), topologyTree.getTopologyTreeTab()).equals(idleTimeout)) {
            BaseTestUtils.report("Idle Timeout set to : " + idleTimeout, Reporter.PASS);
        } else {

            BaseTestUtils.report("Failed to set Idle Timeout to " + idleTimeout, Reporter.FAIL);
        }
    }

    public String getIdleTimeout() {
        return idleTimeout;
    }

    public void setIdleTimeout(String idleTimeout) {
        this.idleTimeout = idleTimeout;
    }

    public TopologyTreeTabs getTopologyTree() {
        return topologyTree;
    }

    public void setTopologyTree(TopologyTreeTabs topologyTree) {
        this.topologyTree = topologyTree;
    }

}
