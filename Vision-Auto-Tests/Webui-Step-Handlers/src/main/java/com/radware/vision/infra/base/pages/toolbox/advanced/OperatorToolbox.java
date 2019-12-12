package com.radware.vision.infra.base.pages.toolbox.advanced;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;

public class OperatorToolbox extends WebUIVisionBasePage {


    String tableId = "adminScriptTable";


    public OperatorToolbox() {
        super("Operator Toolbox", "AdminScriptsTemplate.xml", false);
    }

    public WebUITable getOperatorToolboxTable() {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        return table;
    }

    public enum OperatorToolboxTree {

        OPERATOR_TOOLBOX("gwt-uid-363"),
        CONFIGURATION("gwt-debug-Configuration-content"),
        DATA_EXPORT("gwt-debug-Data Export-content"),
        EMERGENCY("gwt-debug-Emergency-content"),
        HIGH_AVAILABILITY("gwt-debug-High Availability-content"),
        MONITORING("gwt-debug-Monitoring-content"),
        OPERATIONS("gwt-debug-Operations-content"),
        UNASSIGNED("gwt-debug-Unassigned-content");
        private String id;

        OperatorToolboxTree(String value) {
            this.id = value;
        }

        public String getId() {
            return id;
        }


    }

}
