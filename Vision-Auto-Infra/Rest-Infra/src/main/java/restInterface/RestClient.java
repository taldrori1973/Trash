package restInterface;

import models.RestResponse;
import models.utils.SessionInfoOptions;

import java.util.Optional;

public interface RestClient {

    RestResponse login();

    boolean isConnected();

    void switchTo();

    Optional<String> getUserName();

    Optional<String> getSessionInfoBy(SessionInfoOptions option);

    RestResponse logout();


}
