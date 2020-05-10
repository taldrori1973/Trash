package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;

import java.util.Optional;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:29 AM
 */
public class GenericCRUD {
    private static JDBCConnectionSingleton jdbcConnection = JDBCConnectionSingleton.getInstance();

    public <T>Optional<T> getOneValue(){

        return null;
    }
}
