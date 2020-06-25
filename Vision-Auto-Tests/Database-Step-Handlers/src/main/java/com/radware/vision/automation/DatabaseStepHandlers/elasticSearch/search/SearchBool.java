package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;

@Setter
@Getter
public class SearchBool {
    ArrayList<InnerQuery> must = new ArrayList<InnerQuery>();
    ArrayList<InnerQuery> must_not = new ArrayList<InnerQuery>();
    ArrayList<InnerQuery> should = new ArrayList<InnerQuery>();
}
