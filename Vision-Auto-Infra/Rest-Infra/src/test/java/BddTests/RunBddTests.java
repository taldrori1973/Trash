package BddTests;


import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(plugin = "json:target/cucumber-report.json", features = "src/test/resources/Features", tags = "@run")
public class RunBddTests {
}
