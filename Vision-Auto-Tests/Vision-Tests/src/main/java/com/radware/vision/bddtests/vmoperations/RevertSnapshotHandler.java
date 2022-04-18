package com.radware.vision.bddtests.vmoperations;

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.dtos.CliConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.EnvironmentDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.remotessh.RemoteSshCommandsTests;

import java.lang.reflect.Constructor;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class RevertSnapshotHandler implements Runnable{

    private final String vmName;
    private final String snapshot;
    private final EnvironmentDto environment;
    private final HashMap<String, ServerCliBase> serverCliHM;

    private VisionRadwareFirstTime radwareFirstTime;

    // KVM
    public RevertSnapshotHandler(String vmName, String snapshot, EnvironmentDto environment, HashMap<String, ServerCliBase> serverCliHM)
    {
        this.vmName = vmName;
        this.snapshot = snapshot;
        this.environment = environment;
        this.serverCliHM = serverCliHM;
    }
    // OVA
    public RevertSnapshotHandler(String vmName, String snapshot, EnvironmentDto environment, VisionRadwareFirstTime radwareFirstTime, HashMap<String, ServerCliBase> serverCliHM)
    {
        this(vmName, snapshot, environment, serverCliHM);
        this.radwareFirstTime = radwareFirstTime;
    }

    @Override
    public void run() {
        try {
            String envType = this.environment.getName().split("-")[0];
            switch (envType.toLowerCase())
            {
                case "ova":
                    VmSnapShotOperations.getInstance().revertVMWareSnapshot(this.vmName, this.snapshot, this.environment, this.serverCliHM);
                    break;
                case "kvm":
                    VmSnapShotOperations.getInstance().revertKvmSnapshot(this.snapshot, this.radwareFirstTime, this.serverCliHM);
                    break;
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }

    public static void revertSnapshot(RevertMachines revertMachines) throws Exception
    {
        revertSnapshot(revertMachines, 0, null);
    }

    public static RevertSnapshotHandler revertSnapshot(RevertMachines revertMachines, long timeout, TimeUnit timeUnit) throws Exception {
        List<RevertSnapshotHandler> revertSnapshotHandlerList = new ArrayList<>();
        RevertSnapshotHandler revertSnapshotHandler = null;

        switch (revertMachines)
        {
            case MACHINEAndPAIR:
            case MACHINE:
                revertSnapshotHandler = getMachineRevert();
                if(revertSnapshotHandler != null) revertSnapshotHandlerList.add(revertSnapshotHandler);
                if(revertMachines != RevertMachines.MACHINEAndPAIR)
                    break;
            case PAIR:
                revertSnapshotHandler = getMachinePairRevert();
                if(revertSnapshotHandler != null) revertSnapshotHandlerList.add(revertSnapshotHandler);
                break;
        }

        int rSCount = revertSnapshotHandlerList.size();

        if(rSCount > 1)
        {

            ExecutorService executorService = Executors.newScheduledThreadPool(rSCount);

            for (RevertSnapshotHandler rsh: revertSnapshotHandlerList
            ) {
                executorService.execute(rsh);
            }

            executorService.shutdown();

            if(timeout == 0) timeout = 40;
            if(timeUnit == null) timeUnit = TimeUnit.MINUTES;

            if(!executorService.awaitTermination(timeout, timeUnit))
                throw new Exception("ERROR Revert - timeout");
        }
        else if(rSCount == 1)
        {
            revertSnapshotHandlerList.get(0).run();
        }
        else{
            throw new Exception("There is no machines to revert.");
        }

        return revertSnapshotHandler;
    }

    public static RevertSnapshotHandler getMachineRevert()
    {
        SUTManager sutManager = TestBase.getSutManager();

        String ip = sutManager.getClientConfigurations().getHostIp();
        String vmName = String.format("%s_%s", sutManager.getServerName(), ip);
        String snapshot = sutManager.getDeployConfigurations().getSnapshot();
        Optional<EnvironmentDto> environmentO = sutManager.getEnviorement();
        EnvironmentDto environment = null;
        if(environmentO.isPresent())
            environment = environmentO.get();

        CliConfigurationDto cliConfig = sutManager.getCliConfigurations();

        return getRevertSnapshot(ip, vmName, environment, snapshot, cliConfig);
    }

    public static RevertSnapshotHandler getMachinePairRevert()
    {
        SUTManager sutManager = TestBase.getSutManager();

        String ip = sutManager.getClientConfigurations().getHostIp();
        String vmName = String.format("%s_%s", sutManager.getPairDao().getServerName(), sutManager.getPairConfigurations().getHostIp());
        String snapshot = sutManager.getPairDeployConfigurations().getSnapshot();
        Optional<EnvironmentDto> environmentO = sutManager.getPairEnviorement();
        EnvironmentDto environment = null;
        if(environmentO.isPresent())
            environment = environmentO.get();

        CliConfigurationDto cliConfig = sutManager.getPairCliConfigurations();

        return getRevertSnapshot(ip, vmName, environment, snapshot, cliConfig);
    }

    public static RevertSnapshotHandler getRevertSnapshot(String ip, String vmName, EnvironmentDto environment, String snapshot, CliConfigurationDto cliConfig)
    {
        if(snapshot == null || snapshot.equals(""))
            return null;

        HashMap<String, ServerCliBase> serverCliHM = new HashMap<>();
        serverCliHM.put("root", getServerCli(RootServerCli.class, ip, cliConfig.getRootServerCliUserName(), cliConfig.getRootServerCliPassword()));
        serverCliHM.put("radware", getServerCli(RadwareServerCli.class, ip, cliConfig.getRadwareServerCliUserName(), cliConfig.getRadwareServerCliPassword()));

        try {
            switch (environment.getName().split("-")[0].toLowerCase())
            {
                case "ova":
                    return new RevertSnapshotHandler(vmName, snapshot, environment, serverCliHM);
                case "kvm":
                    return new RevertSnapshotHandler(vmName, snapshot, environment, getRadwareFirstTime(vmName, environment), serverCliHM);
                default:
                    return null;
            }
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public static VisionRadwareFirstTime getRadwareFirstTime(String vmName, EnvironmentDto environment)
    {
        if(environment == null)
            return null;

        String netMask = environment.getNetMask();
        String gateway = environment.getGateWay();
        String primaryDns = environment.getDnsServerIp();
        String physicalManagement = environment.getPhysicalManagement();
        String ip = environment.getHostIp();
        String user = environment.getUser();
        String password = environment.getPassword();
        return new VisionRadwareFirstTime(user,password,netMask, gateway, primaryDns, physicalManagement, vmName, ip);
    }

    public static <SERVER extends ServerCliBase> SERVER getServerCli(Class<SERVER> clazz, String ip, String username, String password)
    {
        SERVER server = null;

        try
        {
            Constructor<SERVER> constructor = clazz.getConstructor(String.class, String.class, String.class);
            String cType = clazz.getTypeName();
            switch (cType.substring(cType.lastIndexOf(".")+1))
            {
                case "RadwareServerCli":
                case "RootServerCli":
                    server = constructor.newInstance(ip, username, password); break;
            }

            if(server != null)
            {
                server.setConnectOnInit(false);
                server.init();
            }
        }
        catch (Exception ignored){ }

        return server;
    }

    public void afterRevert()
    {
        RemoteSshCommandsTests.resetPassword();
        VMOperationsSteps.updateVersionVar();
        TestBase.dBAccessCommand();
    }
}

enum RevertMachines{
    MACHINEAndPAIR("MACHINEAndPAIR"),
    MACHINE("MACHINE"),
    PAIR("PAIR");

    final String value;

    RevertMachines(String value)
    {
        this.value = value;
    }

    public String getValue()
    {
        return this.value;
    }
}