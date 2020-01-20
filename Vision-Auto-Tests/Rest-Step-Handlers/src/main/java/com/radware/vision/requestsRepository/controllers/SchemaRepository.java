package com.radware.vision.requestsRepository.controllers;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.requestsRepository.models.FieldPojo;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SchemaRepository {
    private static String schema_file_Path_pattern = "restApis/Generic-REST-API/bodySchemaPojo/%s/%s.json";
    private static String key_pattern = "%s_%s";//{deviceName}_{filename}
    private Map<String, List<FieldPojo>> fieldPojoMap;
    private ObjectMapper objectMapper;
    private static SchemaRepository instance = new SchemaRepository();

    private SchemaRepository() {
        this.fieldPojoMap=new HashMap<>();
        this.objectMapper = new ObjectMapper();
    }

    public static SchemaRepository getInstance() {
        return instance;
    }

    public List<FieldPojo> getFieldPojoList(String deviceName, String fileName) {
        String filePath = String.format(schema_file_Path_pattern, deviceName, fileName);
        String key = String.format(key_pattern, deviceName, fileName);
        if (fieldPojoMap.containsKey(key)) return fieldPojoMap.get(key);
        try (InputStream resourceAsStream = this.getClass().getClassLoader().getResourceAsStream(filePath)) {
            List<FieldPojo> fieldPojos = Arrays.asList(objectMapper.readValue(resourceAsStream, FieldPojo[].class));
            fieldPojoMap.put(key, fieldPojos);
            return fieldPojos;
        } catch (IOException e) {
            throw new IllegalArgumentException(String.format("the file path %s not exist", filePath));
        }
    }

}
