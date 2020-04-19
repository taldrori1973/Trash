package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.RuntimeVMOptions;

import static java.lang.String.format;
import static java.util.Objects.isNull;

public class SutDao {

    private static final String SUT_VM_OPTION_KEY_PROPERTY = "SUT.vmOptions.key";
    private static final String SUT_FILES_PATH_PROPERTY = "SUT.path";


    private ApplicationPropertiesUtils applicationPropertiesUtils;
    private RuntimeVMOptions runtimeVMOptions;

    private static SutDao _instance = new SutDao();
    private SUTPojo sutPojo;


    public SutDao() {
        this.applicationPropertiesUtils = new ApplicationPropertiesUtils();
        this.runtimeVMOptions = new RuntimeVMOptions();

        String sutFilePath = runtimeVMOptions.getResourcesPath(
                String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_FILES_PATH_PROPERTY), getSUTFileName()));
        this.sutPojo = JsonUtilities.loadJsonFile(sutFilePath, SUTPojo.class);
    }

    public static SutDao get_instance() {
        return _instance;
    }


    private String getSUTFileName() {

        try {
            String sutVmOptionsKey = this.applicationPropertiesUtils.getProperty(SUT_VM_OPTION_KEY_PROPERTY);
            if (isNull(sutVmOptionsKey) || sutVmOptionsKey.isEmpty()) {
                throw new NoSuchFieldException(format("The Property %s not found at %s file", SUT_VM_OPTION_KEY_PROPERTY, ApplicationPropertiesUtils.applicationPropertiesFile));
            }

            String sutFileName = this.runtimeVMOptions.getSUTFileName(sutVmOptionsKey);

            if (isNull(sutFileName) || sutFileName.isEmpty()) {
                throw new IllegalArgumentException(format("The sut file name is null or empty , validate that the vm option contains \"%s={filename}\" ", sutVmOptionsKey));
            }
            return sutFileName;

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return null;

    }


    //    DAO
    public String getSetupId() {
        return this.sutPojo.getSetupFile();
    }
}
