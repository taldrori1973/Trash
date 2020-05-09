package com.radware.vision.automation.DatabaseStepHandlers.jdbc.vision_ng_schema.entities;

import java.sql.Timestamp;

public class VisionLicense {
    private String row_id;
    private int ormversion;
    private String name;
    private String description;
    private String license_str;
    private String product_name;
    private String feature_name;
    private Timestamp license_activation_date;
    private boolean is_expired;

    public VisionLicense(String row_id, int ormversion, String name,
                         String description, String license_str, String product_name,
                         String feature_name, Timestamp license_activation_date, boolean is_expired) {
        this.row_id = row_id;
        this.ormversion = ormversion;
        this.name = name;
        this.description = description;
        this.license_str = license_str;
        this.product_name = product_name;
        this.feature_name = feature_name;
        this.license_activation_date = license_activation_date;
        this.is_expired = is_expired;
    }

    public String getRow_id() {
        return row_id;
    }

    public void setRow_id(String row_id) {
        this.row_id = row_id;
    }

    public int getOrmversion() {
        return ormversion;
    }

    public void setOrmversion(int ormversion) {
        this.ormversion = ormversion;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLicense_str() {
        return license_str;
    }

    public void setLicense_str(String license_str) {
        this.license_str = license_str;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getFeature_name() {
        return feature_name;
    }

    public void setFeature_name(String feature_name) {
        this.feature_name = feature_name;
    }

    public Timestamp getLicense_activation_date() {
        return license_activation_date;
    }

    public void setLicense_activation_date(Timestamp license_activation_date) {
        this.license_activation_date = license_activation_date;
    }

    public boolean isIs_expired() {
        return is_expired;
    }

    public void setIs_expired(boolean is_expired) {
        this.is_expired = is_expired;
    }

    @Override
    public boolean equals(Object obj) {
        VisionLicense other= (VisionLicense) obj;
        if(super.equals(obj)) return true;
        return this.getRow_id().equals(other.getRow_id());
    }
}
