package com.radware.vision.infra.testhandlers.DPM;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.table.AbstractRow;
import com.radware.automation.webui.widgets.impl.table.BasicTable;
import com.radware.vision.infra.testhandlers.baseoperations.TableHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.*;

public class VirtsTableHandler extends TableHandler {

    ComponentLocator tableLocator;
    Map<String, Integer> columnNameToIndexMap = new HashMap<>();
    BasicTable table;


    public void validateVirtsTableSorting(String tableName, String sortBy) {

        List<VirtsTableRow> tableData = new ArrayList<>();
        VirtsTableRow tmpRow;


         table = constructTable(tableName);
         setColumnIndex();
         for(int i=0; i < table.tableRows.size(); i++)
         {
             tmpRow = new VirtsTableRow(
                     table.getCellValue(i, "Status"),
                     table.getCellValue(i, "Application Name"),
                     table.getCellValue(i, "Throughput(bps)"),
                     table.getCellValue(i, "Connectionsper Second"),
                     table.getCellValue(i, "ConcurrentConnections")
             );
             tableData.add(tmpRow);
         }
         sortTable(tableData, sortBy);

         validateTableSorting(table.tableRows.subList(1, table.tableRows.size()), tableData);
//
//
//
//
//
//
//
//        List<WebElement> rows = getRows();
//
//
//
//
//        for (WebElement row : rows) {
//
//            tmpRow = new VirtsTableRow(
//
//                    getCellValue(row, columnNameToIndexMap.get("Virtual Service Name")),
//                    getStatusValue(row),
//                    getCellValue(row, columnNameToIndexMap.get("Current Throughput")),
//                    table.tablesRows.get);
//
//            tableData.add(tmpRow);
//        }
//
//        sortTable(tableData, sortBy);
//
//        validateTableSorting(rows, tableData);

    }

    private BasicTable constructTable(String tableName) {
        VisionDebugIdsManager.setLabel(tableName);
        tableLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        BasicTable table = new BasicTable(tableLocator, true);
        if(table.getRowCount() == 0)
            table = new BasicTable(tableLocator, true);// until fixing the automationFlag Bug (refreshing page)
        return table;
    }

    private void validateTableSorting(List<AbstractRow> rows, List<VirtsTableRow> tableData) {
        int index = 0;
        int columnIndex = columnNameToIndexMap.get("Application name");
        String actualName;
        for (AbstractRow row : rows) {
            actualName = row.cells.get(columnIndex-1).textValue();
            if (!actualName.equals(tableData.get(index).getApplicationName())) {

                ReportsUtils.addErrorMessage("The expected Application name at row " + index + " is " + tableData.get(index).getApplicationName() +
                        "\nThe actual Application name is " + actualName);
            }
            index++;
        }
        ReportsUtils.reportErrors();
    }

    private void sortTable(List<VirtsTableRow> tableData, String sortBy) {
        switch (sortBy.toLowerCase()) {
            case "status":
                //sort by Status
//                Collections.sort(tableData);
                tableData.sort(new StatusComparator());
                break;

            case "application name":
                //sort by Application Name
                tableData.sort(new ApplicationNameComparator());
                break;

            case "currentthroughput (bps)":
                //sort by Throughput
                tableData.sort(new ThroughputComparator());
                break;

            case "currentconnections (per sec)":
                //sort by CurrentConnection
                tableData.sort(new CurrentConnectionsComparator());
                break;

            case "concurrent connections":
                //sort by Concurrent Connections
                tableData.sort(new ConcurrentConnectionsComparator());
                break;

            default:
                //sort by Status
                Collections.sort(tableData);
        }
    }


    private String getStatusValue(WebElement row) {
        String rowClass = row.getAttribute("class").toString();


        if (rowClass.contains("up")) return "up";
        if (rowClass.contains("warning")) return "warning";
        if (rowClass.contains("shutdown")) return "shutdown";
        if (rowClass.contains("admin-down")) return "admin-down";
        if (rowClass.contains("down")) return "down";

        return null;
    }

    private String getCellValue(WebElement row, int columnIndex) {
        return WebUIUtils.fluentWait(By.xpath("/td[" + columnIndex + "]"), WebUIUtils.SHORT_WAIT_TIME, true, row).getText();
    }

    private void setColumnIndex() {
        int index = 1;
        for(String header : table.headersFieldNames){
            switch (header)
            {
                case "Status" : columnNameToIndexMap.put("Status", index);break;
                case "Application name" : columnNameToIndexMap.put("Application name", index);break;
                case "CurrentThroughput (bps)" : columnNameToIndexMap.put("CurrentThroughput (bps)", index);break;
                case "CurrentConnections (per sec)" : columnNameToIndexMap.put("CurrentConnection (per sec)", index);break;
                case "Concurrent Connections" : columnNameToIndexMap.put("Concurrent Connections", index);break;
            }
            index++;
        }
    }

    private List<WebElement> getRows() {
        List<WebElement> rows = WebUIUtils.fluentWaitMultipleDisplayed(By.xpath("/tbody/tr"), WebUIUtils.SHORT_WAIT_TIME, true, WebUIUtils.fluentWait(this.tableLocator.getBy()));
        return rows.size() == 1 && ((WebElement) rows.get(0)).getAttribute("class").equals("noData") ? Collections.emptyList() : rows;
    }


    public static int compareApplicationNames(String virtName1, String virtName2) {
        String[] virt1 = virtName1.split(":");
        String[] virt2 = virtName2.split(":");

        int res = virt1[0].compareTo(virt2[0]);
        if (res == 0) {
            return virt1[1].compareTo(virt2[1]);
        }
        return res;
    }
}

enum Status {
    DOWN(1000), WARNING(2000), SHUTDOWN(3000), UP(4000), ADMIN_DOWN(5000);

    private final int score;

    Status(int score) {
        this.score = score;
    }

    public int getScore() {
        return score;
    }


    public static Status getStatus(String status) {
        switch (status.toLowerCase()) {
            case "down":
                return Status.DOWN;

            case "warning":
                return Status.WARNING;

            case "shutdown":
                return Status.SHUTDOWN;

            case "up":
                return Status.UP;

            case "admin down":
                return Status.ADMIN_DOWN;

        }

        return null;
    }

    public static int getScore(String status) {
        switch (status.toLowerCase()) {
            case "down":
                return Status.DOWN.getScore();

            case "warning":
                return Status.WARNING.getScore();

            case "shutdown":
                return Status.SHUTDOWN.getScore();

            case "up":
                return Status.UP.getScore();

            case "admin down":
                return Status.ADMIN_DOWN.getScore();

        }

        return -1;
    }


}

class VirtsTableRow implements Comparable<VirtsTableRow> {

    private Status status;
    private String applicationName;
    private long throughput;
    private long currentConnections;
    private long concurrentConnections;



    public VirtsTableRow(String status, String applicationName, String throughput, String currentConnection, String concurrentConnection) {
        setStatus(status);
        this.applicationName = applicationName;
        setThroughput(throughput);
        this.currentConnections = Long.valueOf(currentConnection.replaceAll(",", "").trim());
        this.concurrentConnections = Long.valueOf(concurrentConnection.replaceAll(",", "").trim());
    }

    public String getApplicationName() {
        return this.applicationName;
    }

    public Status getStatus() {
        return this.status;
    }

    public long getThroughput() {
        return this.throughput;
    }

    public long getCurrentConnections() {
        return currentConnections;
    }

    public long getConcurrentConnections() {
        return concurrentConnections;
    }

    private void setThroughput(String throughput) {

        if(throughput.contains(" "))
        {
            String[] tokens = throughput.split(" ");
            String unit = tokens[1];
            double value = Double.valueOf(tokens[0]);
            switch (unit) {
                case "K":
                    this.throughput = (long) (value * Math.pow(10, 3));
                    break;
                case "M":
                    this.throughput = (long) (value * Math.pow(10, 6));
                    break;
                case "G":
                    this.throughput = (long) (value * Math.pow(10, 9));
                    break;
                case "T":
                    this.throughput = (long) (value * Math.pow(10, 12));
                    break;
                case "P":
                    this.throughput = (long) (value * Math.pow(10, 15));
                    break;
                case "E":
                    this.throughput = (long) (value * Math.pow(10, 18));
                    break;
                case "Z":
                    this.throughput = (long) (value * Math.pow(10, 21));
                    break;
                case "Y":
                    this.throughput = (long) (value * Math.pow(10, 24));
                    break;
                }
            }
            else
                {
                    double value = Double.valueOf(throughput);
                    this.throughput = (long) (value);
                }
        }


    private void setStatus(String status) {

        this.status = Status.getStatus(status);
    }

    @Override
    public int compareTo(VirtsTableRow row) {
        int res = this.status.getScore() - row.status.getScore();

        if (res != 0) return res;

        return VirtsTableHandler.compareApplicationNames(this.applicationName, row.applicationName);
    }

}

class ApplicationNameComparator implements Comparator<VirtsTableRow> {

    @Override
    public int compare(VirtsTableRow row1, VirtsTableRow row2) {

        return VirtsTableHandler.compareApplicationNames(row1.getApplicationName(), row2.getApplicationName());
    }
}

class StatusComparator implements Comparator<VirtsTableRow> {

    @Override
    public int compare(VirtsTableRow row1, VirtsTableRow row2) {

        int res = row2.getStatus().name().compareTo(row1.getStatus().name());
        if (res < 0) return 1;
        if (res > 0) return -1;

        return VirtsTableHandler.compareApplicationNames(row1.getApplicationName(), row2.getApplicationName());
    }

}


class ThroughputComparator implements Comparator<VirtsTableRow> {

    @Override
    public int compare(VirtsTableRow row1, VirtsTableRow row2) {
        long res = row2.getThroughput() - row1.getThroughput();
        if (res < 0) return -1;
        if (res > 0) return 1;

        return VirtsTableHandler.compareApplicationNames(row1.getApplicationName(), row2.getApplicationName());
    }
}

class CurrentConnectionsComparator implements Comparator<VirtsTableRow> {

    @Override
    public int compare(VirtsTableRow row1, VirtsTableRow row2) {
        long res = row2.getCurrentConnections() - row1.getCurrentConnections();
        if (res < 0) return -1;
        if (res > 0) return 1;

        return VirtsTableHandler.compareApplicationNames(row1.getApplicationName(), row2.getApplicationName());
    }
}

class ConcurrentConnectionsComparator implements Comparator<VirtsTableRow> {

    @Override
    public int compare(VirtsTableRow row1, VirtsTableRow row2) {
        long res = row2.getCurrentConnections() - row1.getCurrentConnections();
        if (res < 0) return -1;
        if (res > 0) return 1;

        return VirtsTableHandler.compareApplicationNames(row1.getApplicationName(), row2.getApplicationName());
    }
}





