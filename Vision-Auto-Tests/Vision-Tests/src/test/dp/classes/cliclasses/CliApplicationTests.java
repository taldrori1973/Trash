package com.radware.vision.tests.dp.classes.cliclasses;

import jsystem.extensions.analyzers.tabletext.GetTableColumn;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;

import org.junit.Before;
import org.junit.Test;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

public class CliApplicationTests extends SystemTestCase4{

	String portsGroupName;
	String toL4Port;
	String fromL4Port;
	DefenseProProduct defensepro;
	
	@Test
	@TestProperties(name = "Verify Application - Cli", paramsInclude = { "qcTestId", "portsGroupName" , "fromL4Port", "toL4Port"})
	public void CliApplicationTest() throws Exception {
		
		boolean passed = true;
		
		String fpColumnHeader = "From Port";
	    String tpColumnHeader = "To Port";
		
		defensepro.classes.getClassesModifyApplicationPortGroups(portsGroupName);
	    GetTableColumn tcfp = new GetTableColumn(fpColumnHeader);
	    GetTableColumn tctp = new GetTableColumn(tpColumnHeader);
	    
	    
	    defensepro.classes.analyze(tcfp);
	    defensepro.classes.analyze(tctp);
	    
	    String gcfp = tcfp.getColumn()[0];
	    String gctp = tctp.getColumn()[0];

	    if (fromL4Port != null) {
			if (!fromL4Port.toString().equals(gcfp.toString())) {
				ListenerstManager.getInstance().report("FAIL : From Port: " + fromL4Port + " but expected: " + gcfp.toString(), Reporter.FAIL);
				passed = false;
			}
	    }
	    
	    if (toL4Port != null) {
			if (!toL4Port.toString().equals(gctp.toString())) {
				ListenerstManager.getInstance().report("FAIL : To Port: " + toL4Port + " but expected: " + gctp.toString(), Reporter.FAIL);
				passed = false;
			}
	    }
	    
		if (passed) {
			if (fromL4Port != null)
				ListenerstManager.getInstance().report("Pass : From Port: " + fromL4Port + " expected: " + gcfp.toString());
			if (toL4Port != null)
				ListenerstManager.getInstance().report("Pass : To Port: " + toL4Port + " expected: " + gctp.toString());
		}

	}
	
	
	@Before
	public void setUp() throws Exception {
		ListenerstManager.getInstance().startLevel("Setup");
		defensepro = DpRadwareTestCase.getDefenseProInstance();
		ListenerstManager.getInstance().report("in setup...");
		ListenerstManager.getInstance().stopLevel();
	}

	public void tearDown() {

	}

	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}


	public String getPortsGroupName() {
		return portsGroupName;
	}


	public void setPortsGroupName(String portsGroupName) {
		this.portsGroupName = portsGroupName;
	}


	public String getToL4Port() {
		return toL4Port;
	}


	public void setToL4Port(String toL4Port) {
		this.toL4Port = toL4Port;
	}


	public String getFromL4Port() {
		return fromL4Port;
	}


	public void setFromL4Port(String fromL4Port) {
		this.fromL4Port = fromL4Port;
	}
	
	
}
