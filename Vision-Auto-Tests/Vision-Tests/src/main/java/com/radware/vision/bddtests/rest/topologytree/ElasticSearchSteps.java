package com.radware.vision.bddtests.rest.topologytree;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.bddtests.remotessh.AttacksSteps;
import com.radware.vision.infra.testresthandlers.ElasticSearchHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

public class ElasticSearchSteps extends BddRestTestBase {
    @Given("^REST Delete ES document with data \"(.*)\" from index \"(.*)\"$")
    public void deleteESDocument(String data, String index) {
        ElasticSearchHandlerNew.deleteESDocument(data, index);
    }

    @Given("^REST Delete ES index \"(.*)\"$")
    public void deleteESIndex(String index) {
        ElasticSearchHandlerNew.deleteESIndex(index);
    }

    /**
     * @param indexName    - if the index name without week number so you should enter the full name , but if there is a week number for example:
     *                     dp-attack-raw-1294 , so you should enter the index name as following:dp-attack-raw-* .
     *                     and that because the week number changes every week , these step will check if there is an index by full name or by prefix-*.
     *                     The following params are for simulating attack when there is no index found.
     * @param weekSlice    Every how many weeks the ES creates new index - relevant only for indices of the pattern : {prefix}-{number}
     * @param numOfAttacks
     * @param fileName
     * @param deviceType
     * @param deviceIndex
     * @param ld
     * @param waitTimeout
     * @param withAttackId
     */
    @Given("^That Elasticsearch Index \"(.*)\"(?: with Week Slice (\\d+))? Already Exists or Create the Index by Simulating (\\d+) attacks of type \"(.*)\" on \"(.*)\" (\\d+)(?: with loopDelay (\\d+))?(?: and wait (\\d+) seconds)?( with attack ID)?$")
    public void isIndexExist(String indexName, Integer weekSlice, int numOfAttacks, String fileName, SUTDeviceType deviceType, int deviceIndex, Integer ld, Integer waitTimeout, String withAttackId) {
        if (ElasticSearchHandlerNew.getIndex(restTestBase.getVisionRestClient().getDeviceIp(), indexName, "last", weekSlice) == null) {
            AttacksSteps attacksSteps = new AttacksSteps();
            attacksSteps.runSimulatorFromDevice(numOfAttacks, fileName, deviceType, deviceIndex, ld, waitTimeout, withAttackId);
        }
    }

    /**
     * @param indexName -  if the index name without week number so you should enter the full name , but if there is a week number for example:
     *                  dp-attack-raw-1294 , so you should enter the index name as following:dp-attack-raw-* .
     *                  and that because the week number changes every week .
     *                  VERY IMPORTANT : if the index you provided is with (prefix-*) and there are more than on index with the same prefix and different week number,
     *                  so these step will check only the last index i.e:the biggest week number.
     * @param expected  , how many mappings the index have, the mappings number equals how many time the attribute "type" exists under mapping.
     */

    @Then("^Validate that the Number of the Mapping Attributes at Index \"(.*)\"(?: with Week Slice (\\d+))? Equals to (\\d+)$")
    public void validateMappingAttributeNumber(String indexName, Integer weekSlice, int expected) {
        int actual = ElasticSearchHandlerNew.getNumberOfAttributes(restTestBase.getVisionRestClient().getDeviceIp(), indexName, weekSlice);
        if (actual != expected)
            BaseTestUtils.report(String.format("%s Index Mapping Attributes:\nActual=%d, Expected:%d", indexName, actual, expected), Reporter.FAIL);
    }


    /**
     * @param migrationTask should be one of the following , if there are more please add them to the ElasticSearchHandler.MigrationTask Enum before:
     *                      BDoSBaseLineRatesMigrationTask,
     *                      DFAttackMigrationTask,
     *                      DPAttackDurationMigrationTask,
     *                      DPAttackSamplesMigrationTask
     * @param seconds       How many minutes should wait for the task to finish after run it.
     *                      <p>
     *                      you can check the status run at "/opt/radware/mgt-server/third-party/tomcat/logs/reporter.log"
     *                      This file will be empty before running the task
     */
    @Then("^Run ElasticSearch Migration Task \"([^\"]*)\" and Wait (\\d+) Seconds$")
    public void runElasticSearchMigrationTaskAndWaitNumMinutes(ElasticSearchHandler.MigrationTask migrationTask, int seconds) throws InterruptedException {
        ElasticSearchHandler.runMigrationTask(migrationTask, seconds);
    }


    @Then("^ElasticSearch - Validate \"([^\"]*)\" Attribute (NOT CONTAINS|CONTAINS) the Value \"([^\"]*)\" at(?: \"(FIRST|LAST)\")? Index of \"([^\"]*)\"(?: with Week Slice (\\d+))?$")
    public void elasticSearchValidateAttributeCONTAINSTheValueAtIndexOfWithWeekSlice(String attribute, String operation, String value, String sliceToGet, String indexName, Integer weekSlice) {
        if (sliceToGet != null ^ weekSlice != null) {
            BaseTestUtils.report(
                    String.format("The following two arguments : (\"(FIRST|LAST)\") and (\"with Week Slice <NUMBER>\") are related ;" +
                            " should be both null OR both not null.\n" + "the first argument sent is \"%s\" and the second is \"%s\"", sliceToGet, weekSlice),
                    Reporter.FAIL);
        }
        String index = ElasticSearchHandlerNew.getIndex(restTestBase.getVisionRestClient().getDeviceIp(), indexName, sliceToGet, weekSlice);

        boolean expected = operation.equalsIgnoreCase("CONTAINS");
        boolean actual = ElasticSearchHandlerNew.isIndexContainsKeyValue(index, attribute, value);

        if (expected ^ actual) {
            BaseTestUtils.report(String.format("The Expected is %s, but actual is %s", expected ? "CONTAINS" : "NOT CONTAINS", actual ? "CONTAINS" : "NOT CONTAINS"), Reporter.FAIL);
        }

    }

}

