package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.enums.UpdateMethod;
import com.radware.vision.infra.testhandlers.scheduledtasks.DPConfigurationTemplatesHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import testhandlers.vision.config.itemlist.templates.enums.InstallOnInstance;

import java.util.HashMap;

/**
 * Created by StanislavA on 12/2/2015.
 */
public class DefenseProConfigurationTemplatesTask extends ScheduledTasksTestBase {

    TaskType taskType = TaskType.DP_CONFIGURATION_TEMPLATES;

    String deviceDestinations;
    String groupDestinations;
    String columnName;

    String networkProtectionPolicies;
    String networkProtectionPoliciesToRemove;
    boolean networkProtectionConfiguration = true;
    boolean networkProtectionDnsBaseline = true;
    boolean networkProtectionBdosBaseline = true;

    String serverProtectionPolicies;
    String serverProtectionPoliciesToRemove;
    boolean serverProtectionConfiguration = true;
    boolean serverProtectionHttpBaseline = true;

    UpdateMethod updateMethod = UpdateMethod.AppendToExistingConfiguration;
    InstallOnInstance installOnInstance = InstallOnInstance.ZERO;
    boolean updatePoliciesAfterSendingConfiguration = true;

    @Test
    @TestProperties(name = "add DP configuration Templates Task", paramsInclude = {"qcTestId", "taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime",
            "networkProtectionPolicies", "networkProtectionConfiguration", "networkProtectionDnsBaseline", "networkProtectionBdosBaseline",
            "serverProtectionPolicies", "serverProtectionConfiguration", "serverProtectionHttpBaseline",
            "updateMethod", "installOnInstance", "updatePoliciesAfterSendingConfiguration"})
    public void addDPConfigurationTemplatesTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());

            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            taskPorperties.put("networkProtectionPolicies", networkProtectionPolicies);
            taskPorperties.put("networkProtectionConfiguration", String.valueOf(networkProtectionConfiguration));
            taskPorperties.put("networkProtectionDnsBaseline", String.valueOf(networkProtectionDnsBaseline));
            taskPorperties.put("networkProtectionBdosBaseline", String.valueOf(networkProtectionBdosBaseline));
            taskPorperties.put("serverProtectionPolicies", serverProtectionPolicies);
            taskPorperties.put("serverProtectionConfiguration", String.valueOf(serverProtectionConfiguration));
            taskPorperties.put("serverProtectionHttpBaseline", String.valueOf(serverProtectionHttpBaseline));
            taskPorperties.put("updateMethod", updateMethod.getUpdateMethod());
            taskPorperties.put("installOnInstance", installOnInstance.getInstance());
            taskPorperties.put("updatePoliciesAfterSendingConfiguration", String.valueOf(updatePoliciesAfterSendingConfiguration));


            DPConfigurationTemplatesHandler.addTask(taskPorperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit DP configuration Templates Task", paramsInclude = {"qcTestId", "taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime",
            "networkProtectionPolicies", "networkProtectionConfiguration", "networkProtectionDnsBaseline", "networkProtectionBdosBaseline", "networkProtectionPoliciesToRemove",
            "serverProtectionPolicies", "serverProtectionConfiguration", "serverProtectionHttpBaseline", "serverProtectionPoliciesToRemove",
            "updateMethod", "installOnInstance", "updatePoliciesAfterSendingConfiguration"})
    public void editDPConfigurationTemplatesTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());

            taskPorperties.put("columnName", columnName);
            //taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            taskPorperties.put("networkProtectionPolicies", networkProtectionPolicies);
            taskPorperties.put("networkProtectionPoliciesToRemove", networkProtectionPoliciesToRemove);
            taskPorperties.put("networkProtectionConfiguration", String.valueOf(networkProtectionConfiguration));
            taskPorperties.put("networkProtectionDnsBaseline", String.valueOf(networkProtectionDnsBaseline));
            taskPorperties.put("networkProtectionBdosBaseline", String.valueOf(networkProtectionBdosBaseline));
            taskPorperties.put("serverProtectionPolicies", serverProtectionPolicies);
            taskPorperties.put("serverProtectionPoliciesToRemove", serverProtectionPoliciesToRemove);
            taskPorperties.put("serverProtectionConfiguration", String.valueOf(serverProtectionConfiguration));
            taskPorperties.put("serverProtectionHttpBaseline", String.valueOf(serverProtectionHttpBaseline));
            taskPorperties.put("updateMethod", updateMethod.getUpdateMethod());
            taskPorperties.put("installOnInstance", installOnInstance.getInstance());
            taskPorperties.put("updatePoliciesAfterSendingConfiguration", String.valueOf(updatePoliciesAfterSendingConfiguration));


            DPConfigurationTemplatesHandler.editTask(taskPorperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to edit task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    public TaskType getTaskType() {
        return taskType;
    }

    public void setTaskType(TaskType taskType) {
        this.taskType = taskType;
    }

    public String getDeviceDestinations() {
        return deviceDestinations;
    }

    @ParameterProperties(description = "Specify devices List. Device names must be separated by <,>.")
    public void setDeviceDestinations(String deviceDestinations) {
        this.deviceDestinations = deviceDestinations;
    }

    public String getGroupDestinations() {
        return groupDestinations;
    }

    @ParameterProperties(description = "Specify Group List. Group names must be separated by <,>.")
    public void setGroupDestinations(String groupDestinations) {
        this.groupDestinations = groupDestinations;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getNetworkProtectionPolicies() {
        return networkProtectionPolicies;
    }

    @ParameterProperties(description = "Pairs must be separated by <|>. IP and Policy Name must be separated by <,>!")
    public void setNetworkProtectionPolicies(String networkProtectionPolicies) {
        this.networkProtectionPolicies = networkProtectionPolicies;
    }

    public boolean isUpdatePoliciesAfterSendingConfiguration() {
        return updatePoliciesAfterSendingConfiguration;
    }

    public void setUpdatePoliciesAfterSendingConfiguration(boolean updatePoliciesAfterSendingConfiguration) {
        this.updatePoliciesAfterSendingConfiguration = updatePoliciesAfterSendingConfiguration;
    }

    public InstallOnInstance getInstallOnInstance() {
        return installOnInstance;
    }

    public void setInstallOnInstance(InstallOnInstance installOnInstance) {
        this.installOnInstance = installOnInstance;
    }

    public UpdateMethod getUpdateMethod() {
        return updateMethod;
    }

    public void setUpdateMethod(UpdateMethod updateMethod) {
        this.updateMethod = updateMethod;
    }

    public boolean getServerProtectionConfiguration() {
        return serverProtectionConfiguration;
    }

    public void setServerProtectionConfiguration(boolean serverProtectionConfiguration) {
        this.serverProtectionConfiguration = serverProtectionConfiguration;
    }

    public boolean getServerProtectionHttpBaseline() {
        return serverProtectionHttpBaseline;
    }

    public void setServerProtectionHttpBaseline(boolean serverProtectionHttpBaseline) {
        this.serverProtectionHttpBaseline = serverProtectionHttpBaseline;
    }

    public String getServerProtectionPolicies() {
        return serverProtectionPolicies;
    }

    @ParameterProperties(description = "Pairs must be separated by <|>. IP and Policy Name must be separated by <,>!")
    public void setServerProtectionPolicies(String serverProtectionPolicies) {
        this.serverProtectionPolicies = serverProtectionPolicies;
    }

    public boolean getNetworkProtectionBdosBaseline() {
        return networkProtectionBdosBaseline;
    }

    public void setNetworkProtectionBdosBaseline(boolean networkProtectionBdosBaseline) {
        this.networkProtectionBdosBaseline = networkProtectionBdosBaseline;
    }

    public boolean getNetworkProtectionDnsBaseline() {
        return networkProtectionDnsBaseline;
    }

    public void setNetworkProtectionDnsBaseline(boolean networkProtectionDnsBaseline) {
        this.networkProtectionDnsBaseline = networkProtectionDnsBaseline;
    }

    public boolean getNetworkProtectionConfiguration() {
        return networkProtectionConfiguration;
    }

    public void setNetworkProtectionConfiguration(boolean networkProtectionConfiguration) {
        this.networkProtectionConfiguration = networkProtectionConfiguration;
    }

    public String getNetworkProtectionPoliciesToRemove() {
        return networkProtectionPoliciesToRemove;
    }

    public void setNetworkProtectionPoliciesToRemove(String networkProtectionPoliciesToRemove) {
        this.networkProtectionPoliciesToRemove = networkProtectionPoliciesToRemove;
    }

    public String getServerProtectionPoliciesToRemove() {
        return serverProtectionPoliciesToRemove;
    }

    public void setServerProtectionPoliciesToRemove(String serverProtectionPoliciesToRemove) {
        this.serverProtectionPoliciesToRemove = serverProtectionPoliciesToRemove;
    }

}
