package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.bdosprofiles.BDoSProfiles;
import com.radware.vision.tests.dp.DpTestBase;
import com.radware.vision.tests.dp.networkprotection.enums.UDPPacketRateDetectionSensitivityTypes;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class BDOSProfileTest extends DpTestBase{
	
	private String profileName;
	private String InboundTraffic;
	private String OutboundTraffic;
    private UDPPacketRateDetectionSensitivityTypes UDPPacketRateDetectionSensitivity = UDPPacketRateDetectionSensitivityTypes.LOW;
	
	@Test
    @TestProperties(name = "Delete BDOS Profile", paramsInclude = {"qcTestId", "deviceName", "profileName"})
	public void deleteBDosProfile() throws Exception {
		BDoSProfiles bdosProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mBDoSProfiles();
		bdosProfile.openPage();
		bdosProfile.deleteBDosProfileByKeyValue("Profile Name", profileName);
	}
	
	@Test
    @TestProperties(name = "Create BDOS Profile", paramsInclude = {"qcTestId", "deviceName", "profileName", "InboundTraffic", "OutboundTraffic",
			"UDPPacketRateDetectionSensitivity"} )
	public void createBDosProfile() throws Exception {
		
		BDoSProfiles bdosProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mBDoSProfiles();
		bdosProfile.openPage();
		bdosProfile.addBDosProfile();
		bdosProfile.setProfileName(profileName);
		bdosProfile.enableEnableTransparentOptimization();
		bdosProfile.enableSYNFlood();
		bdosProfile.enableTCP_ACK_FIN_Flood();
		bdosProfile.enableTCP_RST_Flood();
		bdosProfile.enableTCP_SYN_ACK_Flood();
		bdosProfile.enableTCPFragmentationFlood();
		bdosProfile.enableUDPFlood();
		bdosProfile.enableICMPFlood();
		bdosProfile.enableIGMPFlood();
		bdosProfile.setInboundTraffic(InboundTraffic);
		bdosProfile.setOutboundTraffic(OutboundTraffic);
		if(UDPPacketRateDetectionSensitivity!=null){
            bdosProfile.selectUDPPacketRateDetectionSensitivity(UDPPacketRateDetectionSensitivity.getType());
		}
		bdosProfile.enablePacketReport();
        //bdosProfile.enablePacketTrace();
		bdosProfile.submit();
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

    public UDPPacketRateDetectionSensitivityTypes getUDPPacketRateDetectionSensitivity() {
        return UDPPacketRateDetectionSensitivity;
    }

    public void setUDPPacketRateDetectionSensitivity(UDPPacketRateDetectionSensitivityTypes UDPPacketRateDetectionSensitivity) {
        this.UDPPacketRateDetectionSensitivity = UDPPacketRateDetectionSensitivity;
    }
}
