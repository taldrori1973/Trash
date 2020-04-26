package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import com.aqua.sysobj.conn.LinuxDefaultCliConnection;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by urig on 6/14/2017.
 * Copied From Auto-Tools Utils By MohamadI (Muhamad Igbaria) 26/04/2020
 */
public class ServerCliBase extends LinuxDefaultCliConnection {


    public ServerCliBase() {
        super();
    }

    public ServerCliBase(String host, String user, String password) {
        super(host, user, password);
    }

    /**
     * This function returns the output of the cmd without the first line ( the cmd you send )
     * and without the last line ( the new prompt )
     * handels CliConnection.getTestAgainstObject().toString()F
     *
     * @author izikp
     */
    public ArrayList<String> getCmdOutput() {

        ArrayList<String> resultLines = new ArrayList<String>();
        if (getTestAgainstObject() != null) {
            String[] lines = getTestAgainstObject().toString().split("[\\r\\n]+");
            for (int i = 1; i < lines.length - 1; i++) {
                resultLines.add(lines[i]);
            }
        }
        return resultLines;
    }


    /**
     * @return the last row of the result
     */
    public String getLastRow() {

        List<String> results = getCmdOutput();
        if (results.size() > 0)
            return results.get(results.size() - 1);
        return null;
    }
}
