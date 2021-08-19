package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import org.apache.tools.tar.TarEntry;
import org.apache.tools.tar.TarInputStream;

import java.io.*;
import java.net.URL;

public class UnTar {

    static final int BUFFER = 2048;

    public static void untarTarUrl(String urlStr, String destFolder) throws IOException {

        URL url = new URL(urlStr);

        BaseTestUtils.reporter.startLevel("Downloading OVA File From URL - "+urlStr);
        TarInputStream tis = new TarInputStream(new BufferedInputStream(
                url.openStream()));
        BaseTestUtils.reporter.stopLevel();

        BaseTestUtils.reporter.startLevel("Untar OVA File to OVF format");
        untar(tis, destFolder);
        BaseTestUtils.reporter.stopLevel();

        tis.close();
    }

    public static void untarTarFile(String filePath, String destFolder) throws IOException {
        File zf = new File(filePath);

        TarInputStream tis = new TarInputStream(new BufferedInputStream(
                new FileInputStream(zf)));
        try{
            untar(tis, destFolder);
        }catch(Exception e){
            BaseTestUtils.reporter.report(e.getMessage() + ", Failed to untar file: " + filePath);
        }finally{
            tis.close();
        }
    }

    private static void untar(TarInputStream tis, String destFolder)
            throws IOException {
        BufferedOutputStream dest = null;

        TarEntry entry;
        while ((entry = tis.getNextEntry()) != null) {
            BaseTestUtils.reporter.report("Extracting: " + entry.getName());
            int count;
            byte data[] = new byte[BUFFER];

            if (entry.isDirectory()) {
                new File(destFolder + "/" + entry.getName()).mkdirs();
                continue;
            } else {
                int di = entry.getName().lastIndexOf('/');
                if (di != -1) {
                    new File(destFolder + "/"
                            + entry.getName().substring(0, di)).mkdirs();
                }
            }

            FileOutputStream fos = new FileOutputStream(destFolder + "/"
                    + entry.getName());
            dest = new BufferedOutputStream(fos);

            while ((count = tis.read(data)) != -1) {
                dest.write(data, 0, count);
            }

            dest.flush();
            dest.close();
        }
    }

}
