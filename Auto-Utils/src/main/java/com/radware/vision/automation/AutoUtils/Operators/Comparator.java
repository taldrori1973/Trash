package com.radware.vision.automation.AutoUtils.Operators;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Comparator {

    public static String failureMessage;


    public static boolean compareResults(String expectedResult, String actualResult, OperatorsEnum operatorsEnum, Integer offset) {
        boolean bTestSuccess = false;
        int iActualResult, iExpectedResult;

        try {
            switch (operatorsEnum) {
                case CONTAINS:
                    if (!actualResult.contains(expectedResult)) {
                        failureMessage = "Actual \"" + actualResult + "\" does not contain \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case EQUALS:
                    //Numbers with offset
                    if (offset != null && offset > 0) {
                        iActualResult = Integer.parseInt(actualResult.trim());
                        iExpectedResult = Integer.parseInt(expectedResult.trim());
                        if (iActualResult >= (iExpectedResult - offset) && iActualResult <= (iExpectedResult + offset))
                            bTestSuccess = true;
                        else
                            failureMessage = String.format("Expected values between: %d and %d. Actual: %d",
                                    iExpectedResult - offset, iExpectedResult + offset, iActualResult);
                        //Numbers with no offset or strings
                    } else if (!actualResult.trim().equals(expectedResult)) {
                        failureMessage = "Actual \"" + actualResult + "\" is not equal to \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case NOT_EQUALS:
                    if (actualResult.trim().equals(expectedResult)) {
                        failureMessage = "Actual \"" + actualResult + "\" is equal to \"" + expectedResult + "\" although it shouldn't be";
                    } else
                        bTestSuccess = true;
                    break;
                case GT:
                    iActualResult = Integer.parseInt(actualResult.trim());
                    if (!(iActualResult > Integer.parseInt(expectedResult))) {
                        failureMessage = "Actual \"" + actualResult + "\" is not greater than \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case GTE:
                    iActualResult = Integer.parseInt(actualResult.trim());
                    if (!(iActualResult >= Integer.parseInt(expectedResult))) {
                        failureMessage = "Actual \"" + actualResult + "\" is not equal or greater than \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case LT:
                    iActualResult = Integer.parseInt(actualResult.trim());
                    if (!(iActualResult < Integer.parseInt(expectedResult))) {
                        failureMessage = "Actual \"" + actualResult + "\" is not less than \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case LTE:
                    iActualResult = Integer.parseInt(actualResult.trim());
                    if (!(iActualResult <= Integer.parseInt(expectedResult))) {
                        failureMessage = "Actual \"" + actualResult + "\" is not equal or less than \"" + expectedResult + "\"";
                    } else
                        bTestSuccess = true;
                    break;
                case MatchRegex:
                    Pattern pattern = Pattern.compile(expectedResult);
                    Matcher matcher = pattern.matcher(actualResult);
                    if (matcher.matches()) bTestSuccess = true;
                    else
                        failureMessage = String.format("The Actual Result \"%s\" not matches the regex \"%s\"", actualResult, expectedResult);
                    break;
                default:
                    failureMessage = "No such operator: " + operatorsEnum;
            }
        } catch (NumberFormatException e) {
            failureMessage = String.format("Can't parse input \"%s\" as number", actualResult);
        }
        return bTestSuccess;
    }
}
