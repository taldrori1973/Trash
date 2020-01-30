package com.radware.bddtests;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * Created by AviH on 30-Nov-17.
 */
@RunWith(Cucumber.class)
@CucumberOptions(format = {"pretty", "html:target/cucumber", "json:target/cucumber.json"},
        glue = {"com.radware.vision.bddtests"},
        features = {"src/test/resources/Features"},
        strict = true,
        tags = {"@Functional"})
public class RunVisionBddTests {

}
