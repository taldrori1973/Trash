package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.dnsprotectionprofiles.DNSProtectionProfiles;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;


public class DNSProtectionProfleTest extends DpTestBase {

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

	// TO DO The check boxes is not added to the class.

	
	@Test
    @TestProperties(name = "Delete DNS Protection Profiles", paramsInclude = {"qcTestId", "deviceName", "DNSName"})
	public void deleteDNSProfile() throws Exception {
		DNSProtectionProfiles dnsProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mDNSProtectionProfiles();
		dnsProfile.openPage();
		dnsProfile.deleteDNSProtectionProfileByKeyValue("Name", DNSName);
	}
	
	
	@Test
    @TestProperties(name = "Create DNS Protection Profiles", paramsInclude = {"qcTestId", "deviceName", "DNSName", "AQuery", "MXQuery", "PTRQuery", "AAAAQuery", "TextQuery",
			"SOAQuery", "NAPTRQuery", "SRVQuery", "OtherQueries", "ActivationThreshold", "TerminationThreshold", "MaxQPS", "ActivationPeriod",
			"TerminationPeriod", "EscalationPeriod", "ProfileActions", "MaxallowedQPS", "SignatureRateLimitTarget", "ExpectedDNSQueryRate" })
	public void createDNSProfile() throws Exception {
		DNSProtectionProfiles dnsProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mDNSProtectionProfiles();
		dnsProfile.openPage();
		dnsProfile.addDNSProtectionProfile();
		if (DNSName !=null){
		dnsProfile.setProfileName(DNSName);}
		if (AQuery !=null){
		dnsProfile.selectAQuery(AQuery);}
		if (MXQuery!=null){
		dnsProfile.selectMXQuery(MXQuery);}
		if (PTRQuery!=null){
		dnsProfile.selectPTRQuery(PTRQuery);}
		if (AAAAQuery!=null){
		dnsProfile.selectAAAAQuery(AAAAQuery);}
		if (TextQuery!=null){
		dnsProfile.selectTextQuery(TextQuery);}
		if (SOAQuery!=null){
		dnsProfile.selectSOAQuery(SOAQuery);}
		if (NAPTRQuery!=null){
		dnsProfile.selectNAPTRQuery(NAPTRQuery);}
		if (SRVQuery!=null){
		dnsProfile.selectSRVQuery(SRVQuery);}
		if (OtherQueries!=null){
		dnsProfile.selectOtherQueries(OtherQueries);}
		if (ExpectedDNSQueryRate!=null){
		dnsProfile.setExpectedDNSQueryRate(ExpectedDNSQueryRate);}
		if (ActivationThreshold!=null){
		dnsProfile.setActivationThreshold(ActivationThreshold);}
		if (TerminationThreshold!=null){
		dnsProfile.setTerminationThreshold(TerminationThreshold);}
		if (MaxQPS!=null){
		dnsProfile.setMaxQPS(MaxQPS);}
		if (ActivationPeriod!=null){
		dnsProfile.selectActivationPeriod(ActivationPeriod);}
		if (TerminationPeriod!=null){
		dnsProfile.selectTerminationPeriod(TerminationPeriod);}
		if (EscalationPeriod!=null){
		dnsProfile.selectEscalationPeriod(EscalationPeriod);}
//		dnsProfile.enablePacketReport();
//		dnsProfile.enablePacketTrace();
//		dnsProfile.enableUseManualTriggers();
		if (ProfileActions!=null){
		dnsProfile.selectProfileAction(ProfileActions);}
		if (MaxallowedQPS!=null){
		dnsProfile.setMaxallowedQPS(MaxallowedQPS);}
		if (SignatureRateLimitTarget!=null){
		dnsProfile.selectSignatureRateLimitTarget(SignatureRateLimitTarget);}
		dnsProfile.submit();

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
