package models;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
public class RestResponse {

    private StatusCode statusCode;
    private String statusLine;
    private Body body;
    private Map<String, String> headers;
    private Map<String, String> cookies;
    private ContentType contentType;
    private String sessionId;
    private long time;
    private List<String> errors;
}
