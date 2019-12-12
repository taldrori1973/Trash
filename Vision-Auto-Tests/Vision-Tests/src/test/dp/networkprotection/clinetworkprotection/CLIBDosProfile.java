package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import org.junit.Before;
import org.junit.Test;

import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;
import junit.framework.SystemTestCase4;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

public class CLIBDosProfile extends SystemTestCase4 {

	private String profileName;
	private String InboundTraffic;
	private String OutboundTraffic;
	private String UDPPacketRateDetectionSensitivity;
	private DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify BDOS Profile", paramsInclude = { "qcTestId", "profileName", "InboundTraffic", "OutboundTraffic",
			"UDPPacketRateDetectionSensitivity" })
	public void BDosProfileTest() throws Exception {

		Integer inboundTraffic = defensepro.dp.getDpBdosProfileBandIn(profileName);
		Integer outboundTraffic = defensepro.dp.getDpBdosProfileBandOut(profileName);

		boolean passed = true;

		if (InboundTraffic != null) {
			if (!inboundTraffic.toString().equals(InboundTraffic)) {
				ListenerstManager.getInstance().report("FAIL : InboundTraffic: " + inboundTraffic + " but expected: " + InboundTraffic, Reporter.FAIL);
				passed = false;
			}
		}

		if (OutboundTraffic != null) {
			if (!outboundTraffic.toString().equals(OutboundTraffic)) {
				ListenerstManager.getInstance().report("FAIL : OutboundTraffic: " + outboundTraffic + " but expected: " + OutboundTraffic, Reporter.FAIL);
				passed = false;
			}
		}

		if (passed) {
			if (InboundTraffic != null)
				ListenerstManager.getInstance().report("Pass : InboundTraffic: " + inboundTraffic + " expected: " + InboundTraffic);
			if (OutboundTraffic != null)
				ListenerstManager.getInstance().report("Pass : OutboundTraffic: " + outboundTraffic + " expected: " + OutboundTraffic);
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

	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	public String getInboundTraffic() {
		return InboundTraffic;
	}

	public void setInboundTraffic(String inboundTraffic) {
		InboundTraffic = inboundTraffic;
	}

	public String getOutboundTraffic() {
		return OutboundTraffic;
	}

	public void setOutboundTraffic(String outboundTraffic) {
		OutboundTraffic = outboundTraffic;
	}

	public String getUDPPacketRateDetectionSensitivity() {
		return UDPPacketRateDetectionSensitivity;
	}

	public void setUDPPacketRateDetectionSensitivity(String uDPPacketRateDetectionSensitivity) {
		UDPPacketRateDetectionSensitivity = uDPPacketRateDetectionSensitivity;
	}

}
