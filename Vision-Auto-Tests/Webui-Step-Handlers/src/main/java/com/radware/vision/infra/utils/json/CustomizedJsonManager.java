package com.radware.vision.infra.utils.json;

import org.json.JSONObject;

import java.util.*;

import static java.util.stream.Collectors.joining;

import org.json.*;

/**
 * Created by MoaadA on 7/30/2018.
 * <p>
 * The purpose of this class to take the below customized json(which meant to be simpler for the user) and fix this to valid json
 * <p>
 * Format as such a map:
 * <p>
 * | reportType            | DefensePro Analytics Dashboard                                              |
 * | devices               | index:10,ports:[10,20],policies:[a,b];index:11,ports:[10,20],policies:[a,b] |
 * | Time Definitions.Date | Quick:30m                                                                   |
 * | Schedule              | Run Every:Week,At Week Day:MON,On Time:10:00                                |
 * | Delivery              | Email:[radware@radware.com],Subject:blablabla,Body:blabalblabla             |
 * | Design                | Delete:[ALL]                                                                |
 * <p>
 * its based on json but without using --> {} or ""
 */
public class CustomizedJsonManager {

    public static Map<String, String> fixJson(Map<String, String> values) {
        List<String> keyValue = new ArrayList<>();
        List<String> jsonObjects = new ArrayList<>();
        int lastSize = 0;
        Map<String, String> result = new HashMap();

        List<JSONObject> allObjects = new ArrayList<>();
        for (Map.Entry<String, String> entry : values.entrySet()) {
            if (isJSONValid(entry.getValue())) {
                result.put(entry.getKey(), entry.getValue());
            } else {
                List<String> objects = Arrays.asList(entry.getValue().split(";"));
                for (int i = 0; i < objects.size(); i++) {
                    List<String> childObjects = Arrays.asList(objects.get(i).split(","));
                    childObjects = handleArrays(childObjects);
                    for (int j = 0; j < childObjects.size(); j++) {
                        keyValue = new ArrayList<>(Arrays.asList(childObjects.get(j).split(":", 2)));
                        if (keyValue.size() > 2) {
                            String firstValue = keyValue.get(0);
                            String secondValue = keyValue.get(1) + ":" + keyValue.get(2);

                            keyValue.clear();
                            keyValue.add(firstValue);
                            keyValue.add(secondValue);
                        }
                        for (int k = 0; k < keyValue.size(); k++) {
                            if (keyValue.size() > 1) {
                                if (keyValue.get(k).contains("["))
                                    keyValue.set(k, FixJsonArray(keyValue.get(k)));              //// in case of value
                                else
                                    keyValue.set(k, "\"" + keyValue.get(k).trim() + "\"");            /////////////// in case of key
                            }
                        }
                        jsonObjects.add(keyValue.stream().collect(joining(":")));
                        if (j < childObjects.size() - 1)
                            jsonObjects.add(",");
                    }
                    if (objects.size() > 1) {
                        jsonObjects.add(lastSize + (i > 0 ? 1 : 0), "{");
                        jsonObjects.add(jsonObjects.size(), "}");
                        lastSize = jsonObjects.size();
                        if (i < objects.size() - 1)
                            jsonObjects.add(",");
                    }


                }

                StringBuilder jsonObject = new StringBuilder();
                jsonObjects.forEach(o -> jsonObject.append(o));
                //means one object
                if (keyValue.size() == 1) {
                    result.put(entry.getKey().trim(), jsonObject.toString());
                } else {
                    //array of objects
                    if (objects.size() > 1)
                        result.put(entry.getKey().trim(), String.join("", "[", jsonObject.toString(), "]"));
                        //one object but with standalone key
                    else {
                        result.put(entry.getKey().trim(), String.join("", "{", jsonObject.toString(), "}"));
                    }
                }
                jsonObjects.clear();
                lastSize = jsonObjects.size();

            }
        }
        return result;
    }

    private static String FixJsonArray(String value) {

        String valueBetweenBrackets = value.substring(1, value.length() - 1);
        List<String> eachValue = Arrays.asList(valueBetweenBrackets.split(","));
        StringJoiner result = new StringJoiner(",", "[", "]");
        for (String s : eachValue) {
            String res;
            if (s.contains(":")) {
                String[] stringArray = s.split(":");
                res = (stringArray[0].startsWith("{") ? "{\"" + stringArray[0].substring(1) : "\"" + stringArray[0]) + "\":" + (stringArray[1].startsWith("[") ? "[\"" + stringArray[1].substring(1) : "\"" + stringArray[1]);
                res = res.endsWith("]}") || res.endsWith("]}") ? res.substring(0, res.length() - 2) + "\"" + res.substring(res.length() - 2) : res.endsWith("]") || res.endsWith("}") ? res.substring(0, res.length() - 1) + "\"" + res.charAt(res.length() - 1) : res + "\"";
            } else {
                res = s.startsWith("{") || s.startsWith("{")? s.split(s.split("^(\\[|\\{)+")[0])[0] + "\"" + s.split("^(\\[|\\{)+")[0]:"\"" + s;
                res = res.endsWith("}") | res.endsWith("]") ? res.split("(\\]+|}+)+$")[0]  + "\"" + res.split(res.split("(\\]+|}+)+$")[0])[1]: res + "\"";
            }
            result.add(res);
        }
        return (new StringBuilder(result.toString()).chars().filter(ch->ch=='[').count()+1 == new StringBuilder(result.toString()).chars().filter(ch->ch==']').count()?
                result.toString().substring(0, result.toString().length()-1): result.toString());

    }

    private static List<String> handleArrays(List<String> childObjects) {
        List<String> list = new ArrayList<>();

        //Reconnect the string arrays
        for (int i = 0; i < childObjects.size(); i++) {
            String currentValue = childObjects.get(i);
            if (currentValue.contains("[") && !currentValue.contains("]")) {
                StringBuilder temp = new StringBuilder(currentValue);
                while (temp.chars().filter(ch -> ch == '[').count()!= temp.chars().filter(ch -> ch == ']').count()) {
                    i++;
                    currentValue = childObjects.get(i);
                    temp.append(",").append(currentValue);
                }
//                temp += currentValue;

                list.add(temp.toString());
            } else list.add(currentValue);

        }

        return list;
    }

    private static List<String> handleArraysNew(List<String> childObjects) {
        List<String> list = new ArrayList<>();
        //Reconnect the string arrays

        for (int i = 0; i < childObjects.size(); i++) {
            String currentValue = childObjects.get(i);
            if (occurrencesOfChar(currentValue, '[') != occurrencesOfChar(currentValue, ']')) {
                String temp = "";
                int countOpenBracket = occurrencesOfChar(currentValue, '[');
                int countCloseBracket = occurrencesOfChar(currentValue, ']');
                while (countCloseBracket != countOpenBracket) {
                    temp += currentValue + ",";
                    i++;
                    currentValue = childObjects.get(i);
                    countCloseBracket += occurrencesOfChar(currentValue, ']');
                    countOpenBracket += occurrencesOfChar(currentValue, '[');

                }
                temp += currentValue;
                list.add(temp);
            } else list.add(currentValue);

        }
        return list;
    }


    public static int occurrencesOfChar(String str, char someChar) {
        int count = 0;

        for (int i = 0; i < str.length(); i++) {
            if (str.charAt(i) == someChar) {
                count++;
            }
        }
        return count;
    }

    public static boolean isJSONValid(String test) {
        try {
            new JSONObject(test);
        } catch (JSONException ex) {
            // edited, to include @Arthur's comment
            // e.g. in case JSONArray is valid as well...
            try {
                new JSONArray(test);
            } catch (JSONException ex1) {
                return false;
            }
        }
        return true;
    }

}
