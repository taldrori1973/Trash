package com.radware.vision.automation.databases.elasticSearch.search.innerQuery;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Range implements InnerQuery {
    RangeFilter range;
}
