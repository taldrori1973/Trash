package com.radware.vision.bddtests.clioperation;

import basejunit.RestTestBase;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.automation.tools.utils.ExecuteShellCommands;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.ElasticSearchHandler;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.*;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Match;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Range;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.TimeStamp;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;

public class GeneralSteps extends BddCliTestBase {

    @Given("^CLI Clear vision logs$")
    public void clearAllLogs() {
        ElasticSearchHandler.deleteESIndex("logstash*");
    }

    @Then("^CLI Check if logs contains$")
    public void checkIfESLogsContains(List<SearchLog> selections) {
        List<SearchLog> ignoreList = getIgnoreList(selections);
        List<SearchLog> searchList = getSearchList(selections);
        SearchBool searchBool = new SearchBool();
        updateTimeRange(searchBool);
        searchList.forEach(selection -> {
            try {
                List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
                        o.logType.equals(selection.logType)).collect(Collectors.toList());
                if (!selections.get(0).logType.toString().equalsIgnoreCase("ALL")) {
                    Match mustMatch = new Match();
                    mustMatch.add("kubernetes.container_name", selection.logType.getServerLogType());         /// log type
                    searchBool.getMust().add(mustMatch);
                }

                switch (selection.isExpected.messageAction) {
                    case "false":
                        String isNotExpectedQuery = isNotExpectedQuery(selection, myIgnored, searchBool);

                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-2020.06.25", isNotExpectedQuery) >= 1)
                            addErrorMessage(String.format("The Log %s contains -> %s", selection.logType.serverLogType, selection.expression));
                    case "true":

                        String isExpectedQuery = ExpectedQuery(selection, myIgnored, searchBool);
                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-2020.06.25", isExpectedQuery) >= 1)
                            addErrorMessage(String.format("The Log %s contains -> %s", selection.logType.serverLogType, selection.expression));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        reportErrors();
    }


    /**
     * search if an expression exists in server logs by types
     * <p>
     * //     * @param selections - SearchLog list
     */
//    @Then("^CLI Check if logs contains$")
//    public void checkIfLogsContains(List<SearchLog> selections) {
//        String command = "grep -Ei";
//        String commandToSkip = " |grep -v ";
//
//        if (!selections.get(0).logType.toString().equalsIgnoreCase("ALL")) {
//            List<SearchLog> ignoreList = getIgnoreList(selections);
//
//            List<SearchLog> searchList = getSearchList(selections);
//
//            searchList.forEach(selection -> {
//                String checkForErrors = String.format("%s \"%s\" %s", command, selection.expression, selection.logType.getServerLogType());
//                List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
//                        o.logType.equals(selection.logType)).collect(Collectors.toList());
//
//                for (SearchLog ignore : myIgnored)
//                    checkForErrors = checkForErrors.concat(String.format("%s \"%s\"", commandToSkip, ignore.expression));
//
//                searchExpressionInLog(selection, checkForErrors);
//            });
//        }
////        All
//        else {
//            List<SearchLog> ignoreList = getIgnoreList(selections);
//
//            for (ServerLogType selection : ServerLogType.values()) {
//                if (!selection.toString().equalsIgnoreCase("ALL")) {
//                    selections.get(0).setLogType(selection);
//
//                    String checkForErrors = String.format("%s \"%s\" %s", command, selections.get(0).expression, selection.getServerLogType());
//                    List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
//                            o.logType.equals(selections.get(0).logType)).collect(Collectors.toList());
//
//                    for (SearchLog ignore : myIgnored)
//                        checkForErrors = checkForErrors.concat(commandToSkip + " " + ignore.expression);
//
//                    searchExpressionInLog(selections.get(0), checkForErrors);
//                }
//            }
//        }
//        reportErrors();
//    }
//    private void searchExpressionInLog(SearchLog object, String command) {
//        LinuxServerCredential rootCredentials = new LinuxServerCredential(getRestTestBase().getRootServerCli().getHost(), getRestTestBase().getRootServerCli().getUser(), getRestTestBase().getRootServerCli().getPassword());
//        ExecuteShellCommands executeShellCommands = ExecuteShellCommands.getInstance();
//        executeShellCommands.runRemoteShellCommand(rootCredentials, command);
//        String output = executeShellCommands.getShellCommandOutput();
//        if (output.equals("") && object.isExpected.equals(MessageAction.EXPECTED))
//            addErrorMessage(object.logType.toString() + ": does not contain -> " + object.expression);
//        else if (!output.equals("") && object.isExpected.equals(MessageAction.NOT_EXPECTED)) {
//            addErrorMessage(object.logType.toString() + ": contains -> " + object.expression + "\n" + output);
//        }
//    }

    @Then("^Service Vision (restart|stop|start) and Wait (\\d+) Minute|Minutes$")
    public void serviceVisionRestartStopStart(String operation, int waitTime) {
        RestTestBase restTestBase = new RestTestBase();
//       kvision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "service vision " + operation, 90 * 1000);
        BasicOperationsHandler.delay(60 * waitTime);
    }

    private enum ServerLogType {
        ALL(""),
        //        TOMCAT("/opt/radware/mgt-server/third-party/tomcat/logs/*.log"),
//        MAINTENANCE("/opt/radware/storage/maintenance/logs/*.log"),
//        JBOSS("/opt/radware/mgt-server/third-party/jboss-4.2.3.GA/server/insite/log/server/*.log"),
//        TOMCAT2("/opt/radware/storage/mgt-server/third-party/tomcat2/logs/*.log"),
//        UPGRADE("/opt/radware/storage/maintenance/upgrade/upgrade.log"),
//        BACKUP("/opt/radware/storage/maintenance/logs/backups/*.*"),
//        VISION_INSTALL("/tmp/logs/Vision_install.log"),
        CONFIGSERVICE("config service"),
        ALERTSMANAGER("alerts"),
        SCHEDULER("scheduler"),
        ALERTS("alerts"),
        VRM("vrm"),
        REPORTER("reporter"),
        COLLECTOR("collector"),
        VDIRECT("vDirect"),
        ES("elasticsearch"),
        FLUENTD("Fluentd"),
        LLS("Lls");

        private String serverLogType;

        ServerLogType(String serverLogType) {
            this.serverLogType = serverLogType;
        }

        private String getServerLogType() {
            return serverLogType;
        }
    }

    public static class SearchLog {
        ServerLogType logType;
        String expression;
        MessageAction isExpected;

        public void setLogType(ServerLogType logType) {
            this.logType = logType;
        }
    }

    private enum MessageAction {
        NOT_EXPECTED("false"),
        EXPECTED("true"),
        IGNORE("ignore");

        private String messageAction;

        MessageAction(String messageAction) {
            this.messageAction = messageAction;
        }

        private String getMessageAction() {
            return messageAction;
        }

    }

    private List<SearchLog> getIgnoreList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }

    private List<SearchLog> getSearchList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                !o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }

    private String isNotExpectedQuery(SearchLog selection, List<SearchLog> myIgnored, SearchBool searchBool) throws JsonProcessingException {
        Match shouldMatch = new Match();
        shouldMatch.add("message", selection.expression);
        searchBool.getShould().add(shouldMatch);
        for (SearchLog ignore : myIgnored) {
            Match mustNotMatch = new Match();
            mustNotMatch.add("message", ignore.expression);
            searchBool.getMust_not().add(mustNotMatch);
        }
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        String query = mapper.writeValueAsString(esQuery);
        return query;
    }

    private String ExpectedQuery(SearchLog selection, List<SearchLog> myIgnored, SearchBool searchBool) throws JsonProcessingException {
        Match mustMatch = new Match();
        mustMatch.add("message", selection.expression);
        searchBool.getMust().add(mustMatch);
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        String query = mapper.writeValueAsString(esQuery);
        return query;
    }

    private void updateTimeRange(SearchBool searchBool){
        TimeStamp timeStamp= new TimeStamp();
        timeStamp.addFilter("gt","2020-06-25T04:00:18,824Z");
        timeStamp.addFilter("lt","2020-06-25aaa");
        Range range= new Range(timeStamp);
        searchBool.getMust().add(range);
    }
}
