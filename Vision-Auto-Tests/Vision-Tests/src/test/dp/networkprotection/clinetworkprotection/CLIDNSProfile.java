package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpPolicyAction;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.junit.Before;
import org.junit.Test;

public class CLIDNSProfile extends SystemTestCase4 {

	private String DNSName;
	private String AQuery;
	private String MXQuery;
	private String PTRQuery;
	private String AAAAQuery;
	private String TextQuery;
	private String SOAQuery;
	private String NAPTRQuery;
	private String SRVQuery;
	private String OtherQueries;
	private String ActivationThreshold;
	private String TerminationThreshold;
	private String MaxQPS;
	private String ActivationPeriod;
	private String TerminationPeriod;
	private String EscalationPeriod;
	private String ProfileActions;
	private String MaxallowedQPS;
	private String SignatureRateLimitTarget;
	private String ExpectedDNSQueryRate;
	private DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify DNS Protection Profile - Cli", paramsInclude = { "qcTestId", "DNSName", "AQuery", "MXQuery", "PTRQuery", "AAAAQuery",
			"TextQuery", "SOAQuery", "NAPTRQuery", "SRVQuery", "OtherQueries", "ActivationThreshold", "TerminationThreshold", "MaxQPS", "ActivationPeriod",
			"TerminationPeriod", "EscalationPeriod", "ProfileActions", "Maxallowed_QPS", "ProfileActions", "MaxallowedQPS", "SignatureRateLimitTarget",
			"ExpectedDNSQueryRate" })
	public void DnsCliTest() throws Exception {

	//	Long a_Query = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersActivationThreshold(DNSName);
	// Long mX_Query =
	// defensepro.dp.Dns().Global().Advanced().Profiles().get
	//	Long pTR_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long aAAA_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long text_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long sOA_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long nAPTR_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long sRV_Query = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
	//	Long other_Queries = defensepro.dp.OutOfState().Profile().getTermThreshold(DNSName);
		
		
		
		Long activation_Threshold = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersActivationThreshold(DNSName);
		Long termination_Threshold = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersTerminationThreshold(DNSName);
		Long max_QPS = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersMaxQPSTarget(DNSName);
		Long activationPeriod = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersActivationPeriod(DNSName);
		Long terminationPeriod = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersTerminationPeriod(DNSName);
		Long escalationPeriod = defensepro.dp.Dns().Global().Advanced().Profiles().getManualTriggersEscalationPeriod(DNSName);
		DpPolicyAction profileActions = defensepro.dp.Dns().Global().Advanced().Profiles().getAction(DNSName);
		Long maxallowedQPS = defensepro.dp.Dns().Global().Advanced().Profiles().getMaxAllowedQPS(DNSName);
		Integer signatureRateLimitTarget = defensepro.dp.Dns().Global().Advanced().Profiles().getSignatureRateLimitTarget(DNSName);
		Long expectedDNSQueryRate = defensepro.dp.Dns().Global().Advanced().Profiles().getExpectedQPS(DNSName);

		boolean passed = true;

//		 if(!(a_Query.equals(A_Query)))
//		 {
//		 ListenerstManager.getInstance().report("A Query: " + a_Query +
//		 " but expected: " + A_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(mX_Query.equals(MX_Query)))
//		 {
//		 ListenerstManager.getInstance().report("MX Query: " + mX_Query +
//		 " but expected: " + MX_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(pTR_Query.equals(PTR_Query)))
//		 {
//		 ListenerstManager.getInstance().report("PTR Query: " + pTR_Query +
//		 " but expected: " + PTR_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(aAAA_Query.equals(AAAA_Query)))
//		 {
//		 ListenerstManager.getInstance().report("AAAA Query: " + aAAA_Query +
//		 " but expected: " + AAAA_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(text_Query.equals(Text_Query)))
//		 {
//		 ListenerstManager.getInstance().report("Text Query: " + text_Query +
//		 " but expected: " + Text_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(sOA_Query.equals(SOA_Query)))
//		 {
//		 ListenerstManager.getInstance().report("Text Query: " + sOA_Query +
//		 " but expected: " + SOA_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(nAPTR_Query.equals(NAPTR_Query)))
//		 {
//		 ListenerstManager.getInstance().report("Text Query: " + nAPTR_Query +
//		 " but expected: " + NAPTR_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(sRV_Query.equals(SRV_Query)))
//		 {
//		 ListenerstManager.getInstance().report("Text Query: " + sRV_Query +
//		 " but expected: " + SRV_Query, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!(other_Queries.equals(Other_Queries)))
//		 {
//		 ListenerstManager.getInstance().report("Text Query: " + Other_Queries
//		 + " but expected: " + other_Queries, Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!activation_Threshold.equals(Long.valueOf(Activation_Threshold)))
//		 {
//		 ListenerstManager.getInstance().report("Activation Threshold: " +
//		 activation_Threshold + " but expected: " + Activation_Threshold,
//		 Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!termination_Threshold.equals(Long.valueOf(Termination_Threshold)))
//		 {
//		 ListenerstManager.getInstance().report("Termination Threshold: " +
//		 termination_Threshold + " but expected: " + Termination_Threshold,
//		 Reporter.FAIL );
//		 passed = false;
//		 }
//		 if(!max_QPS.equals(Long.valueOf(Max_QPS)))
//		 {
//		 ListenerstManager.getInstance().report("Max QPS: " + max_QPS +
//		 " but expected: " + Max_QPS, Reporter.FAIL );
//		 passed = false;
//		 }
		 
		 
		 if (ProfileActions != null) {
		 if(!(profileActions.toString().equals(ProfileActions)))
		 {
		 ListenerstManager.getInstance().report("Profile Action: " +
		 profileActions + " but expected: " + ProfileActions, Reporter.FAIL );
		 passed = false;
		 }
		 }
		
		
		if (SignatureRateLimitTarget != null) {
		if (!(signatureRateLimitTarget.toString().equals(SignatureRateLimitTarget))) {
			ListenerstManager.getInstance().report("Signature Rate-Limit Target: " + signatureRateLimitTarget + " but expected: " + SignatureRateLimitTarget,
					Reporter.FAIL);
			passed = false;
		}}
		
		
		if (MaxallowedQPS != null) {
		if (!maxallowedQPS.toString().equals(MaxallowedQPS)) {
			ListenerstManager.getInstance().report("Max_allowed_QPS: " + maxallowedQPS + " but expected: " + MaxallowedQPS, Reporter.FAIL);
			passed = false;
		}
		}
		
		
		if (ActivationPeriod != null) {
			if (!(activationPeriod.equals(Long.valueOf(ActivationPeriod)))) {
				ListenerstManager.getInstance().report("Activation_Period: " + activationPeriod + " but expected: " + ActivationPeriod, Reporter.FAIL);
				passed = false;
			}
		}
		if (TerminationPeriod != null) {
			if (!(terminationPeriod.equals(TerminationPeriod))) {
				ListenerstManager.getInstance().report("Termination_Period: " + terminationPeriod + " but expected: " + TerminationPeriod, Reporter.FAIL);
				passed = false;
			}
		}
		if (EscalationPeriod != null) {
			if (!(escalationPeriod.equals(EscalationPeriod))) {
				ListenerstManager.getInstance().report("Escalation_Period: " + escalationPeriod + " but expected: " + EscalationPeriod, Reporter.FAIL);
				passed = false;
			}
		}

		if (ExpectedDNSQueryRate != null) {
			if (!expectedDNSQueryRate.toString().equals(ExpectedDNSQueryRate)) {
				ListenerstManager.getInstance().report("Expected_DNS_Query_Rate: " + expectedDNSQueryRate + " but expected: " + ExpectedDNSQueryRate,
						Reporter.FAIL);
				passed = false;
			}
		}

		
		
		if (passed) {

			// ListenerstManager.getInstance().report("A Query: " + a_Query +
			// " expected: " + A_Query);
			// ListenerstManager.getInstance().report("MX Query: " + mX_Query +
			// " expected: " + MX_Query);
			// ListenerstManager.getInstance().report("PTR Query: " + pTR_Query
			// + " expected: " + PTR_Query);
			// ListenerstManager.getInstance().report("AAAA Query: " +
			// aAAA_Query + " expected: " + AAAA_Query);
			// ListenerstManager.getInstance().report("Text Query: " +
			// text_Query + " expected: " + Text_Query);
			// ListenerstManager.getInstance().report("SOA Query: " + sOA_Query
			// + " expected: " + SOA_Query);
			// ListenerstManager.getInstance().report("NAPTR Query: " +
			// nAPTR_Query + " expected: " + NAPTR_Query);
			// ListenerstManager.getInstance().report("SRV Query: " + sRV_Query
			// + " expected: " + SRV_Query);
			// ListenerstManager.getInstance().report("Other Queries: " +
			// other_Queries + " expected: " + Other_Queries);
			// ListenerstManager.getInstance().report("Activation Threshold: " +
			// activation_Threshold + " expected: " + Activation_Threshold);
			// ListenerstManager.getInstance().report("Termination Threshold: "
			// + termination_Threshold + " expected: " + Termination_Threshold);
			// ListenerstManager.getInstance().report("Max QPS: " + max_QPS +
			// " expected: " + Max_QPS);
			// ListenerstManager.getInstance().report("Profile_Actions " +
			// profileActions + " expected: " + ProfileActions);
		
			// ListenerstManager.getInstance().report("Activation_Period: " +
			// ActivationPeriod + " expected: " + ActivationPeriod);
			// ListenerstManager.getInstance().report("MTermination_Period: " +
			// terminationPeriod + " expected: " + TerminationPeriod);
			// ListenerstManager.getInstance().report("Escalation_Period: " +
			// escalationPeriod + " expected: " + EscalationPeriod);

			
			if(SignatureRateLimitTarget!= null){
				ListenerstManager.getInstance().report("Signature_Rate_Limit_Target: " + signatureRateLimitTarget + " expected: " + SignatureRateLimitTarget);
			}
		
			if(MaxallowedQPS!= null){
				ListenerstManager.getInstance().report("Max_allowed_QPS: " + maxallowedQPS + " expected: " + MaxallowedQPS);
			}
			if(ExpectedDNSQueryRate!= null){
				ListenerstManager.getInstance().report("Expected_DNS_Query_Rate: " + expectedDNSQueryRate + " expected: " + ExpectedDNSQueryRate);
			}

		}
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}

	public DefenseProProduct getDefensepro() {
		return defensepro;
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

	public String getDNSName() {
		return DNSName;
	}

	public void setDNSName(String dNSName) {
		DNSName = dNSName;
	}

	public String getAQuery() {
		return AQuery;
	}

	public void setAQuery(String aQuery) {
		AQuery = aQuery;
	}

	public String getMXQuery() {
		return MXQuery;
	}

	public void setMXQuery(String mXQuery) {
		MXQuery = mXQuery;
	}

	public String getPTRQuery() {
		return PTRQuery;
	}

	public void setPTRQuery(String pTRQuery) {
		PTRQuery = pTRQuery;
	}

	public String getAAAAQuery() {
		return AAAAQuery;
	}

	public void setAAAAQuery(String aAAAQuery) {
		AAAAQuery = aAAAQuery;
	}

	public String getTextQuery() {
		return TextQuery;
	}

	public void setTextQuery(String textQuery) {
		TextQuery = textQuery;
	}

	public String getSOAQuery() {
		return SOAQuery;
	}

	public void setSOAQuery(String sOAQuery) {
		SOAQuery = sOAQuery;
	}

	public String getNAPTRQuery() {
		return NAPTRQuery;
	}

	public void setNAPTRQuery(String nAPTRQuery) {
		NAPTRQuery = nAPTRQuery;
	}

	public String getSRVQuery() {
		return SRVQuery;
	}

	public void setSRVQuery(String sRVQuery) {
		SRVQuery = sRVQuery;
	}

	public String getOtherQueries() {
		return OtherQueries;
	}

	public void setOtherQueries(String otherQueries) {
		OtherQueries = otherQueries;
	}

	public String getActivationThreshold() {
		return ActivationThreshold;
	}

	public void setActivationThreshold(String activationThreshold) {
		ActivationThreshold = activationThreshold;
	}

	public String getTerminationThreshold() {
		return TerminationThreshold;
	}

	public void setTerminationThreshold(String terminationThreshold) {
		TerminationThreshold = terminationThreshold;
	}

	public String getMaxQPS() {
		return MaxQPS;
	}

	public void setMaxQPS(String maxQPS) {
		MaxQPS = maxQPS;
	}

	public String getActivationPeriod() {
		return ActivationPeriod;
	}

	public void setActivationPeriod(String activationPeriod) {
		ActivationPeriod = activationPeriod;
	}

	public String getTerminationPeriod() {
		return TerminationPeriod;
	}

	public void setTerminationPeriod(String terminationPeriod) {
		TerminationPeriod = terminationPeriod;
	}

	public String getEscalationPeriod() {
		return EscalationPeriod;
	}

	public void setEscalationPeriod(String escalationPeriod) {
		EscalationPeriod = escalationPeriod;
	}

	public String getProfileActions() {
		return ProfileActions;
	}

	public void setProfileActions(String profileActions) {
		ProfileActions = profileActions;
	}

	public String getMaxallowedQPS() {
		return MaxallowedQPS;
	}

	public void setMaxallowedQPS(String maxallowedQPS) {
		MaxallowedQPS = maxallowedQPS;
	}

	public String getSignatureRateLimitTarget() {
		return SignatureRateLimitTarget;
	}

	public void setSignatureRateLimitTarget(String signatureRateLimitTarget) {
		SignatureRateLimitTarget = signatureRateLimitTarget;
	}

	public String getExpectedDNSQueryRate() {
		return ExpectedDNSQueryRate;
	}

	public void setExpectedDNSQueryRate(String expectedDNSQueryRate) {
		ExpectedDNSQueryRate = expectedDNSQueryRate;
	}

}
