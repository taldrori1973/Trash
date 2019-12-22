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
    private Map<String, String> pathParams;
    private Map<String, String> queryParams;

    private ContentType accept;
    private ContentType contentType;
    private Map<String, String> headers;
    private Map<String, String> cookies;
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


    public void setPathParams(Map<String, String> pathParams) {
        this.pathParams = pathParams;
    }

    public void addPathParams(String firstParameterName, String firstParameterValue, String... parameterNameValuePairs) throws IllegalArgumentException {
        addParams(this.pathParams, firstParameterName, firstParameterValue, parameterNameValuePairs);
    }

    public void removePathParams(String... names) {
        removeParams(this.pathParams, names);
    }

    public void clearPathParams() {
        clearParams(this.pathParams);
    }


    public void setQueryParams(Map<String, String> queryParams) {
        this.queryParams = queryParams;
    }

    public void addQueryParams(String firstParameterName, String firstParameterValue, String... parameterNameValuePairs) {
        addParams(this.queryParams, firstParameterName, firstParameterValue, parameterNameValuePairs);
    }

    public void removeQueryParams(String... names) {
        removeParams(this.queryParams, names);
    }

    public void clearQueryParams() {
        clearParams(this.pathParams);
    }


    private void addParams(Map<String, String> params, String firstParameterName, String firstParameterValue, String[] parameterNameValuePairs) {
        Objects.requireNonNull(firstParameterName);
        Objects.requireNonNull(firstParameterValue);
        params.put(firstParameterName, firstParameterValue);
        if (!Objects.isNull(parameterNameValuePairs)) {
            MapUtils.map(params, parameterNameValuePairs);
        }
    }

    private void removeParams(Map<String, String> params, String[] names) {
        Objects.requireNonNull(names);
        for (String name : names) {
            params.remove(name);
        }
    }

    private void clearParams(Map<String, String> params) {
        params.clear();
    }


    public void setAccept(ContentType accept) {
        this.accept = accept;
    }


    public void setContentType(ContentType contentType) {
        this.contentType = contentType;
    }

    public void setHeaders(Map<String, String> headers) {
        this.headers = headers;
    }

    public void addHeaders(String firstHeaderName, String firstHeaderValue, String... headerNameValuePairs) {
        addParams(this.headers, firstHeaderName, firstHeaderValue, headerNameValuePairs);
    }

    public void removeHeaders(String... names) {
        removeParams(this.headers, names);
    }

    public void clearHeaders() {
        clearParams(this.headers);
    }

    public void setCookies(Map<String, String> cookies) {
        this.cookies = cookies;
    }

    public void addCookies(String firstCookieName, String firstCookieValue, String... cookieNameValuePairs) {
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
