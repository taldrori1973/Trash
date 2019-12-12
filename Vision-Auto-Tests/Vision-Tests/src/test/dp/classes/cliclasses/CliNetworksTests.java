package com.radware.vision.tests.dp.classes.cliclasses;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.PolicyNetworkMode;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.extensions.analyzers.tabletext.GetTableColumn;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.apache.commons.lang.ArrayUtils;
import org.junit.Before;
import org.junit.Test;

public class CliNetworksTests extends SystemTestCase4 {


    DefenseProProduct defensepro;

    /*create network class Testl*/
    private String networkName;


    private PolicyNetworkMode entryType;
    private String networkAddress;
    private String mask;
    private String fromIP;
    private String toIP;


    @Test
    @TestProperties(name = "Verify network Class - Cli", paramsInclude = {"qcTestId", "networkName", "entryType", "ipVersion", "networkAddress", "mask", "fromIP", "toIP"})
    public void verifyNetworkClass() throws Exception {

        boolean passed = true;

        String nameCH = "Name";
        String addressCH = "Address";
        String maskCH = "Mask";
        String fipCH = "From IP";

        defensepro.classes.getClassesModifyNetwork();

        GetTableColumn nametc = new GetTableColumn(nameCH);
        GetTableColumn addresstc = new GetTableColumn(addressCH);
        GetTableColumn masktc = new GetTableColumn(maskCH);
        GetTableColumn fiptc = new GetTableColumn(fipCH);

        defensepro.classes.analyze(nametc);
        defensepro.classes.analyze(addresstc);
        defensepro.classes.analyze(masktc);
        defensepro.classes.analyze(fiptc);

        String[] namegn = nametc.getColumn();

        int indexOfEntry = ArrayUtils.indexOf(namegn, networkName);

        if (!(indexOfEntry == -1)) {


            String addressgc = addresstc.getColumn()[indexOfEntry];
            String maskgc = masktc.getColumn()[indexOfEntry];
            String fipgc = fiptc.getColumn()[indexOfEntry];

            if (entryType != null) {


                if (entryType.equals(PolicyNetworkMode.IP_Mask)) {


                    if (networkAddress != null) {
                        if (!networkAddress.toString().equals(addressgc.toString())) {
                            ListenerstManager.getInstance().report(
                                    "FAIL : Address: " + networkAddress
                                            + " but Actual: "
                                            + addressgc.toString(), Reporter.FAIL);
                            passed = false;
                        }
                    }


                    if (mask != null) {
                        if (!mask.toString().equals(maskgc.toString())) {
                            ListenerstManager.getInstance().report(
                                    "FAIL : Mask: " + mask
                                            + " but Actual: "
                                            + maskgc.toString(), Reporter.FAIL);
                            passed = false;
                        }
                    }


                }


                if (entryType.equals(PolicyNetworkMode.IP_Range)) {


                    if (fromIP != null) {
                        if (!fromIP.toString().equals(fipgc.toString())) {
                            ListenerstManager.getInstance().report(
                                    "FAIL : From IP: " + fromIP
                                            + " but Actual: "
                                            + fipgc.toString(), Reporter.FAIL);
                            passed = false;
                        }
                    }
                }


                if (passed) {
                    if (fromIP != null && entryType.equals(PolicyNetworkMode.IP_Range))
                        ListenerstManager.getInstance().report(
                                "Pass : From IP : " + fromIP + " Actual: "
                                        + fipgc.toString());


                    if (networkAddress != null
                            && entryType.equals(PolicyNetworkMode.IP_Mask))
                        ListenerstManager.getInstance().report(
                                "Pass : Address : " + networkAddress
                                        + " Actual: " + addressgc.toString());


                    if (mask != null && entryType.equals(PolicyNetworkMode.IP_Mask))
                        ListenerstManager.getInstance().report(
                                "Pass : Mask : " + mask
                                        + " Actual: " + maskgc.toString());
                }


            } else {
                ListenerstManager.getInstance().report("FAIL : entryType is Empty Please fill ",
                        Reporter.FAIL);
            }


        } else {
            ListenerstManager.getInstance().report("FAIL : Entry Not Found ",
                    Reporter.FAIL);
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


    public String getNetworkName() {
        return networkName;
    }


    public void setNetworkName(String networkName) {
        this.networkName = networkName;
    }


    public PolicyNetworkMode getEntryType() {
        return entryType;
    }


    public void setEntryType(PolicyNetworkMode entryType) {
        this.entryType = entryType;
    }


    public String getNetworkAddress() {
        return networkAddress;
    }


    public void setNetworkAddress(String networkAddress) {
        this.networkAddress = networkAddress;
    }

    public String getMask() {
        return mask;
    }

    public void setMask(String mask) {
        this.mask = mask;
    }


    public String getFromIP() {
        return fromIP;
    }


    public void setFromIP(String fromIP) {
        this.fromIP = fromIP;
    }

    public String getToIP() {
        return toIP;
    }

    public void setToIP(String toIP) {
        this.toIP = toIP;
    }


}
