package com.radware.vision.tests.defensepro;

import com.radware.vision.infra.testhandlers.DefencePro.enums.DPHaDeviceStatus;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;

import org.junit.Test;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.DefencePro.DPClusterManageHandler;

public class DefensePro extends WebUITestBase {
	
	public String primaryClusterMember;
	public String secondaryClusterMember;
    public DPHaDeviceStatus dpHaDeviceStatus;
	

	@Test
	@TestProperties(name = "DP Cluster - Switchover", paramsInclude = {"deviceName"})
	public void dpClusterSwitchover() throws Exception {
		try {
			DPClusterManageHandler.dpClusterSwitchover(getDeviceName());
		} catch (Exception e) {
			report.report("Failed to switchover between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	
	@Test
	@TestProperties(name = "DP Cluster - Update Policies", paramsInclude = {"deviceName"})
	public void dpClusterUpdatePolicies() throws Exception {
		try {
			DPClusterManageHandler.dpClusterUpdatePolicies(getDeviceName());
		} catch (Exception e) {
			report.report("Failed to update policies between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	
	@Test
	@TestProperties(name = "DP Cluster - Synchronize", paramsInclude = {"deviceName"})
	public void dpClusterUpdateSynchronize() throws Exception {
		try {
			DPClusterManageHandler.dpClusterSync(getDeviceName());
		} catch (Exception e) {
			report.report("Failed to synchronize between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
		}
	}

    @Test
    @TestProperties(name = "DP Cluster - Verify Device HA State", paramsInclude = {"deviceName", "dpHaDeviceStatus"})
    public void verifyDPHaStatus() {
        try {
            if (!DPClusterManageHandler.verifyDeviceHaStatus(getDeviceName(), dpHaDeviceStatus)) {
                report.report("Device: " + getDeviceName() + " " + "has different status than: " + dpHaDeviceStatus.getStatus(), Reporter.FAIL);
            }
        }
        catch (Exception e) {
            report.report("Failed to switchover between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

	@Test
	@TestProperties(name = "DP Cluster - Verify Primary Device", paramsInclude = {"deviceName", "primaryClusterMember"})
	public void verifyClusterPrimaryDevice() throws Exception {
		try {
			if(!DPClusterManageHandler.isPrimaryDpDeviceMember(getDeviceName(), primaryClusterMember)) {
				report.report("Primary DP member was not found: " + primaryClusterMember + "\n" , Reporter.FAIL);
			}
		} catch (Exception e) {
			report.report("Primary DP member was not found: " + primaryClusterMember + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	
	@Test
	@TestProperties(name = "DP Cluster - Verify Secondary Device", paramsInclude = {"deviceName", "secondaryClusterMember"})
	public void verifyClusterSecondaryDevice() throws Exception {
		try {
			if(!DPClusterManageHandler.isSecondaryDpDeviceMember(getDeviceName(), secondaryClusterMember)) {
				report.report("Secondary DP member was not found: " + secondaryClusterMember + "\n" , Reporter.FAIL);
			}
		} catch (Exception e) {
			report.report("Secondary DP member was not found: " + secondaryClusterMember + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public String getPrimaryClusterMember() {
		return primaryClusterMember;
	}

	public void setPrimaryClusterMember(String primaryClusterMember) {
		this.primaryClusterMember = primaryClusterMember;
	}

	public String getSecondaryClusterMember() {
		return secondaryClusterMember;
	}

	public void setSecondaryClusterMember(String secondaryClusterMember) {
		this.secondaryClusterMember = secondaryClusterMember;
	}

    public DPHaDeviceStatus getDpHaDeviceStatus() {
        return dpHaDeviceStatus;
    }

    public void setDpHaDeviceStatus(DPHaDeviceStatus dpHaDeviceStatus) {
        this.dpHaDeviceStatus = dpHaDeviceStatus;
    }
}
