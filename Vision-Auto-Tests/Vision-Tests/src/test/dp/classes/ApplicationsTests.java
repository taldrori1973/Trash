package com.radware.vision.tests.dp.classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.applications.Applications;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;


public class ApplicationsTests extends DpTestBase {


	/*create app class Test*/
	private String portsGroupName;
	private String fromL4Port;
	private String toL4Port;
	private String typeOfEntry;
	


	public String getPortsGroupName() {
		return portsGroupName;
	}
	public void setPortsGroupName(String portsGroupName) {
		this.portsGroupName = portsGroupName;
	}
	public String getFromL4Port() {
		return fromL4Port;
	}
	public void setFromL4Port(String fromL4Port) {
		this.fromL4Port = fromL4Port;
	}
	public String getToL4Port() {
		return toL4Port;
	}
	public void setToL4Port(String toL4Port) {
		this.toL4Port = toL4Port;
	}
	public String getTypeOfEntry() {
		return typeOfEntry;
	}
	public void setTypeOfEntry(String typeOfEntry) {
		this.typeOfEntry = typeOfEntry;
	}

	@Test
    @TestProperties(name = "Create Application Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "portsGroupName" /*, "typeOfEntry"*/, "fromL4Port", "toL4Port"})
    public void createAppClass() {
		Applications app = dpUtils.dpProduct.mConfiguration().mClasses().mApplications();
		app.openPage();
		app.addApplication();
		app.setPortsGroupName(portsGroupName);
		app.setFromL4Port(fromL4Port);
		app.setToL4Port(toL4Port);
		app.submit();

	}
	
	@Test
    @TestProperties(name = "Delete Application Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "portsGroupName"})
    public void deleteAppClass() {
		Applications app = dpUtils.dpProduct.mConfiguration().mClasses().mApplications();
		app.openPage();
		app.deleteApplicationByKeyValue("Ports Group Name", portsGroupName);
	}
}
