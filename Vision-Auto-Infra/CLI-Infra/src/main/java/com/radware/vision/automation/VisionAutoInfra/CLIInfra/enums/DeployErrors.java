package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;


import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public enum DeployErrors {
    FILE_NOT_FOUND("Error 15: File not found\n"),
    FILE_SIZE(" Warning \n" +
            "\n" +
            " The ISO image APSoluteVision-4.80.00-90-x86_64.iso has a size \n" +
            " which is not a multiple of 2048 bytes.  This may mean it was  \n" +
            " corrupted on transfer to this computer.\n" +
            "\n" +
            " It is recommended that you exit and abort your installation,  \n" +
            " but you can choose to continue if you think this is in error."),
    MYSQL("Can't connect to local MySQL server"),
    PACKAGE(" Warning \n" +
            " Some of the packages you have selected for install are missing  \n" +
            " dependencies or conflict with another package. You can exit the \n" +
            " installation, go back and change your package selections, or    \n" +
            " continue installing these packages without their dependencies."),
    FILE_TOO_LARGE("File too large"),
    HTTP_NOT_FOUND("404 Not Found"),
    UNTAR_ERROR("Error is not recoverable: exiting now");
    private String error;

    DeployErrors(String error) {
        this.error = error;
    }

    static List<String> list = Stream.of(DeployErrors.values())
            .map(DeployErrors::getError)
            .collect(Collectors.toList());

    public static List<String> getListOfErrors() {
        return list;
    }

    private static final List<String> VALUES;

    static {
        VALUES = new ArrayList<>();
        for (DeployErrors deployErrors : DeployErrors.values()) VALUES.add(deployErrors.error);
    }


    public String getError() {
        return this.error;
    }

    public static List<String> getArrayOfErrors() {
        return Collections.unmodifiableList(VALUES);
    }
}
