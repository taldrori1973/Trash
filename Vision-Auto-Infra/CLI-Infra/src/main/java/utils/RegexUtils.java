/**
 *
 */
package utils;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Hadar Elbaz
 */
public class RegexUtils {


    public static ArrayList<String> fromStringToArrayWithPattern(String patternStr, String str) throws Exception {

        ArrayList<String> returnArray = new ArrayList<>();
        String[] lines = str.split("\\r\\n");
        for (String line : lines) {
            Matcher matcher = Pattern.compile(patternStr).matcher(line);
            while (matcher.find()) {
                returnArray.add(matcher.group(1));
            }
        }
        return returnArray;
    }


        public static ArrayList<String> getGroupsWithPattern(String patternStr, String str) throws Exception {

        ArrayList<String> returnArray = new ArrayList<>();
        Matcher matcher = Pattern.compile(patternStr).matcher(str);
        if (matcher.find()) {

            for (int i = 1; i <= matcher.groupCount(); i++)
                returnArray.add(matcher.group(i));
        }
        return returnArray;
    }

    /**
     * the function checks if the string contains the pattern
     */
    public static boolean isStringContainsThePattern(String patternStr, String str) {
        Matcher matcher = Pattern.compile(patternStr).matcher(str);
        if (matcher.find()) {
            return true;
        }
        return false;
    }

    public static String getGroupWithPattern(String patternStr, String str) {

        Matcher matcher = Pattern.compile(patternStr).matcher(str);

        if (matcher.find()) {
            return matcher.group(0);
        }
        return "";

    }


}
