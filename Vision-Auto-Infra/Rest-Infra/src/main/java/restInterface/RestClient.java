package restInterface;

import models.RestResponse;

public interface RestClient {

    RestResponse login();

    boolean isConnected();

    void switchTo();

    RestResponse logout();


}
