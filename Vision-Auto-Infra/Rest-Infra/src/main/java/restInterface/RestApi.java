package restInterface;

import models.RestRequestSpecification;
import models.RestResponse;

public interface RestApi {

    RestResponse sendRequest(RestRequestSpecification requestSpecification);


}
