package models;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import utils.MapUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Getter
@EqualsAndHashCode
@ToString
public class RestRequestSpecification {

    private static final String ACCEPT_HEADER_KEY = "Accept";
    private static final String CONTENT_TYPE_HEADER_KEY = "Content-Type";
    private static final String COOKIE_HEADER_KEY = "Cookie";


    private Method method;
    private String basePath;
    private Map<String, Object> pathParams;
    private Map<String, Object> queryParams;

    private ContentType accept;
    private ContentType contentType;
    private Map<String, Object> headers;
    private Map<String, Object> cookies;
    private Body body;

    public RestRequestSpecification(Method method) {
        this.method = Objects.requireNonNull(method);
        this.setBasePath(null);
        this.pathParams = new HashMap<>();
        this.queryParams = new HashMap<>();
        this.setAccept(null);
        this.setContentType(null);
        this.headers = new HashMap<>();
        this.cookies = new HashMap<>();
    }

    public static void main(String[] args) {
        RestRequestSpecification postRequest = new RestRequestSpecification(Method.POST);


    }

    public void setBasePath(String basePath) {
        if (Objects.isNull(basePath)) this.basePath = "";
        else this.basePath = basePath;
    }

    public void addPathParams(String firstParameterName, Object firstParameterValue, Object... parameterNameValuePairs) throws IllegalArgumentException {
        addParams(this.pathParams, firstParameterName, firstParameterValue, parameterNameValuePairs);
    }

    public void removePathParams(String... names) {
        removeParams(this.pathParams, names);
    }

    public void clearPathParams() {
        clearParams(this.pathParams);
    }

    public void addQueryParams(String firstParameterName, Object firstParameterValue, Object... parameterNameValuePairs) {
        addParams(this.queryParams, firstParameterName, firstParameterValue, parameterNameValuePairs);
    }

    public void removeQueryParams(String... names) {
        removeParams(this.queryParams, names);
    }

    public void clearQueryParams() {
        clearParams(this.pathParams);
    }

    private void addParams(Map<String, Object> params, String firstParameterName, Object firstParameterValue, Object[] parameterNameValuePairs) {
        Objects.requireNonNull(firstParameterName);
        Objects.requireNonNull(firstParameterValue);
        params.put(firstParameterName, firstParameterValue);
        if (!Objects.isNull(parameterNameValuePairs)) {
            MapUtils.map(params, parameterNameValuePairs);
        }
    }

    private void removeParams(Map<String, Object> params, String[] names) {
        Objects.requireNonNull(names);
        for (String name : names) {
            params.remove(name);
        }
    }

    private void clearParams(Map<String, Object> params) {
        params.clear();
    }

    public void setAccept(ContentType accept) {
        this.accept = accept;
    }

    public void setContentType(ContentType contentType) {
        this.contentType = contentType;
    }

    public void addHeaders(String firstHeaderName, Object firstHeaderValue, Object... headerNameValuePairs) {
        addParams(this.headers, firstHeaderName, firstHeaderValue, headerNameValuePairs);
    }

    public void removeHeaders(String... names) {
        removeParams(this.headers, names);
    }

    public void clearHeaders() {
        clearParams(this.headers);
    }

    public void addCookies(String firstCookieName, Object firstCookieValue, Object... cookieNameValuePairs) {
        addParams(this.cookies, firstCookieName, firstCookieValue, cookieNameValuePairs);
    }

    public void removeCookies(String... names) {
        removeParams(this.cookies, names);
    }

    public void clearCookies() {
        clearParams(this.cookies);
    }

    public void setBody(String body) {
        this.body = new Body(body);
    }
}
