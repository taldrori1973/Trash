package com.radware.vision.tests.Alteon.Configuration.applicationdelivery.serverresources.realservers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.WidgetsContainer;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.IpVersion;
import com.radware.vision.infra.enums.ServerType;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.List;


/**
 * Created by moaada on 7/27/2017.
 */
public class RealServersTests extends WebUITestBase {

    TopologyTreeTabs topologyTree;
    DeviceState deviceState = DeviceState.Lock;


    boolean enableRealServer;
    String realServerId;
    String description;
    ServerType serverType;
    IpVersion ipVersion;
    String ServerIpAddress;
    int columnIndex = 0;
    String columnValue = "";
    private WidgetsContainer realServerContainer;
    private WebUITable realServerTable;


    private void setUp() throws Exception {

        if (getDeviceName() == null || topologyTree == null) {
            BaseTestUtils.report("device name or topology tree are equal to null", Reporter.FAIL);
        }
        BaseHandler.lockUnlockDevice(getDeviceName(), topologyTree.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), false);
        realServerContainer = WebUIVisionBasePage.navigateToPage("Configuration->Application Delivery->Server Resources->Real Servers").getContainer();
        realServerTable = (WebUITable) realServerContainer.getTable("Real Servers");

    }

    @Test
    @TestProperties(name = "Add Real Servers", paramsInclude = {"deviceName", "topologyTree", "enableRealServer", "realServerId", "description", "serverType", "ipVersion", "ServerIpAddress"})
    public void addRealServers() {

        if (realServerId == null || ServerIpAddress == null) {
            BaseTestUtils.report("some of the mandatory fields equal to null", Reporter.FAIL);
        }

        try {
            setUp();
            realServerTable.addRow();
            if (enableRealServer) {
                realServerContainer.getCheckbox("Enable Real Server").check();
            } else {
                realServerContainer.getCheckbox("Enable Real Server").uncheck();
            }
            realServerContainer.getTextField("Real Server ID").type(realServerId);
            if (description != null) {
                realServerContainer.getTextField("Description").type(description);
            }
            if (serverType != null) {
                realServerContainer.getRadioGroup("Server Type").selectOption(serverType.getServerType());
            }
            if (ipVersion != null) {
                realServerContainer.getDropdown("IP Version").selectOptionByValue(ipVersion.getIpVer());
            }

            realServerContainer.getTextField("Server IP Address").type(ServerIpAddress);

            WebUIBasePage.submit();

            //Verify if the row have been added
            realServerTable = (WebUITable) realServerContainer.getTable("Real Servers");
            if (realServerTable.getRowIndex("Real Server ID", realServerId) >= 0) {
                BaseTestUtils.report("Adding real server succeeded", Reporter.PASS);
            } else {
                BasicOperationsHandler.takeScreenShot();
                BaseTestUtils.report("Adding real server failed", Reporter.FAIL);

            }


        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());

        }


    }

    @Test
    @TestProperties(name = "Check If Real Server Contain Value", paramsInclude = {"deviceName", "topologyTree", "realServerId", "columnIndex", "columnValue"})
    public void checkIfRealServerContainValue() {
        try {
            setUp();
            int index = realServerTable.getRowIndex("Real Server ID", realServerId);
            List<WebUIRow> rows = realServerTable.getRows();
            if (index >= 0) {
                WebUIRow row = rows.get(index);
                String actualValue = row.cell(columnIndex).value();
                if (actualValue.equals(columnValue)) {
                    BaseTestUtils.report("Real server contain the value", Reporter.PASS);
                } else {
                    BaseTestUtils.report("Real server doesn't contain the value", Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("Real server doesn't exist", Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());

        }


    }

    @Test
    @TestProperties(name = "Delete Real servers ", paramsInclude = {"deviceName", "topologyTree", "realServerId"})
    public void deleteRealServers() {

        if (realServerId == null) {
            BaseTestUtils.report("realServerId is equal to null", Reporter.FAIL);
        }

        try {
            setUp();

            realServerTable.deleteRowByKeyValue("Real Server ID", realServerId);

            //Verify if row have been deleted
            if (realServerTable.getRowIndex("Real Server ID", realServerId) >= 0) {
                BasicOperationsHandler.takeScreenShot();
                BaseTestUtils.report("Row have not been deleted", Reporter.FAIL);

            } else {
                BaseTestUtils.report("Row have been successfully deleted", Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());

        }


    }

    public TopologyTreeTabs getTopologyTree() {
        return topologyTree;
    }

    public void setTopologyTree(TopologyTreeTabs topologyTree) {
        this.topologyTree = topologyTree;
    }


    public boolean getEnableRealServer() {
        return enableRealServer;
    }

    public void setEnableRealServer(boolean enableRealServer) {
        this.enableRealServer = enableRealServer;
    }

    public String getRealServerId() {
        return realServerId;
    }

    public void setRealServerId(String realServerId) {
        this.realServerId = realServerId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ServerType getServerType() {
        return serverType;
    }

    public void setServerType(ServerType serverType) {
        this.serverType = serverType;
    }

    public IpVersion getIpVersion() {
        return ipVersion;
    }

    public void setIpVersion(IpVersion ipVersion) {
        this.ipVersion = ipVersion;
    }

    public String getServerIpAddress() {
        return ServerIpAddress;
    }

    public void setServerIpAddress(String serverIpAddress) {
        ServerIpAddress = serverIpAddress;
    }

    public int getColumnIndex() {
        return columnIndex;
    }

    public void setColumnIndex(int columnIndex) {
        this.columnIndex = columnIndex;
    }

    public String getColumnValue() {
        return columnValue;
    }

    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }


}
