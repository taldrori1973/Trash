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
                        o.getLogType().equals(selection.getLogType())).collect(Collectors.toList());
                if (!selection.getLogType().toString().equalsIgnoreCase("ALL")) {
                    Match mustMatch = new Match();
                    mustMatch.add("kubernetes.container_name", selection.getLogType().serverLogType);         /// log type
                    searchBool.getMust().add(mustMatch);
                }

                switch (selection.getIsExpected().messageAction) {
                    case "false":
                        String isNotExpectedQuery = LogsHandler.isNotExpectedQuery(selection, myIgnored, searchBool);

                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-*", isNotExpectedQuery) >= 1)
                            addErrorMessage(String.format("The Log %s contains -> %s", selection.getLogType().serverLogType, selection.getExpression()));
                        break;

                    case "true":
                        String isExpectedQuery = LogsHandler.ExpectedQuery(selection, searchBool);
                        if (ElasticSearchHandler.searchGetNumberOfHits("logstash-*", isExpectedQuery) < 1)
                            addErrorMessage(String.format("The Log %s does not contain -> %s", selection.getLogType().serverLogType, selection.getExpression()));
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
        if (output.equals("") && object.getIsExpected().equals(SearchLog.MessageAction.EXPECTED))
            addErrorMessage(object.getLogType().toString() + ": does not contain -> " + object.getExpression());
        else if (!output.equals("") && object.getIsExpected().equals(SearchLog.MessageAction.NOT_EXPECTED)) {
            addErrorMessage(object.getLogType().toString() + ": contains -> " + object.getExpression() + "\n" + output);
        }
    }

    @Then("^Service Vision (restart|stop|start) and Wait (\\d+) Minute|Minutes$")
    public void serviceVisionRestartStopStart(String operation, int waitTime) {
        RestTestBase restTestBase = new RestTestBase();
//       kvision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "service vision " + operation, 90 * 1000);
        BasicOperationsHandler.delay(60 * waitTime);
    }


    private List<SearchLog> getIgnoreList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                o.getIsExpected().equals(SearchLog.MessageAction.IGNORE)).collect(Collectors.toList());
    }

    private List<SearchLog> getSearchList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                !o.getIsExpected().equals(SearchLog.MessageAction.IGNORE)).collect(Collectors.toList());
    }


}
