package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProSignatureProtectionTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.QuarantineActionsTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProSignatureProtectionTableActionTests extends RBACTestBase {

    ViewBaseTableActions quarantinedSourcesTableAction = ViewBaseTableActions.NEW;
    BaseTableActions signaturesTableAction = BaseTableActions.NEW;
    QuarantineActionsTableActions quarantineActionsTableAction = QuarantineActionsTableActions.NEW;
    EditTableActions attributeTypePropertiesTableAction = EditTableActions.EDIT;
    BaseTableActions profilesTableAction = BaseTableActions.NEW;
    ViewBaseTableActions attributesTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Profiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "profilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("profilesTableAction", profilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifyProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + profilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Profiles Disabled Table Action failed: " + profilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Signatures Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "signaturesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySignaturesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("signaturesTableAction", signaturesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifySignaturesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + signaturesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Signatures Disabled Table Action failed: " + signaturesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Attributes Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "attributesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAttributesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("attributesTableAction", attributesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifyAttributesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + attributesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Attributes Disabled Table Action failed: " + attributesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify AttributeTypeProperties Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "attributeTypePropertiesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAttributeTypePropertiesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("attributeTypePropertiesTableAction", attributeTypePropertiesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifyAttributeTypePropertiesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + attributeTypePropertiesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify AttributeTypeProperties Disabled Table Action failed: " + attributeTypePropertiesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify QuarantineActions Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "quarantineActionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyQuarantineActionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("quarantineActionsTableAction", quarantineActionsTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifyQuarantineActionsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + quarantineActionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify QuarantineActions Disabled Table Action failed: " + quarantineActionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify QuarantinedSources Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "quarantinedSourcesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyQuarantinedSourcesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("quarantinedSourcesTableAction", quarantinedSourcesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSignatureProtectionTableActionHandler.verifyQuarantinedSourcesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + quarantinedSourcesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify QuarantinedSources Disabled Table Action failed: " + quarantinedSourcesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public ViewBaseTableActions getQuarantinedSourcesTableAction() {
        return quarantinedSourcesTableAction;
    }

    public void setQuarantinedSourcesTableAction(ViewBaseTableActions quarantinedSourcesTableAction) {
        this.quarantinedSourcesTableAction = quarantinedSourcesTableAction;
    }

    public BaseTableActions getSignaturesTableAction() {
        return signaturesTableAction;
    }

    public void setSignaturesTableAction(BaseTableActions signaturesTableAction) {
        this.signaturesTableAction = signaturesTableAction;
    }

    public QuarantineActionsTableActions getQuarantineActionsTableAction() {
        return quarantineActionsTableAction;
    }

    public void setQuarantineActionsTableAction(QuarantineActionsTableActions quarantineActionsTableAction) {
        this.quarantineActionsTableAction = quarantineActionsTableAction;
    }

    public EditTableActions getAttributeTypePropertiesTableAction() {
        return attributeTypePropertiesTableAction;
    }

    public void setAttributeTypePropertiesTableAction(EditTableActions attributeTypePropertiesTableAction) {
        this.attributeTypePropertiesTableAction = attributeTypePropertiesTableAction;
    }

    public BaseTableActions getProfilesTableAction() {
        return profilesTableAction;
    }

    public void setProfilesTableAction(BaseTableActions profilesTableAction) {
        this.profilesTableAction = profilesTableAction;
    }

    public ViewBaseTableActions getAttributesTableAction() {
        return attributesTableAction;
    }

    public void setAttributesTableAction(ViewBaseTableActions attributesTableAction) {
        this.attributesTableAction = attributesTableAction;
    }

}
