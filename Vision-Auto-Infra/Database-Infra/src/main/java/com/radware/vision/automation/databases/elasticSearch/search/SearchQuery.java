package com.radware.vision.automation.databases.elasticSearch.search;

import lombok.*;

@Data
@AllArgsConstructor

public class SearchQuery {
    private SearchBool bool;
}
