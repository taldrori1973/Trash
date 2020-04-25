package com.radware.vision.tests.GeneralOperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.devicecontrolbar.ImportOperation;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.PaginationArrows;
import com.radware.vision.infra.enums.VisionTableIDs;
import com.radware.vision.infra.tablepagesnavigation.NavigateTable;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.CommonTableActions;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
/**
 * Created by stanislava on 9/9/2015.
 */
public class GeneralOperationsTests extends WebUITestBase {

    String columnName;
    String columnValue;
    VisionTableIDs visionTableID = VisionTableIDs.SELECT_TABLE_TO_WORK_WITH;
    String deviceFieldLabel;
    PaginationArrows paginationArrowDestination = PaginationArrows.SELECT_ARROW_TO_USE_PAGINATION;
    int pageNumber;

    String fileName;
    String fileDownloadPath = System.getProperty("user.home").concat("\\Downloads\\");
    int rowIndex;

    CommonTableActions tableAction = CommonTableActions.NEW;
    BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();

    boolean ifClickImport = true;
    FindByType findTableType = FindByType.BY_NAME;

    public GeneralOperationsTests() {
        setCloseAllOpenedDialogsRequired(true);
    }


    @Test
    @TestProperties(name = "execute Vision Table Operation", paramsInclude = {"visionTableID", "tableAction"})
    public void executeVisionTableOperation() {
        try {
            if (!visionTableID.getVisionTableID().equals("") && visionTableID != null) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
                ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-".concat(visionTableID.getVisionTableID()).concat(tableAction.getTableAction()));
                WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

            } else {
                BaseTestUtils.report("Incorrect ID is provided : " + "gwt-debug-".concat(visionTableID.getVisionTableID()).concat(tableAction.getTableAction()), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + "gwt-debug-".concat(visionTableID.getVisionTableID()).concat(tableAction.getTableAction()), Reporter.FAIL);
        }
        finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    @Test
    @TestProperties(name = "Select Table Row", paramsInclude = {"visionTableID", "columnName", "columnValue"})
    public void selectTableRow() {
        try {
            if (!visionTableID.getVisionTableID().equals("") && visionTableID != null) {
                ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-".concat(visionTableID.getVisionTableID()));
                WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                WebUITable table = new WebUITable();
                table.setWebElement(element);
                table.setRawId(visionTableID.getVisionTableID());
                table.clickRowByKeyValue(columnName, columnValue);
            } else {
                BaseTestUtils.report("Incorrect table ID is provided : " + visionTableID.getVisionTableID(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + visionTableID.getVisionTableID(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Select Device Table Row", paramsInclude = {"deviceFieldLabel", "columnName", "columnValue", "deviceName", "findTableType"})
    public void selectDeviceTableRow() {
        try{
            basicOperationsByNameIdHandler.selectTableRecord(WebUIUtils.selectedDeviceDriverId, deviceFieldLabel, columnName, columnValue, findTableType);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + getDeviceFieldLabel(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Click Device Table Row By Index", paramsInclude = {"deviceFieldLabel", "rowNumberToSelect", "rowIndex", "deviceName"})
    public void selectDeviceTableRowByIndex() {
        try{
            basicOperationsByNameIdHandler.selectTableRecordByIndex(WebUIUtils.selectedDeviceDriverId, deviceFieldLabel, rowIndex);
            } catch (Exception e) {
            BaseTestUtils.report("Failed to find Table's row by text: " + rowIndex, Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set Table Page", paramsInclude = {"paginationArrowDestination", "pageNumber"})
    public void setTablePage() {
        try {
            if (!paginationArrowDestination.getPage().equals("")) {
                switch (paginationArrowDestination) {
                    case NEXT_PAGE:
                        NavigateTable.nextPage();
                        break;
                    case PREV_PAGE:
                        NavigateTable.prevPage();
                        break;
                    case FIRST_PAGE:
                        NavigateTable.firstPage();
                        break;
                    case LAST_PAGE:
                        NavigateTable.lastPage();
                        break;
                }

            } else if (getPageNumber() != null && !getPageNumber().equals("")) {
                NavigateTable.specificPage(getPageNumber());
            } else {
                BaseTestUtils.report("Incorrect table ID is provided : " + visionTableID.getVisionTableID(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + visionTableID.getVisionTableID(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Browse Import File", paramsInclude = {"fileName", "fileDownloadPath", "ifClickImport"})
    public void browseImportFile() {
        try {
            ImportOperation importOperation = new ImportOperation();
            if(fileDownloadPath == null || fileDownloadPath.equals("")){
                fileDownloadPath = System.getProperty("user.home").concat("\\Downloads\\");
            }
            String filePath = normalizePath(fileDownloadPath, fileName);
            importOperation.importFromClient(filePath, ifClickImport);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + visionTableID.getVisionTableID(), Reporter.FAIL);
        }
    }

    public String normalizePath(String path, String fileName){

        if(fileDownloadPath == null || fileDownloadPath.equals("")){
            fileDownloadPath = System.getProperty("user.home").concat("\\Downloads\\");
        }

        boolean isLinux = System.getProperty("os.name").toLowerCase().contains("linux") || System.getProperty("os.name").toLowerCase().contains("unix");
        String fileLocation = path.concat(fileName);
        if(isLinux) {
            fileLocation = FileUtils.JENKINS_LOCAL_DOWNLOAD_DIRECTORY.concat(fileName);
        }
        return fileLocation;
    }

    public CommonTableActions getTableAction() {
        return tableAction;
    }

    public void setTableAction(CommonTableActions tableAction) {
        this.tableAction = tableAction;
    }

    public PaginationArrows getPaginationArrowDestination() {
        return paginationArrowDestination;
    }

    public void setPaginationArrowDestination(PaginationArrows paginationArrowDestination) {
        this.paginationArrowDestination = paginationArrowDestination;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileDownloadPath() {
        return fileDownloadPath;
    }

    public void setFileDownloadPath(String fileDownloadPath) {
        this.fileDownloadPath = fileDownloadPath;
    }

    public String getPageNumber() {
        return String.valueOf(pageNumber);
    }

    @ParameterProperties(description = "Please, set the Page number in case You have a specific one!")
    public void setPageNumber(String pageNumber) {
        if (pageNumber != null) {
            this.pageNumber = Integer.valueOf(StringUtils.fixNumeric(pageNumber));
        }
    }

    public VisionTableIDs getVisionTableID() {
        return visionTableID;
    }

    @ParameterProperties(description = "Please, select the Table you would like to work with!")
    public void setVisionTableID(VisionTableIDs visionTableID) {
        this.visionTableID = visionTableID;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnValue() {
        return columnValue;
    }

    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }

    public String getDeviceFieldLabel() {
        return deviceFieldLabel;
    }

    @ParameterProperties(description = "Please, provide the Table name label")
    public void setDeviceFieldLabel(String deviceFieldLabel) {
        this.deviceFieldLabel = deviceFieldLabel;
    }

    public String getRowIndex() {
        return String.valueOf(rowIndex);
    }

    @ParameterProperties(description = "Please, provide row index to be selected! To select the Last row 0 should be provided")
    public void setRowIndex(String rowIndex) {
        if(rowIndex != null) {
            this.rowIndex = Integer.valueOf(StringUtils.fixNumeric(rowIndex));
        }
    }

    public boolean isIfClickImport() { return ifClickImport; }
    @ParameterProperties(description = "Please, change to False if no import button is attached to the Browse element")
    public void setIfClickImport(boolean ifClickImport) {
        this.ifClickImport = ifClickImport;
    }

    public FindByType getFindTableType() {
        return findTableType;
    }
    @ParameterProperties(description = "Please, provide the find Method you would like to use.")
    public void setFindTableType(FindByType findTableType) {
        this.findTableType = findTableType;
    }
}
