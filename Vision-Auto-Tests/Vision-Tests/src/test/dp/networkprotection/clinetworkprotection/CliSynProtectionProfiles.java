package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.junit.Before;
import org.junit.Test;

public class CliSynProtectionProfiles extends SystemTestCase4 {
	private String ProfileName;
	private String TCPAuthenticationMethod;
	private String HTTPAuthenticationStatus;
	private String HTTPAuthenticationMethod;
	private String TCPResetStatus;
	private DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify Syn Protection Profiles", paramsInclude = {
			"qcTestId", "ProfileName", "TCPAuthenticationMethod",
			"HTTPAuthenticationStatus", "HTTPAuthenticationMethod",
			"TCPResetStatus" })
	public void SynProtectionProfilesCliTest() throws Exception {

		boolean passed = true;

		defensepro.dp.getDpSynProtectionProfile(ProfileName);
		GetTextCounter counter;

		if (TCPAuthenticationMethod != null) {
			counter = new GetTextCounter("TCP Authentication Method.*");
			defensepro.dp.analyze(counter, false, false);
			if (counter.getCounter().equals(TCPAuthenticationMethod)) {
				report.step("Syn protection default profile tcp authentication method is as expected: "
						+ TCPAuthenticationMethod);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : TCP Authentication Method: "
								+ counter.getCounter() + " but expected: "
								+ TCPAuthenticationMethod, Reporter.FAIL);
				passed = false;
			}
		}
		if (HTTPAuthenticationStatus != null) {
			counter = new GetTextCounter("HTTP Authentication Status.*");
			defensepro.dp.analyze(counter, false, false);
			if (counter.getCounter().equals(HTTPAuthenticationStatus)) {
				report.step("HTTP Authentication Status is as expected: "
						+ HTTPAuthenticationStatus);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : HTTP Authentication Status: "
								+ counter.getCounter() + " but expected: "
								+ HTTPAuthenticationStatus, Reporter.FAIL);
				passed = false;
			}
		}
		if (HTTPAuthenticationMethod != null) {
			counter = new GetTextCounter("HTTP Authentication Method.*");
			defensepro.dp.analyze(counter, false, false);
			if (counter.getCounter().equals(HTTPAuthenticationMethod)) {
				report.step("Syn protection default profile tcp authentication method is as expected: "
						+ HTTPAuthenticationMethod);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : HTTP Authentication Method: "
								+ counter.getCounter() + " but expected: "
								+ HTTPAuthenticationMethod, Reporter.FAIL);
				passed = false;
			}
		}
		if (TCPResetStatus != null) {
			counter = new GetTextCounter("TCP-Reset Status.*");
			defensepro.dp.analyze(counter, false, false);
			if (counter.getCounter().equals(TCPResetStatus)) {
				report.step("TCP-Reset Status is as expected: "
						+ TCPResetStatus);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : TCP-Reset Status: "
								+ counter.getCounter() + " but expected: "
								+ TCPResetStatus, Reporter.FAIL);
				passed = false;
			}
		}
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
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

	public String getProfileName() {
		return ProfileName;
	}

	public void setProfileName(String profileName) {
		ProfileName = profileName;
	}

	public String getTCPAuthenticationMethod() {
		return TCPAuthenticationMethod;
	}

	public void setTCPAuthenticationMethod(String tCPAuthenticationMethod) {
		TCPAuthenticationMethod = tCPAuthenticationMethod;
	}

	public String getHTTPAuthenticationStatus() {
		return HTTPAuthenticationStatus;
	}

	public void setHTTPAuthenticationStatus(String hTTPAuthenticationStatus) {
		HTTPAuthenticationStatus = hTTPAuthenticationStatus;
	}

	public String getHTTPAuthenticationMethod() {
		return HTTPAuthenticationMethod;
	}

	public void setHTTPAuthenticationMethod(String hTTPAuthenticationMethod) {
		HTTPAuthenticationMethod = hTTPAuthenticationMethod;
	}

	public String getTCPResetStatus() {
		return TCPResetStatus;
	}

	public void setTCPResetStatus(String tCPResetStatus) {
		TCPResetStatus = tCPResetStatus;
	}

}
