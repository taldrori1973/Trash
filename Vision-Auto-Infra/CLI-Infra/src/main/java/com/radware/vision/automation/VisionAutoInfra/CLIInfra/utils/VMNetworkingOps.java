package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.licensekeys.MacAddressGenerator;
import com.vmware.vim25.*;
import com.vmware.vim25.mo.*;
import com.vmware.vim25.mox.VirtualMachineDeviceManager;
import com.vmware.vim25.ws.VimStub;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class VMNetworkingOps {
    private static final ManagedObjectReference SIMO_REF = new ManagedObjectReference();
    private ManagedObjectReference propCollector;
    private ManagedObjectReference rootFolder;
    private VimPortType vimPort;
    private ServiceContent serviceContent;
    private ServiceInstance serviceInstance;
    private static final String STR_SERVICE_INSTANCE = "ServiceInstance";
    private static final String ADD = "add";
    private static final String REMOVE = "remove";
    private static final String CHANGE = "change";
    private static final String PRINT = "print";
    private static final String COMMA = ",";
    private static final String E1000 = "e1000";
    private static final String PCNET32 = "pcnet32";
    private static final String VMXNET2 = "vmxnet2";
    private static final String VMXNET3 = "vmxnet3";
    private String vimHost;
    private String userName;
    private String password;
    private String hostIp;
    private VimStub vimStub;

    /**
     * Set the managed object reference type, and value to
     * ServiceInstance
     */
    private static void initSIMORef() {
        SIMO_REF.setType(STR_SERVICE_INSTANCE);
        SIMO_REF.set_value(STR_SERVICE_INSTANCE);
    }

    /**
     * @param targetUrl The URL of the Virtual Center Server
     *                  <p>
     *                  https://<Server IP / host name>/sdk
     *                  <p>
     *                  The method establishes connection with the web service port on the server.
     *                  This is not to be confused with the session connection.
     */

    public VMNetworkingOps(String targetUrl, String hostIp, String username, String password) {
        this.userName = username;
        this.password = password;
        this.vimHost = targetUrl;
        this.hostIp = hostIp;
        BaseTestUtils.reporter.report("usernmae: " + username);
        BaseTestUtils.reporter.report("pass: " + password);
        initAll();
    }

    private void initVimPort(String targetUrl) {
        try {
            if (serviceInstance == null) {
                serviceInstance = new ServiceInstance(new URL(vimHost), userName, password, true);
            }
            vimPort = serviceInstance.getServerConnection().getVimService();

        } catch (MalformedURLException mue) {
            mue.printStackTrace();
        } catch (Exception se) {
            se.printStackTrace();
        }
    }

    /*
     * This method calls all the initialization methods required in order.
     */
    private void initAll() {
        //These following methods have to be called in this order.
        initSIMORef();
        initVimPort(vimHost);
        initServiceContent();
        try {
            connect(userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        initPropertyCollector();
        initRootFolder();
    }

    private void initServiceContent() {
        if (serviceContent == null) {
            try {
                if (serviceInstance == null) {
                    serviceInstance = new ServiceInstance(new URL(vimHost), userName, password, true);
                }
                serviceContent = serviceInstance.getServiceContent();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void initPropertyCollector() {
        if (propCollector == null) {
            try {
                propCollector = serviceContent.getPropertyCollector();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void initRootFolder() {
        if (rootFolder == null) {
            try {
                rootFolder = serviceContent.getRootFolder();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * @param uname The user name for the session
     * @param pword The password for the user
     *              <p>
     *              Establishes session with the virtual center server
     * @throws Exception
     */
    private void connect(String uname, String pword) throws Exception {
        int numOfRetries = 5;
        while (numOfRetries > 0) {
            try {
                UserSession login = vimPort.login(serviceContent.getSessionManager(), uname, pword, null);
                if (login != null) break;
            } catch (Exception e) {
                if (e.getMessage().equals("Cannot complete login due to an incorrect user name or password.")) {
                    numOfRetries--;
                    Thread.sleep(2 * 1000);
                } else {
                    throw new Exception(e.getMessage());
                }
            }
        }
    }

    /**
     * Disconnects the user session
     *
     * @throws Exception
     */
    private void disconnect() throws Exception {
        vimPort.logout(serviceContent.getSessionManager());
    }

    /**
     * @return TraversalSpec specification to get to the VirtualMachine managed object.
     */
    public TraversalSpec getVMTraversalSpec() {
        // Create a traversal spec that starts from the 'root' objects
        // and traverses the inventory tree to get to the VirtualMachines.
        // Build the traversal specs bottoms up


        //Traversal to get to the VM in a VApp
        TraversalSpec vAppToVM = new TraversalSpec();
        vAppToVM.setName("vAppToVM");
        vAppToVM.setType("VirtualApp");
        vAppToVM.setPath("vm");

        //Traversal spec for VApp to VApp
        TraversalSpec vAppToVApp = new TraversalSpec();
        vAppToVApp.setName("vAppToVApp");
        vAppToVApp.setType("VirtualApp");
        vAppToVApp.setPath("resourcePool");
        //SelectionSpec for VApp to VApp recursion
        SelectionSpec vAppRecursion = new SelectionSpec();
        vAppRecursion.setName("vAppToVApp");
        //SelectionSpec to get to a VM in the VApp
        //Since it is already defined earlier use it by its name
        //Can't use the same object
        SelectionSpec vmInVApp = new SelectionSpec();
        vmInVApp.setName("vAppToVM");
        //SelectionSpec for both VApp to VApp and VApp to VM
        SelectionSpec[] vAppToVMSS = new SelectionSpec[]{vAppRecursion, vmInVApp};
        vAppToVApp.setSelectSet(vAppToVMSS);

        //This SelectionSpec is used for recursion for Folder recursion
        SelectionSpec sSpec = new SelectionSpec();
        sSpec.setName("VisitFolders");

        // Traversal to get to the vmFolder from DataCenter
        TraversalSpec dataCenterToVMFolder = new TraversalSpec();
        dataCenterToVMFolder.setName("DataCenterToVMFolder");
        dataCenterToVMFolder.setType("Datacenter");
        dataCenterToVMFolder.setPath("vmFolder");
        dataCenterToVMFolder.setSkip(false);
        SelectionSpec[] sSpecs = new SelectionSpec[]{sSpec};
        dataCenterToVMFolder.setSelectSet(sSpecs);

        // TraversalSpec to get to the DataCenter from rootFolder
        TraversalSpec traversalSpec = new TraversalSpec();
        traversalSpec.setName("VisitFolders");
        traversalSpec.setType("Folder");
        traversalSpec.setPath("childEntity");
        traversalSpec.setSkip(false);
        SelectionSpec[] sSpecArr = new SelectionSpec[]{sSpec, dataCenterToVMFolder, vAppToVM, vAppToVApp};
        traversalSpec.setSelectSet(sSpecArr);

        return traversalSpec;
    }

    /**
     * @param vmName The name of the virtual machine
     * @return ManagedObjectReference to the virtual machine
     */
    public ManagedObjectReference getVMByName(String vmName) {
        ManagedObjectReference retVal = null;
        try {
            TraversalSpec tSpec = getVMTraversalSpec();
            // Create Property Spec
            PropertySpec propertySpec = new PropertySpec();
            propertySpec.setAll(Boolean.FALSE);
            propertySpec.setPathSet(new String[]{"name"});
            propertySpec.setType("VirtualMachine");
            PropertySpec[] propertySpecs = new PropertySpec[]{propertySpec};

            // Now create Object Spec
            ObjectSpec objectSpec = new ObjectSpec();
            objectSpec.setObj(rootFolder);
            objectSpec.setSkip(Boolean.TRUE);
            objectSpec.setSelectSet(new SelectionSpec[]{tSpec});
            ObjectSpec[] objectSpecs = new ObjectSpec[]{objectSpec};

            // Create PropertyFilterSpec using the PropertySpec and ObjectPec
            // created above.
            PropertyFilterSpec propertyFilterSpec = new PropertyFilterSpec();
            propertyFilterSpec.setPropSet(propertySpecs);
            propertyFilterSpec.setObjectSet(objectSpecs);

            PropertyFilterSpec[] propertyFilterSpecs = new PropertyFilterSpec[]{propertyFilterSpec};

            ObjectContent[] oCont = vimPort.retrieveProperties(propCollector, propertyFilterSpecs);
            if (oCont != null) {
                for (ObjectContent oc : oCont) {
                    ManagedObjectReference mr = oc.getObj();
                    String vmnm = null;
                    DynamicProperty[] dps = oc.getPropSet();
                    if (dps != null) {
                        for (DynamicProperty dp : dps) {
                            vmnm = (String) dp.getVal();
                        }
                    }

                    if (vmnm != null && vmnm.equals(vmName)) {
                        retVal = mr;
                        System.out.println("MOR Type : " + mr.getType());
                        break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return retVal;
    }

    public List<VirtualEthernetCard> getAllNics(VirtualMachine vm) throws RemoteException {
        List<VirtualEthernetCard> nics = new ArrayList<>();
        try {
            VirtualDevice[] devices = vm.getConfig().getHardware().getDevice();
            for (VirtualDevice device : devices) {
                if (device instanceof VirtualEthernetCard) {
                    nics.add((VirtualEthernetCard) device);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.reporter.report(e.getMessage(), Reporter.FAIL);
        }

        return nics;
    }

    /**
     * @param mor ManagedObjectReference of a managed object, specifically virtual machine
     * @return VirtualEthernetCard[] array of virtual machine ethernet card details
     */
    public VirtualEthernetCard[] getVMNics(ManagedObjectReference mor) {
        VirtualEthernetCard[] retVal = null;
        try {
            // Create Property Spec
            PropertySpec propertySpec = new PropertySpec();
            propertySpec.setAll(Boolean.FALSE);
            propertySpec.setPathSet(new String[]{"config.hardware"});
            propertySpec.setType("VirtualMachine");
            PropertySpec[] propertySpecs = new PropertySpec[]{propertySpec};

            // Now create Object Spec
            ObjectSpec objectSpec = new ObjectSpec();
            objectSpec.setObj(mor);
            ObjectSpec[] objectSpecs = new ObjectSpec[]{objectSpec};

            // Create PropertyFilterSpec using the PropertySpec and ObjectPec
            // created above.
            PropertyFilterSpec propertyFilterSpec = new PropertyFilterSpec();
            propertyFilterSpec.setPropSet(propertySpecs);
            propertyFilterSpec.setObjectSet(objectSpecs);

            PropertyFilterSpec[] propertyFilterSpecs = new PropertyFilterSpec[]{propertyFilterSpec};

            VirtualHardware vmHardware = null;
            ObjectContent[] oCont = vimPort.retrieveProperties(serviceContent.propertyCollector, propertyFilterSpecs);
            if (oCont != null) {
                System.out.println("ObjectContent Length : " + oCont.length);
                for (ObjectContent oc : oCont) {
                    DynamicProperty[] dps = oc.getPropSet();
                    if (dps != null) {
                        for (DynamicProperty dp : dps) {
                            System.out.println(dp.getName() + " : " + dp.getVal());
                            vmHardware = (VirtualHardware) dp.getVal();
                        }
                    }
                }
            }

            if (vmHardware != null) {
                VirtualDevice[] vdArr = vmHardware.getDevice();
                List<VirtualEthernetCard> vmNicsList = new ArrayList<VirtualEthernetCard>();
                for (VirtualDevice vd : vdArr) {
                    if (vd != null) {
                        if (vd instanceof VirtualEthernetCard) {
                            vmNicsList.add((VirtualEthernetCard) vd);
                        }
                    }
                }

                retVal = new VirtualEthernetCard[vmNicsList.size()];
                retVal = vmNicsList.toArray(retVal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return retVal;
    }

    /**
     * @param vmnicArr Array of VirtualEthernetCard
     */
    public void printVMNicPortGroups(VirtualEthernetCard[] vmnicArr) {
        System.out.println("*******************************************************");
        for (VirtualEthernetCard vmnic : vmnicArr) {
            System.out.println("vmnic Info (Label) : " + vmnic.getDeviceInfo().getLabel());
            VirtualDeviceBackingInfo backing = vmnic.getBacking();
            if (backing != null) {
                if (backing instanceof VirtualEthernetCardNetworkBackingInfo) {
                    //backing = (VirtualEthernetCardNetworkBackingInfo)backing;
                    System.out.println("vmnic Port Group: " + ((VirtualEthernetCardNetworkBackingInfo) backing).getDeviceName());
                }
            }
            System.out.println();
        }
        System.out.println("*******************************************************");
    }

    /**
     * This method is used to change the portgroup of vmnics of a VM.
     *
     *
     * @param vm
     * @param vmNicName Array of VM network adapter names (label)
     * @param network   Name of the port group to which the vmnics are being changed to
     * @throws IOException
     */
    public void changeVMNicPortGroup(VirtualMachine vm, String[] vmNicName, String network, String containedDVS, boolean resetVMMachine) throws IOException {
        List<VirtualEthernetCard> allNics = getAllNics(vm);
        List<String> vmNicNameList = Arrays.asList(vmNicName);

        List<VirtualDevice> changeNicsList = new ArrayList<>();
        for (VirtualEthernetCard vmNic : allNics) {
            String vmNicAdapterLabel = vmNic.getDeviceInfo().getLabel();
            System.out.println("vmnic Info (Label) : " + vmNicAdapterLabel);

            if (vmNicNameList.contains(vmNicAdapterLabel)) {
                changeNicsList.add(vmNic);
            }
        }

        if (!changeNicsList.isEmpty()) {
            VirtualMachineConfigSpec vmcs = getVMReConfigSpecToChangePortGroup(changeNicsList.toArray(new VirtualDevice[changeNicsList.size()]), network, containedDVS);
            if (reconfigureVM(vmcs, vm)) {
                System.out.println(" Successfully changed the portgroup for the vmnic adapters");
            } else {
                System.out.println("Failed to change the portgroup for the vmnic adapters");
            }

        } else {
            System.out.println("No vmnic port groups are changed as the vmnic adapter names did not match");
        }
        if (resetVMMachine) {
            try {
                BaseTestUtils.reporter.startLevel("Reset VM Machine.");
                Task resetTask = vm.resetVM_Task();
                Object[] result;

                result = waitForValues(resetTask.getMOR(), new String[]{
                                "info.state", "info.error", "info.progress"},
                        new String[]{"state"}, // info has a property - state
                        // for state of the task
                        new Object[][]{new Object[]{TaskInfoState.success,
                                TaskInfoState.error}});

                if (result[0].equals(TaskInfoState.success)) {
                    BaseTestUtils.reporter.report("VM Reset Successful");
                } else {
                    BaseTestUtils.reporter.report("VM Reset Failed. Further tests may fail.", Reporter.WARNING);
                }
            } catch (Exception e) {
                BaseTestUtils.reporter.report("VM Reset Failed. Further tests may fail.", Reporter.WARNING);
            } finally {
                BaseTestUtils.reporter.startLevel("Finished Reset VM Machine.");
            }
        }
    }

    public String resetVm(VirtualMachine vm) throws Exception {
        Task resetTask = vm.resetVM_Task();
        return resetTask.waitForTask();
    }

    public VirtualMachine getVirtualMachine(String vmName) throws MalformedURLException, RemoteException {
        ServiceInstance si = new ServiceInstance(new URL(vimHost), userName, password, true);
        return (VirtualMachine) new InventoryNavigator(si.getRootFolder()).searchManagedEntity("VirtualMachine", vmName);
    }

    public ManagedObjectReference getMOReference(String vmName) throws MalformedURLException, RemoteException {
        return getVirtualMachine(vmName).getMOR();
    }

    public String getMacAddress(VirtualMachine vm) throws MalformedURLException, RemoteException {
        List<VirtualEthernetCard> allNics = getAllNics(vm);
        if (allNics != null) {
            for (VirtualEthernetCard ethernetCard : allNics) {
                VirtualDeviceBackingInfo backing = ethernetCard.getBacking();
                Description deviceInfo = ethernetCard.getDeviceInfo();
                String externalId = ethernetCard.getExternalId();
                String macAddress = ethernetCard.getMacAddress();
                if (macAddress != null) {
                    return macAddress;
                }
            }
        }
        return null;
    }

    public void setVMMacAddress(String vmName, String macAddr, String networkName) throws MalformedURLException, RemoteException {
        VirtualMachine virtualMachine = getVirtualMachine(vmName);
        ManagedObjectReference vmMor = virtualMachine.getMOR();

        VirtualEthernetCard[] vmNicArr = getVMNics(vmMor);

        List<String> modifiedMacAddr = MacAddressGenerator.generateMacAddrList(macAddr, 1, vmNicArr.length);
        for (int ethernetCardIdx = 0; ethernetCardIdx < 1; ethernetCardIdx++) {
            vmNicArr[ethernetCardIdx].setMacAddress(modifiedMacAddr.get(ethernetCardIdx));
            vmNicArr[ethernetCardIdx].setAddressType("manual");
        }

        HostSystem host = new HostSystem(virtualMachine.getServerConnection(), virtualMachine.getRuntime().getHost());
        ComputeResource cr = (ComputeResource) host.getParent();
        EnvironmentBrowser envBrowser = cr.getEnvironmentBrowser();
        ConfigTarget configTarget = envBrowser.queryConfigTarget(host);

        VirtualDeviceConfigSpec[] virtualDeviceConfigSpecsArr = new VirtualDeviceConfigSpec[vmNicArr.length];
        for (int i = 0; i < virtualDeviceConfigSpecsArr.length; i++) {
            VirtualMachineDeviceManager.VirtualNetworkAdapterType type = VirtualMachineDeviceManager.VirtualNetworkAdapterType.VirtualVmxnet3;
            virtualDeviceConfigSpecsArr[i] = createNicSpec(type, networkName, vmNicArr[i].getMacAddress(), false, true, configTarget);
            virtualDeviceConfigSpecsArr[i].operation = VirtualDeviceConfigSpecOperation.edit;
            virtualDeviceConfigSpecsArr[i].setDevice(vmNicArr[i]);
        }

        VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
        vmcs.setDeviceChange(virtualDeviceConfigSpecsArr);

        reconfigureVM(vmcs, virtualMachine);
    }

    public void setMemoryConfiguration(String vmName, String memorySize) throws MalformedURLException, RemoteException {
        VirtualMachine virtualMachine = getVirtualMachine(vmName);
        ManagedObjectReference vmMor = virtualMachine.getMOR();
        VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
        vmcs.setMemoryMB(Long.parseLong(memorySize));
        reconfigureVM(vmcs, virtualMachine);
    }


//    public void setVmNicIpAddress(String ipAddress, String networkName, int targetNicIndex) {
//        VirtualDeviceConfigSpec[] virtualDeviceConfigSpecsArr = new VirtualDeviceConfigSpec[1];
//        for(int i = 0; i < virtualDeviceConfigSpecsArr.length; i++) {
//            VirtualMachineDeviceManager.VirtualNetworkAdapterType type = VirtualMachineDeviceManager.VirtualNetworkAdapterType.VirtualVmxnet3;
//            virtualDeviceConfigSpecsArr[i] = createNicSpec(type, networkName, vmNicArr[i].getMacAddress(), false, true, configTarget);
//            virtualDeviceConfigSpecsArr[i].operation = VirtualDeviceConfigSpecOperation.edit;
//            virtualDeviceConfigSpecsArr[i].setDevice(vmNicArr[i]);
//        }
//
//        VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
//        vmcs.setDeviceChange(virtualDeviceConfigSpecsArr);
//
//        reconfigureVM(vmMor, vmcs);
//    }

    private VirtualDeviceConfigSpec createNicSpec(VirtualMachineDeviceManager.VirtualNetworkAdapterType adapterType, String networkName, String macAddress, boolean wakeOnLan, boolean startConnected, ConfigTarget configTarget) {
        VirtualDeviceConfigSpec result = null;
        DistributedVirtualPortgroupInfo dvPortgroupInfo = null;

        // Try vDS portgroup first
        if (configTarget.distributedVirtualPortgroup != null) {
            dvPortgroupInfo = findDVPortgroupInfo(configTarget.distributedVirtualPortgroup, networkName);
        }

        if (dvPortgroupInfo != null) {
            VirtualEthernetCardDistributedVirtualPortBackingInfo nicBacking = new VirtualEthernetCardDistributedVirtualPortBackingInfo();
            nicBacking.port = new DistributedVirtualSwitchPortConnection();
            nicBacking.port.portgroupKey = dvPortgroupInfo.portgroupKey;
            nicBacking.port.switchUuid = dvPortgroupInfo.switchUuid;
            result = createNicSpec(adapterType, macAddress, wakeOnLan, startConnected, nicBacking);
        } else {
            NetworkSummary netSummary = getHostNetworkSummaryByName(networkName, configTarget.network);
            VirtualEthernetCardNetworkBackingInfo nicBacking = new VirtualEthernetCardNetworkBackingInfo();
            nicBacking.network = netSummary.network;
            nicBacking.deviceName = netSummary.name;
            result = createNicSpec(adapterType, macAddress, wakeOnLan, startConnected, nicBacking);
        }
        return result;
    }

    private static NetworkSummary getHostNetworkSummaryByName(String networkName, VirtualMachineNetworkInfo[] hostNetworkList) {
        NetworkSummary result = null;
        boolean isNetworkExistingOnHost = false;

        // Check each of the provided network names against host networks to see if it exists on host
        for (VirtualMachineNetworkInfo netInfo : hostNetworkList) {
            if (networkName.equals(netInfo.name)) {
                isNetworkExistingOnHost = true;

                if (netInfo.network.accessible) {
                    result = netInfo.network;
                    break;
                } else {
                    throw new RuntimeException("Network: " + networkName + " is not accessible.");
                }
            }
        }
        if (!isNetworkExistingOnHost) {
            throw new RuntimeException("Network: " + networkName + " does not exist on host network.");
        }
        return result;
    }

    private static VirtualDeviceConfigSpec createNicSpec(VirtualMachineDeviceManager.VirtualNetworkAdapterType adapterType, String macAddress, boolean wakeOnLan, boolean startConnected, VirtualDeviceBackingInfo nicBacking) {
        VirtualDeviceConfigSpec result = new VirtualDeviceConfigSpec();

        VirtualEthernetCard device;
        switch (adapterType) {
            case VirtualVmxnet:
                device = new VirtualVmxnet();
                break;
            case VirtualVmxnet2:
                device = new VirtualVmxnet2();
                break;
            case VirtualVmxnet3:
                device = new VirtualVmxnet3();
                break;
            case VirtualPCNet32:
                device = new VirtualPCNet32();
                break;
            case VirtualE1000:
                device = new VirtualE1000();
                break;
            default:
                device = new VirtualVmxnet();
                break;
        }

        if (macAddress == null) {
            device.addressType = "generated";
        } else {
            device.addressType = "manual";
            device.macAddress = macAddress;
        }
        device.wakeOnLanEnabled = wakeOnLan;

        device.backing = nicBacking;
        device.connectable = new VirtualDeviceConnectInfo();
        device.connectable.connected = true;
        device.connectable.startConnected = startConnected;
        device.key = -1;

        result.operation = VirtualDeviceConfigSpecOperation.add;
        result.device = device;

        return result;
    }

    private static DistributedVirtualPortgroupInfo findDVPortgroupInfo(DistributedVirtualPortgroupInfo[] hostDistributedVirtualPortgroupInfo, String portgroupName) {
        DistributedVirtualPortgroupInfo result = null;

        if (hostDistributedVirtualPortgroupInfo != null) {
            for (DistributedVirtualPortgroupInfo portgroupInfo : hostDistributedVirtualPortgroupInfo) {
                if (portgroupInfo.portgroupName.equalsIgnoreCase(portgroupName)) {
                    result = portgroupInfo;
                    break;
                }
            }
        }
        return result;
    }

    private VirtualMachineConfigSpec getVMReConfigSpecToChangePortGroup(VirtualDevice[] vdArr, String network, String containedDVS) throws InvalidProperty, RuntimeFault, RemoteException, MalformedURLException {
        VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
        VirtualDeviceConfigSpec[] vdcsArr = new VirtualDeviceConfigSpec[vdArr.length];

        int i = 0;
        Network targetNetwork = getNetworkMO(network, containedDVS);
        for (VirtualDevice vd : vdArr) {
            if (vd instanceof VirtualEthernetCard) {
                vd.getConnectable().setConnected(true);
                vd.getConnectable().setStartConnected(true);
                VirtualEthernetCard virtDevice = (VirtualEthernetCard) vd;

                VirtualDeviceConfigSpec vdcs = new VirtualDeviceConfigSpec();
                vdcs.setOperation(VirtualDeviceConfigSpecOperation.edit);

                if (targetNetwork instanceof DistributedVirtualPortgroup) {

                    VirtualEthernetCardDistributedVirtualPortBackingInfo nicBacking = new VirtualEthernetCardDistributedVirtualPortBackingInfo();

                    DistributedVirtualSwitchPortConnection port = new DistributedVirtualSwitchPortConnection();
                    DistributedVirtualPortgroup vDSNetwork = (DistributedVirtualPortgroup) targetNetwork;
                    DVPortgroupConfigInfo configInfo = vDSNetwork.getConfig();
                    ManagedObjectReference distributedVirtualSwitchMOR = configInfo.getDistributedVirtualSwitch();

                    DistributedVirtualSwitch distributedVirtualSwitch = retrieveDistributedVirtualSwitch(containedDVS);
                    port.setSwitchUuid(distributedVirtualSwitch.getUuid());
                    port.setPortgroupKey(configInfo.getKey());

                    nicBacking.setPort(port);
                    virtDevice.setBacking(nicBacking);
                } else {
                    VirtualEthernetCardNetworkBackingInfo vdbi = new VirtualEthernetCardNetworkBackingInfo();
                    if (vdbi != null) {
                        if (vdbi instanceof VirtualEthernetCardNetworkBackingInfo) {
                            vdbi.setDeviceName(network);
                        }
                    }
                    vd.setBacking(vdbi);
                }
                vdcs.setDevice(vd);
                vdcsArr[i++] = vdcs;
            }
        }
        vmcs.setDeviceChange(vdcsArr);

        return vmcs;
    }

    private Network getNetworkMO(String networkName, String vSwitchName) throws InvalidProperty, RuntimeFault,
            RemoteException, MalformedURLException {

        ServiceInstance si = new ServiceInstance(new URL(vimHost), userName, password, true);
        HostSystem hostSystem = (HostSystem) si.getSearchIndex().findByIp(null, hostIp, false);
        Network net = null;

        if (vSwitchName != null) {
            DistributedVirtualSwitch foundDistributedVirtualSwitch = retrieveDistributedVirtualSwitch(vSwitchName);
            if (foundDistributedVirtualSwitch != null) {
                DistributedVirtualPortgroup[] portGroups = foundDistributedVirtualSwitch.getPortgroup();
                for (int i = 0; i < portGroups.length; i++) {
                    if (portGroups[i].getConfig().getName().equals(networkName)) {
                        return portGroups[i];
                    }
                }
            } else {
                throw new IllegalStateException("Network '" + networkName + "' under Distributed Virtual Switch '" + vSwitchName + "' was not found.");
            }
        } else {
            for (Network network : hostSystem.getNetworks()) {
                if (network.getName().equals(networkName)) {
                    net = network;
                    break;
                }
            }
            if (net == null) {
                throw new IllegalStateException("Network '" + networkName + "' was not found.");
            }
        }

        return net;
    }

    private DistributedVirtualSwitch retrieveDistributedVirtualSwitch(String dvsName) throws NotFound, RuntimeFault, RemoteException, MalformedURLException {
        ServiceInstance si = new ServiceInstance(new URL(vimHost), userName, password, true);
        HostSystem hostSystem = (HostSystem) si.getSearchIndex().findByIp(null, hostIp, false);
        HostNetworkInfo hostNetworkInfo = hostSystem.getHostNetworkSystem().getNetworkInfo();
        HostProxySwitch[] hostProxySwitches = hostNetworkInfo.getProxySwitch();

        DistributedVirtualSwitch foundDistributedVirtualSwitch = null;
        for (int i = 0; i < hostProxySwitches.length; i++) {
            DistributedVirtualSwitchManager dVSM = si.getDistributedVirtualSwitchManager();
            DistributedVirtualSwitch dVS = dVSM.queryDvsByUuid(hostProxySwitches[i].getDvsUuid());
            if (dVS != null) {
                DVSConfigInfo dvsConfigInfo = dVS.getConfig();
                if (dvsConfigInfo.getName().equals(dvsName)) {
                    foundDistributedVirtualSwitch = dVS;
                }
            }
        }

        return foundDistributedVirtualSwitch;
    }


    /**
     * This method is used to change the portgroup of vmnics of a VM.
     *
     * @param vmName Name of the virtual machine
     * @param vmNicName Array of VM network adapter names (label)
     * @param portGroupName Name of the port group to which the vmnics are being changed to
     *
     */
   /* public static void addVMNic(String vmName, String adapterType, String portGroupName) {
        ManagedObjectReference vmMor = getVMByName(vmName);

        VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
        VirtualDeviceConfigSpec[] vdcsArr = new VirtualDeviceConfigSpec[1];

        VirtualDeviceConfigSpec vdcs = new VirtualDeviceConfigSpec();
        vdcs.setOperation(VirtualDeviceConfigSpecOperation.add);
        //Create defalut E1000 adapter
        VirtualEthernetCard vd = new VirtualE1000();

        if (adapterType.equalsIgnoreCase(PCNET32)) {
            vd = new VirtualPCNet32();
        } else if (adapterType.equalsIgnoreCase(VMXNET2)) {
            vd = new VirtualVmxnet2();
        } else if (adapterType.equalsIgnoreCase(VMXNET3)) {
            vd = new VirtualVmxnet3();
        }

        if (portGroupName != null) {
            VirtualEthernetCardNetworkBackingInfo vddbi = new VirtualEthernetCardNetworkBackingInfo();
            vddbi.setDeviceName(portGroupName);
            vd.setBacking(vddbi);
        }

        //You can set any arbitrary key during the creation as long as it is not in use.
        //But need the server generated key for removal and editing.
        vd.setKey(-100);

        VirtualDeviceConnectInfo vdci = new VirtualDeviceConnectInfo();
        vdci.setAllowGuestControl(true);
        vdci.setStartConnected(true);
        vdci.setConnected(true);
        vd.setConnectable(vdci);

        vdcs.setDevice(vd);

        vdcsArr[0] = vdcs;
        vmcs.setDeviceChange(vdcsArr);

        if (reconfigureVM(vmMor, vmcs)) {
            System.out.println("Successfully added a vmnic adapter to the VM");
        } else {
            System.out.println("Failed to add the vmnic adapter to the VM");
        }
    }*/

    /**
     * This method is used to change the portgroup of vmnics of a VM.
     * <p>
     * //     * @param vmName Name of the virtual machine
     * //     * @param vmNicName Array of VM network adapter names (label)
     */
    /*public static void removeVMNic(String vmName, String vmNicName) {
        ManagedObjectReference vmMor = getVMByName(vmName);
        VirtualEthernetCard[] vmNicArr = getVMNics(vmMor);

        for (VirtualEthernetCard vmNic : vmNicArr) {
            String vmNicAdapterLabel = vmNic.getDeviceInfo().getLabel();
            System.out.println("vmnic Info (Label) : " + vmNicAdapterLabel);

            if (vmNicAdapterLabel.equalsIgnoreCase(vmNicName)) {
                VirtualMachineConfigSpec vmcs = new VirtualMachineConfigSpec();
                VirtualDeviceConfigSpec[] vdcsArr = new VirtualDeviceConfigSpec[1];

                VirtualDeviceConfigSpec vdcs = new VirtualDeviceConfigSpec();
                vdcs.setOperation(VirtualDeviceConfigSpecOperation.remove);
                vdcs.setDevice((VirtualDevice)vmNic);
                vdcsArr[0] = vdcs;
                vmcs.setDeviceChange(vdcsArr);

                if (reconfigureVM(vmMor, vmcs)) {
                    System.out.println("Successfully removed the vmnic adapter from the VM");
                } else {
                    System.out.println("Failed to removed the vmnic adapter from the VM");
                }
            }
        }
    }*/
    public boolean reconfigureVM(VirtualMachineConfigSpec vmcs, VirtualMachine vm) {
        String result = null;
        try {
            Task cssTask = vm.reconfigVM_Task(vmcs);
            result = cssTask.waitForTask();

        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to reconfigure VM: " + e.getMessage(), Reporter.FAIL);
        }

        return result.equals(Task.SUCCESS);
    }

    /************************************************************/
    /**
     * Handle Updates for a single object.
     * waits till expected values of properties to check are reached
     * Destroys the ObjectFilter when done.
     *
     * @param objmor       MOR of the Object to wait for</param>
     * @param filterProps  Properties list to filter
     * @param endWaitProps Properties list to check for expected values
     *                     these be properties of a property in the filter properties list
     * @param expectedVals values for properties to end the wait
     * @return true indicating expected values were met, and false otherwise
     */
    public Object[] waitForValues(
            ManagedObjectReference objmor, String[] filterProps,
            String[] endWaitProps, Object[][] expectedVals) throws Exception {
        // version string is initially null
        String version = "";
        Object[] endVals = new Object[endWaitProps.length];
        Object[] filterVals = new Object[filterProps.length];

        PropertyFilterSpec spec = new PropertyFilterSpec();
        spec.setObjectSet(new ObjectSpec[]{new ObjectSpec()});
        (spec.getObjectSet()[0]).setObj(objmor);

        spec.setPropSet(new PropertySpec[]{new PropertySpec()});
        spec.getPropSet()[0].setPathSet(filterProps);
        spec.getPropSet()[0].setType(objmor.getType());

        spec.getObjectSet()[0].setSelectSet(null);
        spec.getObjectSet()[0].setSkip(Boolean.FALSE);

        ManagedObjectReference filterSpecRef = vimPort.createFilter(propCollector, spec, true);

        boolean reached = false;

        UpdateSet updateset = null;
        PropertyFilterUpdate[] filtupary = null;
        PropertyFilterUpdate filtup = null;
        ObjectUpdate[] objupary = null;
        ObjectUpdate objup = null;
        PropertyChange[] propchgary = null;
        PropertyChange propchg = null;
        while (!reached) {
            updateset =
                    vimPort.waitForUpdates(propCollector, version);

            version = updateset.getVersion();

            if (updateset == null || updateset.getFilterSet() == null) {
                continue;
            }

            // Make this code more general purpose when PropCol changes later.
            filtupary = updateset.getFilterSet();
            filtup = null;
            for (int fi = 0; fi < filtupary.length; fi++) {
                filtup = filtupary[fi];
                objupary = filtup.getObjectSet();
                objup = null;
                propchgary = null;
                for (int oi = 0; oi < objupary.length; oi++) {
                    objup = objupary[oi];

                    // TODO: Handle all "kind"s of updates.
                    if (objup.getKind() == ObjectUpdateKind.modify ||
                            objup.getKind() == ObjectUpdateKind.enter ||
                            objup.getKind() == ObjectUpdateKind.leave) {
                        propchgary = objup.getChangeSet();
                        for (int ci = 0; ci < propchgary.length; ci++) {
                            propchg = propchgary[ci];
                            updateValues(endWaitProps, endVals, propchg);
                            updateValues(filterProps, filterVals, propchg);
                        }
                    }
                }
            }

            Object expctdval = null;
            // Check if the expected values have been reached and exit the loop if done.
            // Also exit the WaitForUpdates loop if this is the case.
            for (int chgi = 0; chgi < endVals.length && !reached; chgi++) {
                for (int vali = 0; vali < expectedVals[chgi].length && !reached; vali++) {
                    expctdval = expectedVals[chgi][vali];

                    reached = expctdval.equals(endVals[chgi]) || reached;
                }
            }
        }

        // Destroy the filter when we are done.
        vimPort.destroyPropertyFilter(filterSpecRef);

        return filterVals;
    }

    protected static void updateValues(String[] props, Object[] vals, PropertyChange propchg) {
        for (int findi = 0; findi < props.length; findi++) {
            if (propchg.getName().lastIndexOf(props[findi]) >= 0) {
                if (propchg.getOp() == PropertyChangeOp.remove) {
                    vals[findi] = "";
                } else {
                    vals[findi] = propchg.getVal();
                    //System.out.println("Changed value : " + propchg.getVal());
                }
            }
        }
    }

    /******************************************************************************/

    /**
     * This method prints the command line argument details for this program.
     */
    private void printUsage() {
        System.out.println("Usage: java VMNetworkingOps <server> <username> <password> <vmName> <print|add|change|remove> <adapterType|vmNicNames> <targetPortGroup>");
        System.out.println("Usage: <print|add|change> either to print the vmnic details or to change");
        System.out.println("Usage: add requires the last two arguments");
        System.out.println("Usage: add uses the next argument as adapter type");
        System.out.println("Usage: valid value for adapter type are: e1000,pcnet32,vmxnet2,vmxnet3");
        System.out.println("Usage: remove requires the next argument as vmNicName");
        System.out.println("Usage: change requires the last two arguments");
        System.out.println("Usage: vmNicNames should match the deviceInfo.label property");
        System.out.println("Usage: Typically these are like \"Network adapter 1\", \"Network adapter 2\" etc.");
        System.out.println("Usage: vmNicNames should be comma separated, no white space after comma");
    }

}
