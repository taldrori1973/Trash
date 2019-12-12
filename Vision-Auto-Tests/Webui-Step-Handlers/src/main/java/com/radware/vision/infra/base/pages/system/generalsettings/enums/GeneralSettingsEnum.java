package com.radware.vision.infra.base.pages.system.generalsettings.enums;

/**
 * Created by vadyms on 5/20/2015.
 */
public class GeneralSettingsEnum {
    public enum Language {
        ENGLISH("English"), KOREAN("Korean"), JAPANESE("Japanese"), CHINESE("Chinese");

        String value;

        Language(String str) {
            value = str;
        }

        public String toString() {
            return value;
        }

        /**
         * This method return the matching Enum
         * value following to the input String value
         **/
        public static Language getLanguage(String str) {

            if (!(str == null || str.isEmpty())) {

                str = str.trim();
                for (Language e : Language.values()) {
                    if (str.equalsIgnoreCase(e.toString()))
                        return e;
                }
            }

            return ENGLISH;
        }
    }


    public enum TimeFormat {

        DEFAULT("HH:mm:ss"),
        OFFSET("HH:mm:ss z"),
        AM_PM("h:mm:ss aa"),
        AM_PM_OFFSET("h:mm:ss aa z");

        private String format;

        TimeFormat(String format) {
            this.format = format;
        }

        public String getFormat() {
            return format;
        }

        public String getPatternOfTimeFormat() {
            String regex = null;

            switch (this) {

                case DEFAULT:
                    regex = "\\d{1,2}:\\d{1,2}:\\d{1,2}";
                    break;

                case OFFSET:
                    regex = "\\d{1,2}:\\d{1,2}:\\d{1,2}\\sUTC[+]\\d{1}";
                    break;
                case AM_PM:
                    regex = "\\d{1,2}:\\d{1,2}:\\d{1,2}\\s[AP][M]";
                    break;

                case AM_PM_OFFSET:
                    regex = "\\d{1,2}:\\d{1,2}:\\d{1,2}\\sUTC[+]\\d{1}\\s[AP][M]";
                    break;


            }
            return regex;
        }
    }

}
