package com.radware.vision.automation.VisionAutoInfra.CLIInfra;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class LicenseVisionUtils
{	
	private static Logger logger = Logger.getLogger("LicenseUtils");
	
	public static String PRODUCT_NAME = "vision";
	private static String LICENSE_ID = "master";						
	private static Integer SHA_DIGEST_LENGTH = 20;
	private static Integer LICENSE_PW_LEN = 8;
	private static String HASHING_ALGORITHM = "SHA-1";
	private static final String LINUX = "Linux";	
	private static final String OS_NAME = "os.name";


	public static boolean verifyLicenseString(String license, List<String> MacAddresses)
	{
		if (license == null || license.isEmpty() || !license.startsWith(PRODUCT_NAME) || license.contains(" ") || !license.contains("-")) {
			return false;
		}
				
		String code = license.substring(license.lastIndexOf("-")+1,  license.length());
		String productAndFeature = license.substring(0, license.lastIndexOf("-"));
		
		if (code == null || productAndFeature == null || code.isEmpty() || productAndFeature.isEmpty()) {
			return false;			
		}
		
            for (String MacAddress : MacAddresses) {
                boolean licenseIsValid = false;
                if(verifyLicense(code, MacAddress, productAndFeature)) {
                    return true;
                }
            }
            return false;
	}
	
	public static boolean verifyLicense(String license, String macAddress, String productAndFeature) 
	{
		String generatedLicense = generateLicenseString(macAddress, productAndFeature);
		return generatedLicense.equals(license);
	}

	public static String generateLicenseString(String macAddress, String productAndFeature)
	{						
		// Leave only the alphanumeric chars
		macAddress = macAddress.trim().replaceAll("\\W|_", "");
		macAddress = macAddress.toLowerCase();
		
		// Generate an initial string
		String initialString = "Gary" + macAddress + LICENSE_ID + productAndFeature;

		// Hash it	
		MessageDigest md;
		try 
		{
			md = MessageDigest.getInstance(HASHING_ALGORITHM);
			md.reset();			
		} 
		catch (NoSuchAlgorithmException e) 
		{
			throw new RuntimeException(e.getMessage());
		}												
					
		try 
		{
			md.update(initialString.getBytes("ASCII"));
		} catch (UnsupportedEncodingException e) 
		{
			logger.log(Level.SEVERE, e.getLocalizedMessage());
			throw new RuntimeException(e);
		}
		byte[] digestedString = md.digest();

		// Fold into LICENSE_PW_LEN bytes
		char[] foldedString = new char[LICENSE_PW_LEN];

		for (int i=0; i<LICENSE_PW_LEN; ++i) 
		{
			foldedString[i] = (char) ((digestedString[i] ^ ((i + LICENSE_PW_LEN >= SHA_DIGEST_LENGTH) ? 0
					: ((i + LICENSE_PW_LEN + LICENSE_PW_LEN >= SHA_DIGEST_LENGTH) ? digestedString[i
					                                                                               + LICENSE_PW_LEN]
					                                                                            		   : digestedString[i + LICENSE_PW_LEN
					                                                                            		                    + LICENSE_PW_LEN]))) 
					                                                                            		                    & 255); // reducing the char to one byte (two bytes in Java) 
		}

		char[] dic = new char[] {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9'};

		// Translate into alphanumeric characters. 
		int ldic = dic.length;
		for (int i = 0; i < LICENSE_PW_LEN; ++i)
		{
			foldedString[i] = (char) dic[foldedString[i] % ldic];	        
		}				

		return new String(foldedString);
	}
	
}
