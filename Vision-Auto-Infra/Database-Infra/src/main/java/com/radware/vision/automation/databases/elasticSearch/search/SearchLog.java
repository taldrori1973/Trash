package com.radware.vision.automation.databases.elasticSearch.search;

import lombok.Data;

@Data
public class SearchLog {
    public enum ServerLogType {
        /**
         * Tomcat-> collector,reporter,vrm,rt alerts
         * Tomcat2-> scheduler,rt alerts,alerts manager
         * JBOSS-> config service
         **/

        ALL(""),
        CONFIGSERVICE("config service"),
        ALERTSMANAGER("alerts manager"),
        SCHEDULER("scheduler"),
        ALERTS("rt alerts"),
        VRM("vrm"),
        REPORTER("reporter"),
        FORMATTER("formatter"),
        COLLECTOR("collector"),
        VDIRECT("vDirect"),
        ES("elasticsearch"),
        FLUENTD("Fluentd"),
        LLS("Lls");

        public String serverLogType;

        ServerLogType(String serverLogType) {
            this.serverLogType = serverLogType;
        }

        private String getServerLogType() {
            return serverLogType;
        }
    }
    public enum MessageAction {
        NOT_EXPECTED("false"),
        EXPECTED("true"),
        IGNORE("ignore");

        public String messageAction;

        MessageAction(String messageAction) {
            this.messageAction = messageAction;
        }
    }
    ServerLogType logType;
    String expression;
    MessageAction isExpected;

    public void setLogType(ServerLogType logType) {
        this.logType = logType;
    }
}
