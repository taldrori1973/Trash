package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 9/9/2015.
 */
public enum PaginationArrows {

    SELECT_ARROW_TO_USE_PAGINATION(""),
    NEXT_PAGE("nextPage"),
    PREV_PAGE("prevPage"),
    FIRST_PAGE("firstPage"),
    LAST_PAGE("lastPage");

    private String page;

    private PaginationArrows(String page) {
        this.page = page;
    }

    public String getPage() {
        return this.page;
    }
}
