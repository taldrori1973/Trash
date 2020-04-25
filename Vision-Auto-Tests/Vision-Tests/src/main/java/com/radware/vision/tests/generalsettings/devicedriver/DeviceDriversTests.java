package com.radware.vision.tests.generalsettings.devicedriver;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.system.generalsettings.devicedriver.DeviceDriverHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.awt.*;

public class DeviceDriversTests  extends WebUITestBase{

	public String ddAction = "Upload Device Driver";
	public String fileName = "please change to the PATH";
	public String columnValue;
	public String columnName;
	
	
	
	@Test
	@TestProperties(name = "update Device Driver", paramsInclude = {"qcTestId", "fileName", "columnValue", "columnName"})
	public void updateDeviceDriver() throws AWTException {
		try{
			DeviceDriverHandler.updateDeviceDriver(fileName, columnValue, columnName);
		}
		catch(Exception e){
            BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	@Test
	@TestProperties(name = "update to Latest Driver", paramsInclude = {"qcTestId", "columnValue", "columnName"})
	public void updateToLatestDriver() throws AWTException {
		try{
			DeviceDriverHandler.updateToLatestDriver(columnValue, columnName);
		}
		catch(Exception e){
            BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	@Test
	@TestProperties(name = "revert To Baseline Driver", paramsInclude = {"qcTestId", "columnValue", "columnName"})
	public void revertToBaselineDriver() throws AWTException {
		try{
			DeviceDriverHandler.revertToBaselineDriver(columnValue, columnName);
		}
		catch(Exception e){
            BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	@Test
	@TestProperties(name = "upload Device Driver", paramsInclude = {"qcTestId", "fileName"})
	public void uploadDeviceDriverD(){
		try{
			DeviceDriverHandler.uploadDeviceDriver(fileName);
		}
		catch(Exception e){
            BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
	}
	@Test
	@TestProperties(name = "updateAlldriversToLatest", paramsInclude = {"qcTestId"})
	public void updateAlldriversToLatest() throws AWTException {
		try{
			DeviceDriverHandler.updateAllDriversToLatest();
		}
		catch(Exception e){
            BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public String getDdAction() {
		return ddAction;
	}

	public void setDdAction(String ddAction) {
		this.ddAction = ddAction;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getColumnValue() {
		return columnValue;
	}

	public void setColumnValue(String columnValue) {
		this.columnValue = columnValue;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
}
