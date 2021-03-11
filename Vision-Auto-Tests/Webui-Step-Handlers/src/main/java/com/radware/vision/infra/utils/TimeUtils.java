package com.radware.vision.infra.utils;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

/**
 * Created by urig on 11/3/2014.
 */
public class TimeUtils {

    public static long getEpochTime(String dateTime, String timeFormat) {
        SimpleDateFormat df = new SimpleDateFormat(timeFormat);
        long l = 0;
        try {
            Date date = df.parse(dateTime);
            l = date.getTime();
        } catch (Exception e) {
            throw new IllegalArgumentException(e.getMessage() + "\n" + e.getStackTrace());
        }
        return l;
    }

    public static long getCurrentDate() {
        return System.currentTimeMillis();
    }

    public static String getHumanReadableDate(long epochTime) {
        long date = System.currentTimeMillis();
        try {
            String normalDate = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss").format(new Date(epochTime));
            return normalDate;
        } catch (Exception e) {
            return "";
        }
    }

    public static LocalTime addMissingDigits(String time) {
        String[] splittedTime = time.split(":");
        for (int i = 0; i < splittedTime.length; i++) {
            String s = splittedTime[i];

            if (s.length() == 1) {
                splittedTime[i] = "0" + s;
            }
        }
        return LocalTime.parse(splittedTime[0] + ":" + splittedTime[1] + ":" + splittedTime[2]);

    }

    /**
     * @param localTime a time param
     * @param delimiter the delimiter between each 2 digits of the time default is ":"
     * @return return the time with digits each and with delimiter between
     */

    public static String get2DigitsTimeWithDelimiter(LocalTime localTime, String delimiter) {
        if (delimiter == null || delimiter.isEmpty()) {
            delimiter = ":";
        }
        return String.format("%02d" + delimiter + "%02d" + delimiter + "%02d", localTime.getHour(), localTime.getMinute(), localTime.getSecond());

    }
    public static LocalDateTime getAddedDate(String timeAbsolute)
    {
        Map<String, Integer> shortcutsMap = convertShortcut();
        Calendar c = new GregorianCalendar();
        String amountType = timeAbsolute.split("(\\+\\d+)|(\\-\\d+)")[1].trim();
        String amount = timeAbsolute.split(amountType)[0].trim();
        c.add(shortcutsMap.get(amountType), Integer.parseInt(amount));
        LocalDateTime localDateTime = LocalDateTime.from(Instant.ofEpochMilli(c.getTime().getTime()).atZone(ZoneId.systemDefault()));
        return localDateTime;
    }

    private static Map<String, Integer> convertShortcut() {
        Map<String, Integer> shortcuts = new HashMap<>();
        shortcuts.put("M", Calendar.MONTH);
        shortcuts.put("d", Calendar.DAY_OF_MONTH);
        shortcuts.put("y", Calendar.YEAR);
        shortcuts.put("H", Calendar.HOUR);
        shortcuts.put("m", Calendar.MINUTE);
        return shortcuts;
    }

    public static ChronoUnit getChronoUnit(String units) {
        switch (units) {
            case "d":
                return ChronoUnit.DAYS;
            case "M":
                return ChronoUnit.MONTHS;
            case "Y":
                return ChronoUnit.YEARS;
        }

        return null;
    }

    public static String getTimeAsText(LocalDateTime time, String pattern)
    {
        return DateTimeFormatter.ofPattern(pattern).format(time);
    }

    public static boolean isWithComputing(String timeValue){return timeValue.matches(("[\\+|\\-]\\d+[M|d|y|H|m]"));}

}
