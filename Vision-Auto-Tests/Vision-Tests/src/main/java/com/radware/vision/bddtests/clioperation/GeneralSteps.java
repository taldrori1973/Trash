package com.radware.vision.bddtests.clioperation;

import basejunit.RestTestBase;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.automation.tools.utils.ExecuteShellCommands;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.ElasticSearchHandler;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.LogsHandler;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.*;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Match;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Range;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.TimeStamp;
import com.radware.vision.base.TestBase;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.time.LocalDateTime;
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
        searchList.forEach(selection -> {
            try {
                SearchBool searchBool = new SearchBool();
                LogsHandler.updateTimeRange(searchBool,TestBase.getTestStartTime());
                List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
                        o.logType.equals(selection.logType)).collect(Collectors.toList());
                if (!selection.logType.toString().equalsIgnoreCase("ALL")) {
                    Match mustMatch = new Match();
                    mustMatch.add("kubernetes.container_name", selection.logType.getServerLogType());         /// log type
                    searchBool.getMust().add(mustMatch);
                }

                switch (selection.isExpected.messageAction) {
                    case "false":
                        String isNotExpectedQuery = isNotExpectedQuery(selection, myIgnored, searchBool);

                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-2020.06.25", isNotExpectedQuery) >= 1)
                            addErrorMessage(String.format("The Log %s contains -> %s", selection.logType.serverLogType, selection.expression));
                        break;

                    case "true":
                        String isExpectedQuery = ExpectedQuery(selection, searchBool);
                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-*", isExpectedQuery) < 1)
                            addErrorMessage(String.format("The Log %s does not contain -> %s", selection.logType.serverLogType, selection.expression));
                }
            } catch (Exception e) {
                e.printStackTrace();
                addErrorMessage(e.getMessage());
            }
        });
        reportErrors();
    }


    private void searchExpressionInLog(SearchLog object, String command) {
        LinuxServerCredential rootCredentials = new LinuxServerCredential(getRestTestBase().getRootServerCli().getHost(), getRestTestBase().getRootServerCli().getUser(), getRestTestBase().getRootServerCli().getPassword());
        ExecuteShellCommands executeShellCommands = ExecuteShellCommands.getInstance();
        executeShellCommands.runRemoteShellCommand(rootCredentials, command);
        String output = executeShellCommands.getShellCommandOutput();
        if (output.equals("") && object.isExpected.equals(MessageAction.EXPECTED))
            addErrorMessage(object.logType.toString() + ": does not contain -> " + object.expression);
        else if (!output.equals("") && object.isExpected.equals(MessageAction.NOT_EXPECTED)) {
            addErrorMessage(object.logType.toString() + ": contains -> " + object.expression + "\n" + output);
        }
    }

    @Then("^Service Vision (restart|stop|start) and Wait (\\d+) Minute|Minutes$")
    public void serviceVisionRestartStopStart(String operation, int waitTime) {
        RestTestBase restTestBase = new RestTestBase();
//       kvision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "service vision " + operation, 90 * 1000);
        BasicOperationsHandler.delay(60 * waitTime);
    }

    private enum ServerLogType {
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
    }

    private List<SearchLog> getIgnoreList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }

    private List<SearchLog> getSearchList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                !o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }

    /**
     * @param selection  the experssion in the log we need to search
     * @param myIgnored  the ignoreLIst
     * @param searchBool the orignal query
     * @return return the query after adding the experssion to it
     * @throws JsonProcessingException JsonProcessingException
     */
    private String isNotExpectedQuery(SearchLog selection, List<SearchLog> myIgnored, SearchBool searchBool) throws JsonProcessingException {
        Match mustMatch = new Match();
        mustMatch.add("message", selection.expression);
        searchBool.getMust().add(mustMatch);
        for (SearchLog ignore : myIgnored) {
            if (ignore.logType.serverLogType.equalsIgnoreCase(selection.logType.serverLogType)) {
                Match mustNotMatch = new Match();
                mustNotMatch.add("message", ignore.expression);
                searchBool.getMust_not().add(mustNotMatch);
            }
        }
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(esQuery);
    }

    /**
     * @param selection  the experssion in the log we need to search
     * @param searchBool the orignal query
     * @return return the query after adding the experssion to it
     * @throws JsonProcessingException
     */
    private String ExpectedQuery(SearchLog selection, SearchBool searchBool) throws JsonProcessingException {
        Match mustMatch = new Match();
        mustMatch.add("message", selection.expression);
        searchBool.getMust().add(mustMatch);
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(esQuery);
    }

}
