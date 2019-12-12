package com.radware.vision.infra.visionDatabase.jdbc.vision_ng_schema.daos;

import com.radware.vision.infra.visionDatabase.jdbc.JDBCConnectionException;
import com.radware.vision.infra.visionDatabase.jdbc.JDBCConnectionSingleton;
import com.radware.vision.infra.visionDatabase.jdbc.VisionDBSchema;
import com.radware.vision.infra.visionDatabase.jdbc.vision_ng_schema.entities.VisionLicense;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class VisionLicenseDao implements Dao<VisionLicense,String> {

    private Connection connection;
    private String tableName;
    public VisionLicenseDao() throws JDBCConnectionException {
        this.connection= JDBCConnectionSingleton.getInstance().getDBConnection(VisionDBSchema.VISION_NG);
        this.tableName="vision_license";
    }

    @Override
    public Optional<VisionLicense> get(String key) {
        VisionLicense visionLicenseEntity=null;
        String query="SELECT * FROM %s WHERE row_id='%s'";
        query=String.format(query,tableName,key);
        try {
            Statement statement=connection.createStatement();
            ResultSet result =statement.executeQuery(query);
            result.last();
            if(result.getRow()>1) throw new SQLDataException("More than one row was found for the key: "+key);
            if(result.getRow()==0) return Optional.empty();
            result.first();
            visionLicenseEntity=new VisionLicense(result.getString(1),result.getInt(2),
                    result.getString(3),result.getString(4),result.getString(5),
                    result.getString(6),result.getString(7),result.getTimestamp(8),result.getBoolean(9));
            return Optional.of(visionLicenseEntity);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<VisionLicense> getAll() {
       List<VisionLicense> visionLicenses=new ArrayList<>();
        String query="SELECT * FROM %s";
        query=String.format(query,tableName);
        try {
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while(result.next()){
                VisionLicense visionLicenseEntity = new VisionLicense(result.getString(1), result.getInt(2),
                        result.getString(3), result.getString(4), result.getString(5),
                        result.getString(6), result.getString(7), result.getTimestamp(8), result.getBoolean(9));

                visionLicenses.add(visionLicenseEntity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return visionLicenses;
    }

    @Override
    public void save(VisionLicense visionLicense) {

    }

    @Override
    public void update(VisionLicense visionLicense) {

    }

    @Override
    public void delete(VisionLicense visionLicense) {
        try {
            String query=String.format("DELETE FROM %s WHERE row_id='%s'",tableName,visionLicense.getRow_id());
            Statement statement = connection.createStatement();
            statement.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
