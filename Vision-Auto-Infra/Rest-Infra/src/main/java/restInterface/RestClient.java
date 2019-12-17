package restInterface;

import models.utils.SessionInfoOptions;

import java.util.Optional;

public interface RestClient {

    int login();

    boolean isConnected();

    void switchTo();

    Optional<String> getUserName();

    Optional<String> getSessionInfoBy(SessionInfoOptions option);

    int logout();


}
