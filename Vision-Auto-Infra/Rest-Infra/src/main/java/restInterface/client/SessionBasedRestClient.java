package restInterface.client;

import models.RestResponse;

public interface SessionBasedRestClient extends RestClient {

    RestResponse login();

    boolean isLoggedIn();

    RestResponse logout();


}
