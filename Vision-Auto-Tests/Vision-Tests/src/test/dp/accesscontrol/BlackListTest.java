package com.radware.vision.tests.dp.accesscontrol;

import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.blackandwhitelists.blacklist.BlackList;
import com.radware.vision.tests.dp.DpTestBase;
import com.radware.vision.tests.dp.accesscontrol.enums.*;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class BlackListTest extends DpTestBase {

	private String BlackListName;
	private String Description;
    private boolean enableDisableBlackList = true;
    private String SourceNetwork;
	private String SourcePort;
	private String DestinationNetwork;
	private String DestinationPort;
	private String PhysicalPorts;
	private String VLANTag;
    private ProtocolType Protocol = ProtocolType.ANY;
    private Direction direction = Direction.BI_DIRECTIONAL;
    private com.radware.vision.tests.dp.accesscontrol.enums.Hours hours = Hours._0;
    private Minutes minutes = Minutes._0;
    private boolean enableDynamic = true;
    private DetectorSecurityModules detectorSecurityModules = DetectorSecurityModules.ADMIN;
    private String detectorIpAddress = "0.0.0.0";
    private String OriginatedIP;
	private String Action;
    private boolean reportEnabled = true;
    private boolean packetReportEnabled = true;

	@Test
    @TestProperties(name = "Delete Black List Profile", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "BlackListName"})
    public void deleteBlackListProfile() throws Exception {
		BlackList blackListProfile = dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mBlackList();
		blackListProfile.openPage();
		blackListProfile.deleteBlackListByKeyValue("Name", BlackListName);
	}

	@Test
    @TestProperties(name = "Create Black List Profile", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "BlackListName", "enableDisableBlackList", "Description", "SourceNetwork", "SourcePort",
            "DestinationNetwork", "DestinationPort", "PhysicalPorts", "VLANTag", "Protocol", "direction", "hours", "minutes", "enableDynamic", "detectorSecurityModules",
            "detectorIpAddress", "Action", "reportEnabled", "packetReportEnabled"})
    public void createBlackListProfile() throws Exception {
        
   		BlackList blackListProfile = dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mBlackList();
		blackListProfile.openPage();
		blackListProfile.addBlackList();
		if (BlackListName != null) {
			blackListProfile.setBlackListName(BlackListName);
		}
		if (Description != null) {
			blackListProfile.setBlackListDescription(Description);
		}

		if (SourceNetwork != null) {
			blackListProfile.selectSourceNetwork(SourceNetwork);
		}
		if (SourcePort != null) {
			blackListProfile.selectSourcePort(SourcePort);
		}
		if (DestinationNetwork != null) {
			blackListProfile.selectDestinationNetwork(DestinationNetwork);
		}
		if (DestinationPort != null) {
			blackListProfile.selectDestinationPort(DestinationPort);
		}
		if (PhysicalPorts != null) {
			blackListProfile.selectPhysicalPorts(PhysicalPorts);
		}
		if (VLANTag != null) {
			blackListProfile.selectVLANTag(VLANTag);
		}
		if (Protocol != null) {
            blackListProfile.selectProtocol(Protocol.getProtocolType());
        }
        if (direction != null) {
            blackListProfile.selectDirection(direction.getDirection());
        }
        if (hours != null) {
            blackListProfile.selectHours(hours.getHours());
        }
        if (minutes != null) {
            blackListProfile.selectHours(minutes.getMinutes());
        }
        if (detectorSecurityModules != null) {
            blackListProfile.selectOriginatedModule(detectorSecurityModules.getDetectorSecurityModule());
        }
        if (detectorIpAddress != null) {
            blackListProfile.setOriginatedIP(detectorIpAddress);
        }
        if (enableDynamic) {
            blackListProfile.enableDynamic();
        } else {
            blackListProfile.disableDynamic();
        }
        if (enableDisableBlackList) {
            blackListProfile.enable();
        } else {
            blackListProfile.disable();
        }
        if (reportEnabled) {
            blackListProfile.enableReport();
        } else {
            blackListProfile.disableReport();
        }
        if (packetReportEnabled) {
            blackListProfile.enablePacketReport();
        } else {
            blackListProfile.disablePacketReport();
        }

		blackListProfile.submit();

	}

    public boolean isReportEnabled() {
        return reportEnabled;
    }

    public void setReportEnabled(boolean reportEnabled) {
        this.reportEnabled = reportEnabled;
    }

    public boolean isPacketReportEnabled() {
        return packetReportEnabled;
    }

    public void setPacketReportEnabled(boolean packetReportEnabled) {
        this.packetReportEnabled = packetReportEnabled;
    }

    public DetectorSecurityModules getDetectorSecurityModules() {
        return detectorSecurityModules;
    }

    public void setDetectorSecurityModules(DetectorSecurityModules detectorSecurityModules) {
        this.detectorSecurityModules = detectorSecurityModules;
    }

    public String getDetectorIpAddress() {
        return detectorIpAddress;
    }

    public void setDetectorIpAddress(String detectorIpAddress) {
        this.detectorIpAddress = detectorIpAddress;
    }

    public boolean isEnableDisableBlackList() {
        return enableDisableBlackList;
    }

    public void setEnableDisableBlackList(boolean enableDisableBlackList) {
        this.enableDisableBlackList = enableDisableBlackList;
    }

    public boolean isEnableDynamic() {
        return enableDynamic;
    }

    public void setEnableDynamic(boolean enableDynamic) {
        this.enableDynamic = enableDynamic;
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }

    public String getBlackListName() {
        return BlackListName;
	}



	public void setBlackListName(String blackListName) {
		BlackListName = blackListName;
	}

    public Hours getHours() {
        return hours;
    }

    public void setHours(Hours hours) {
        this.hours = hours;
    }

    public Minutes getMinutes() {
        return minutes;
    }

    public void setMinutes(Minutes minutes) {
        this.minutes = minutes;
    }

    public String getDescription() {
        return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getSourceNetwork() {
		return SourceNetwork;
	}

	public void setSourceNetwork(String sourceNetwork) {
		SourceNetwork = sourceNetwork;
	}

	public String getSourcePort() {
		return SourcePort;
	}

	public void setSourcePort(String sourcePort) {
		SourcePort = sourcePort;
	}

	public String getDestinationNetwork() {
		return DestinationNetwork;
	}

	public void setDestinationNetwork(String destinationNetwork) {
		DestinationNetwork = destinationNetwork;
	}

	public String getDestinationPort() {
		return DestinationPort;
	}

	public void setDestinationPort(String destinationPort) {
		DestinationPort = destinationPort;
	}

	public String getPhysicalPorts() {
		return PhysicalPorts;
	}

	public void setPhysicalPorts(String physicalPorts) {
		PhysicalPorts = physicalPorts;
	}

	public String getVLANTag() {
		return VLANTag;
	}

	public void setVLANTag(String vLANTag) {
		VLANTag = vLANTag;
	}

    public ProtocolType getProtocol() {
        return Protocol;
    }

    public void setProtocol(ProtocolType protocol) {
        Protocol = protocol;
    }

    public String getOriginatedIP() {
        return OriginatedIP;
	}

	public void setOriginatedIP(String originatedIP) {
		OriginatedIP = originatedIP;
	}

	public String getAction() {
		return Action;
	}

	public void setAction(String action) {
		Action = action;
	}

}
