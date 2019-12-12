package com.radware.vision.infra.enums;

/**
 * Created by urig on 5/21/2015.
 */
public enum LanguageEnum {

    English("EnglishItem"),
    Chinese("ChineseItem"),
    Korean("KoreanItem"),
    Japanese("JapaneseItem");

    String language;

    LanguageEnum(String language) {
        this.language = language;
    }

    public String getLanguage() {
        return this.language;
    }

}
