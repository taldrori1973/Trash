package com.radware.vision.infra.enums.enumsutils;

import org.openqa.selenium.NoSuchElementException;

import java.util.Arrays;

public class EnumsUtils {


    public static <E extends Enum<E> & Element> E getEnumByElementName(Class<E> enumClass, String name) {
        return Arrays.stream(enumClass.getEnumConstants())
                .filter(e -> e.getElementName().equals(name))
                .findAny()
                .orElseThrow(() -> new NoSuchElementException("There is no element matches the name:" + name));
    }


}
