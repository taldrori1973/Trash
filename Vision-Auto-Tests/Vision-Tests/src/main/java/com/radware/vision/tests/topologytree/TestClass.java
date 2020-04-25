package com.radware.vision.tests.topologytree;


import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by stanislava on 3/17/2016.
 */
public class TestClass {
    public static void main(String[] args) {
        Name nameArray[] = {
                new Name("John", "Smith"),
                new Name("Karl", "Ng"),
                new Name("Jeff", "Smith"),
                new Name("Tom", "Rich")
        };

        List<Name> names = Arrays.asList(nameArray);
        Collections.sort(names);
        System.out.println(names);
    }

}
