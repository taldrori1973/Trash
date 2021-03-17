package com.radware.vision.automation.databases.elasticSearch.search;

import com.radware.vision.automation.databases.elasticSearch.search.innerQuery.InnerQuery;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;

@Setter
@Getter
public class SearchBool {
    ArrayList<InnerQuery> must = new ArrayList<>();
    ArrayList<InnerQuery> must_not = new ArrayList<>();
    ArrayList<InnerQuery> should = new ArrayList<>();
}
