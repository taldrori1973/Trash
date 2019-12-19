package mappers.restAssured;

import java.util.Map;

public class MapUtils {
    public static void map(Map<String, Object> map, Object[] parameterNameValuePairs) throws IllegalArgumentException {

        int size = parameterNameValuePairs.length;
        if (size == 0) return;
        if (size % 2 != 0) throw new IllegalArgumentException("Key without value");

        for (int i = 0; i < size - 1; i += 2) {
            if (!(parameterNameValuePairs[i] instanceof String))
                throw new IllegalArgumentException("Key must be String");

            String key = (String) parameterNameValuePairs[i];
            Object value = parameterNameValuePairs[i + 1];
            map.put(key, value);
        }
    }
}
