package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.ArrayList;
import java.util.List;

public class TableSortingHandler {

    private int maxNumberComparators = 1;
    private List <SortableColumn> sortableColumns = new ArrayList<>();

    public boolean isSorted() throws Exception {
        String sortingResult = "";
        if (sortableColumns == null)
        {
            throw new Exception("no sortedColumns list");
        }

        if (sortableColumns.size() == 1)
        {
            sortingResult = sortableColumns.get(0).isSorted();
//            return sortingResult;
            return sortingResult.equalsIgnoreCase("") ;
        }

        else
            {
               for (int i=0; i< (sortableColumns.get(0).columnData.size()-1); i++)
               {
                   if(sortableColumns.get(0).towValuesIsSorted(i, i+1) == -1)
                   {
//                       sortingResult = sortingResult + "In column '" + sortableColumns.get(0).columnMetaData.getColumnName() +  "': the value -->(" + sortableColumns.get(0).columnData.get(i) + ") in index -->(" + i + ") isn't sorted with value -->("
//                               + sortableColumns.get(0).columnData.get(i+1) + ") in index -->(" + (i+1) + ")\n";
                       return false;
                   }
                   else if (sortableColumns.get(0).towValuesIsSorted(i, i+1) == 0)
                   {
                       boolean needToAnotherColumn = true;
                       int sortableColumnNumber = 1;
                       while (needToAnotherColumn && sortableColumnNumber<sortableColumns.size())
                       {
                           switch (sortableColumns.get(sortableColumnNumber).towValuesIsSorted(i, i+1))
                           {
                               case -1:
                               {
//                                   sortingResult = sortingResult + "In column '" + sortableColumns.get(sortableColumnNumber).columnMetaData.getColumnName() +  "': the value -->(" + sortableColumns.get(sortableColumnNumber).columnData.get(i) + ") in index -->(" + i + ") isn't sorted with value -->("
//                                           + sortableColumns.get(sortableColumnNumber).columnData.get(i+1) + ") in index -->(" + (i+1) + ")\n";
//                                   needToAnotherColumn = false;
//                                   break;
                                   return false;
                               }
                               case 0:
                               {
                                   sortableColumnNumber++;
                                   break;
                               }
                               case 1:
                               {
                                   needToAnotherColumn = false;
                                   break;
                               }
                           }

                       }
                   }
               }
            }

//        return sortingResult;
        return true;
    }

    public void addToSortableColumns(SortableColumn sortableColumn){}

    public TableSortingHandler(){}

    public TableSortingHandler(List<SortableColumn> sortableColumns)
    {
        this.sortableColumns.clear();
        this.sortableColumns.addAll(sortableColumns);
    }

    public String doSort() throws Exception {
        StringBuilder expectedSorted = new StringBuilder();
        List<Integer> indexesList = new ArrayList<>();
        int columnSize = sortableColumns.get(0).columnData.size();
        for (int i=0; i<columnSize; i++)indexesList.add(i, i);
//        List <String> basicColumn = sortableColumns.get(0).columnData;
        for (int lastPlace=columnSize-1; lastPlace>0 ; lastPlace--)
        {
            for (int i=0; i<lastPlace; i++)
            {
                if (needToSwitchBetweenTwoIndexes(indexesList.get(i), indexesList.get(i+1)))
                {
                    Integer temp = indexesList.get(i);
                    indexesList.set(i, indexesList.get(i+1));
                    indexesList.set(i+1, temp);
                }
            }
        }
        for (int i=0; i<columnSize; i++) expectedSorted.append(sortableColumns.get(0).columnData.get(indexesList.get(i))).append("-->");
        List <List<String>> actualColumnsList = new ArrayList<>();
        for(int i=0; i< maxNumberComparators; i++)
        {
            List<String> columnList  = new ArrayList<>();
            columnList.add(0, sortableColumns.get(i).columnMetaData.getColumnName()+ "(Actual)");
            for (int j=1; j<=sortableColumns.get(i).columnData.size(); j++)
            {
                columnList.add(j, sortableColumns.get(i).columnData.get(j-1));
            }
            actualColumnsList.add(i,columnList);
        }

        List<List<String>> expectedColumnsList = new ArrayList<>();
        for (int i=0; i<maxNumberComparators; i++)
        {
              List<String> columnList  = new ArrayList<>();
              columnList.add(0, sortableColumns.get(i).columnMetaData.getColumnName() + "(Expected)");
               for (int j=1; j<=sortableColumns.get(i).columnData.size(); j++)
              {
//                  int index = findKeyByValue(indexesList, j-1);
                    columnList.add(j, sortableColumns.get(i).columnData.get(indexesList.get(j-1)));
              }
              expectedColumnsList.add(i, columnList);

        }     
        String actualTable = printTable("The Actual table is:\n", actualColumnsList);
        String expectedTable = printTable("But the Expected table is:\n", expectedColumnsList);
        String result = String.format( "%20s %50s","The Expected table is",  "The Actual table is\n");
        for (int i=1; i<expectedTable.split("\n").length; i++)
        {
            result += String.format( expectedTable.split("\n")[i]+ "%10s" ,  actualTable.split("\n")[i]  +"\n");
        }
//        return actualTable + "\n" + expectedTable;
        return result;
    }

    private int findKeyByValue(List<Integer> indexesList, int i) {
        for (int k=0; k<indexesList.size(); k++)
        {
            if (indexesList.get(k) == i)
                return k;
        }
        return -1;
    }

    private String printTable(String title, List<List<String>> columnsList) {
        StringBuilder result = new StringBuilder(title);
        for (int rowIndex=0; rowIndex<columnsList.get(0).size(); rowIndex++)
        {
            for (List<String> columnList : columnsList)
            {
                result.append(String.format("%20s|", columnList.get(rowIndex)));
            }
            result.append("\n");
        }
        return result.toString();
    }

    private boolean needToSwitchBetweenTwoIndexes(Integer firstIndex, Integer secondIndex) throws Exception {
        switch (sortableColumns.get(0).towValuesIsSorted(firstIndex, secondIndex))
        {
            case 1 : return false;
            case -1 : return true;
            case 0 :
            {
                int sortableColumnNumber = 1;
                while (sortableColumnNumber<sortableColumns.size())
                {
                    maxNumberComparators = Math.max(maxNumberComparators,sortableColumnNumber+1);
                    switch (sortableColumns.get(sortableColumnNumber).towValuesIsSorted(firstIndex, secondIndex))
                    {
                        case 1:
                        {
                            return false;
                        }
                        case 0:
                        {
                            sortableColumnNumber++;
                            break;
                        }
                        case -1:
                        {
                           return true;
                        }
                    }
                }
            }
        }
        return true;
    }

}
