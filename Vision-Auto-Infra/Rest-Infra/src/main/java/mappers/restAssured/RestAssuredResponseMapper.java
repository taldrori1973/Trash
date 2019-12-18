package mappers.restAssured;

import com.fasterxml.jackson.databind.JsonNode;
import io.restassured.http.Header;
import io.restassured.response.Response;
import io.restassured.response.ResponseBody;
import models.Body;
import models.ContentType;
import models.RestResponse;
import models.StatusCode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class RestAssuredResponseMapper {

    private RestAssuredResponseMapper() {

    }

    public static RestResponse map(Response response) {

        StatusCode statusCode = getStatusCode(response);
        String statusLine = response.getStatusLine();
        Body body = getBody(response);
        Map<String, String> headers = getHeaders(response);
        Map<String, String> cookies = response.getCookies();
        ContentType contentType = getContentType(response);
        String sessionId = response.getSessionId();
        long time = response.getTime();


        return new RestResponse(statusCode, statusLine, body, headers, cookies, contentType, sessionId, time);
    }

    private static ContentType getContentType(Response response) {
        String contentType = response.getContentType();
        return ContentType.fromContentType(contentType);
    }

    private static Map<String, String> getHeaders(Response response) {
        Map<String, String> headers = new HashMap<>();
        List<Header> headersList = response.getHeaders().asList();
        headersList.forEach(header -> headers.put(header.getName(), header.getValue()));
        return headers;
    }


    private static Body getBody(Response response) {

        ResponseBody body = response.getBody();

        String bodyAsString = body.asString();
        Optional<JsonNode> bodyAsJsonNode;

        try {
            bodyAsJsonNode = Optional.of(body.as(JsonNode.class));
        } catch (IllegalStateException e) {
            bodyAsJsonNode = Optional.empty();
        }


        return new Body(bodyAsString, bodyAsJsonNode);
    }

    private static StatusCode getStatusCode(Response response) {
        int statusCode = response.getStatusCode();
        return StatusCode.getStatusCode(statusCode);
    }
}
