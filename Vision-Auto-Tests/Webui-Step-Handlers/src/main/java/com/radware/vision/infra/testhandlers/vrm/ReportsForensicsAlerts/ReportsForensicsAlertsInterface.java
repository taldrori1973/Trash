package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import java.util.Map;

public interface ReportsForensicsAlertsInterface {
    void create(String viewBase, Map<String, String> map) throws Exception;

    void validate();

    void edit();

    void delete();
}
