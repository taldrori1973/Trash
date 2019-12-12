package com.radware.vision.tests.dp.accesscontrol;

import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.blackandwhitelists.whitelist.WhiteList;
import com.radware.vision.tests.dp.DpTestBase;
import com.radware.vision.tests.dp.accesscontrol.enums.ProtocolType;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class WhiteListTest extends DpTestBase{
	
	private String WhiteListName;
	private String Description;
	private String SourceNetwork;
	private String SourcePort;
	private String DestinationNetwork;
	private String DestinationPort;
	private String PhysicalPorts;
	private String VLANTag;
    private ProtocolType Protocol = ProtocolType.ANY;
    private com.radware.vision.tests.dp.accesscontrol.enums.Direction Direction = com.radware.vision.tests.dp.accesscontrol.enums.Direction.ONE_DIRECTIONAL;
    private boolean bypassAllModules = true;
    private boolean bypassAntiScanning = true;
    private boolean bypassHTTPFlood = true;
    private boolean bypassSYNProtection = true;
    private boolean bypassSignatureProtection = true;
    private boolean bypassServerCracking = true;
    private String Action;


    @Test
    @TestProperties(name = "Delete White List Profile", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "WhiteListName"})
    public void deleteWhiteListProfile() throws Exception {
		WhiteList whiteListProfile = dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mWhiteList();
		whiteListProfile.openPage();
		whiteListProfile.deleteWhiteListByKeyValue("Name", WhiteListName);
	}
	
	
	@Test
    @TestProperties(name = "Create White List Profile-web", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "WhiteListName", "Description", "SourceNetwork",
            "SourcePort", "DestinationNetwork", "DestinationPort", "PhysicalPorts", "VLANTag", "Protocol", "Direction",
            "bypassAllModules", "bypassAntiScanning", "bypassHTTPFlood", "bypassSYNProtection", "Action"})
    public void createWhiteListProfile() throws Exception {
		
//		//TO DO problem on navigation.
		WhiteList whiteListProfile = dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mWhiteList();
		whiteListProfile.openPage();
		whiteListProfile.addWhiteList();
		if (WhiteListName !=null){
		whiteListProfile.setWhiteListName(WhiteListName);}
		if (Description !=null){
		whiteListProfile.setWhiteListDescription(Description);}

        if (SourceNetwork != null) {
            whiteListProfile.selectSourceNetwork(SourceNetwork);
        }
        if (SourcePort != null) {
            whiteListProfile.selectSourcePort(SourcePort);
        }

        if (DestinationNetwork != null) {
            whiteListProfile.selectDestinationNetwork(DestinationNetwork);
        }
        if (DestinationPort != null) {
            whiteListProfile.selectDestinationPort(DestinationPort);
        }
        if (PhysicalPorts != null) {
            whiteListProfile.selectPhysicalPorts(PhysicalPorts);
        }
        if (VLANTag != null) {
            whiteListProfile.selectVLANTag(VLANTag);
        }
        if (Protocol != null) {
            whiteListProfile.selectProtocol(Protocol.getProtocolType());
        }
        if (Direction != null) {
            whiteListProfile.selectDirection(Direction.getDirection());
        }

        if (bypassAllModules) {
            whiteListProfile.enableBypassAllModules();
        } else {
            whiteListProfile.disableBypassAllModules();
        }
        if (bypassAntiScanning) {
            whiteListProfile.enableBypassAntiScanning();
        } else {
            whiteListProfile.disableBypassAntiScanning();
        }
        if (bypassHTTPFlood) {
            whiteListProfile.enableBypassHTTPFlood();
        } else {
            whiteListProfile.disableBypassHTTPFlood();
        }

        if (bypassSYNProtection) {
            whiteListProfile.enableBypassSYNProtection();
        } else {
            whiteListProfile.enableBypassSYNProtection();
        }

        if (bypassSignatureProtection) {
            whiteListProfile.enableBypassSignatureProtection();
        }

        if (bypassServerCracking) {
            whiteListProfile.enableBypassServerCracking();
        } else {
            whiteListProfile.disableBypassServerCracking();
        }
        whiteListProfile.submit();
	}
	

	public String getWhiteListName() {
		return WhiteListName;
	}

	public void setWhiteListName(String whiteListName) {
		WhiteListName = whiteListName;
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

    public com.radware.vision.tests.dp.accesscontrol.enums.Direction getDirection() {
        return Direction;
    }

    public void setDirection(com.radware.vision.tests.dp.accesscontrol.enums.Direction direction) {
        Direction = direction;
    }

    public boolean isBypassAllModules() {
        return bypassAllModules;
    }

    public void setBypassAllModules(boolean bypassAllModules) {
        this.bypassAllModules = bypassAllModules;
    }

    public boolean isBypassAntiScanning() {
        return bypassAntiScanning;
    }

    public void setBypassAntiScanning(boolean bypassAntiScanning) {
        this.bypassAntiScanning = bypassAntiScanning;
    }

    public boolean isBypassHTTPFlood() {
        return bypassHTTPFlood;
    }

    public void setBypassHTTPFlood(boolean bypassHTTPFlood) {
        this.bypassHTTPFlood = bypassHTTPFlood;
    }

    public boolean isBypassSYNProtection() {
        return bypassSYNProtection;
    }

    public void setBypassSYNProtection(boolean bypassSYNProtection) {
        this.bypassSYNProtection = bypassSYNProtection;
    }

    public boolean isBypassSignatureProtection() {
        return bypassSignatureProtection;
    }

    public void setBypassSignatureProtection(boolean bypassSignatureProtection) {
        this.bypassSignatureProtection = bypassSignatureProtection;
    }

    public boolean isBypassServerCracking() {
        return bypassServerCracking;
    }

    public void setBypassServerCracking(boolean bypassServerCracking) {
        this.bypassServerCracking = bypassServerCracking;
    }

    public String getAction() {
        return Action;
	}
	public void setAction(String action) {
		Action = action;
	}

}
