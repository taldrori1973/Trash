package restInterface.client;

import models.RestResponse;

public interface BasicAuthBasedRestClient extends RestClient {

    RestResponse checkConnection();

}
