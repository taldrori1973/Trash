package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search;

import lombok.*;

@Data
@AllArgsConstructor

public class SearchQuery {
    private SearchBool bool;
}
