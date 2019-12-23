package restInterface;

import models.RestResponse;

public interface RestClient {

    RestResponse login();

    boolean isLoggedIn();

    void switchTo();

    RestResponse logout();


}
