package com.radware.vision.infra.testresthandlers.visionLicense;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testresthandlers.visionLicense.pojos.AttackCapacityLicensePojo;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * By MohamadI
 * For Licenses:
 * 1. vision-AVA-20-Gbps-attack-capacity
 * 2. vision-AVA-400-Gbps-attack-capacity
 * 3. vision-AVA-60-Gbps-attack-capacity
 * 4. vision-AVA-6-Gbps-attack-capacity
 * 5. vision-AVA-Max-attack-capacity
 * Maybe More licenses in the future
 * This Class Handle the AVA Attack Capacity Back End Tests
 * This Test handler send Two REST Requests as follow:
 * 1.GET : /mgmt/system/config/item/licenseinfo
 * The Response Include the following Object :
 * "attackCapacityLicense": {
 * "message": Message to show to the user,
 * "timeToExpiration": 91,
 * "additionalMessage": [],
 * "licenseViolation": false,
 * "neededConfirmation": false,
 * "isInGracePeriod": false,
 * "hasDemoLicense": false
 * }
 * 2.GET : /mgmt/system/config/itemlist/attack/capacity/license
 * The Response Include the following Object :
 * {
 * "lastCalculationDate": 1570442834956,
 * "allowedAttackCapacityGbps": 60,
 * "requiredDevicesAttackCapacityGbps": 18,
 * "licensedDeviceOrmidList": [                //This is the list of licensed devices ORM Ids
 * "2c912402634578df01636e5f17b701f9",
 * "2c9140e46d5e4a92016d5e4accab0001",
 * "2c9124e563b0d06d0163b1ffcae8000b",
 * "2c9124e563b0d06d0163b20261ae001d"
 * ],
 * "hasDemoLicense": false,
 * "attackCapacityMaxLicenseExist": false,
 * "inGracePeriod": false,
 * "licenseViolated": false
 * }
 * <p>
 * This Test Handler Merge the results to one Object :
 *
 * @see com.radware.vision.infra.testresthandlers.visionLicense.pojos.AttackCapacityLicensePojo
 */
public class AttackCapacityLicenseTestHandler extends VisionLicenseTestHandler {

    private AttackCapacityLicensePojo attackCapacityLicensePojo;

    public AttackCapacityLicenseTestHandler() throws IOException, ParseException {
        super();
        this.attackCapacityLicensePojo = new AttackCapacityLicensePojo();
        setLicenseInfo();
    }

    @Override
    public String getValue(String key) {
        switch (key) {
            case "lastCalculationDate":
                return String.valueOf(attackCapacityLicensePojo.getLastCalculationDate());
            case "allowedAttackCapacityGbps":
                return String.valueOf(attackCapacityLicensePojo.getAllowedAttackCapacityGbps());
            case "requiredDevicesAttackCapacityGbps":
                return String.valueOf(attackCapacityLicensePojo.getRequiredDevicesAttackCapacityGbps());
            case "licensedDefenseProDeviceIpsList":
                return getLicensedDeviceIpsList().toString();
            case "hasDemoLicense":
                return String.valueOf(attackCapacityLicensePojo.isHasDemoLicense());
            case "licenseViolated":
                return String.valueOf(attackCapacityLicensePojo.isLicenseViolated());
            case "inGracePeriod":
                return String.valueOf(attackCapacityLicensePojo.isInGracePeriod());
            case "attackCapacityMaxLicenseExist":
                return String.valueOf(attackCapacityLicensePojo.isAttackCapacityMaxLicenseExist());
            case "message":
                return attackCapacityLicensePojo.getMessage();
            case "timeToExpiration":
                return String.valueOf(attackCapacityLicensePojo.getTimeToExpiration());
            case "additionalMessage":
                return attackCapacityLicensePojo.getAdditionalMessage().toString();
            case "licenseViolation":
                return String.valueOf(attackCapacityLicensePojo.isLicenseViolation());
            case "neededConfirmation":
                return String.valueOf(attackCapacityLicensePojo.isNeededConfirmation());
            case "isInGracePeriod":
                return String.valueOf(attackCapacityLicensePojo.getIsInGracePeriod());
            default:
                throw new IllegalStateException("Unexpected value: " + key);
        }

    }

    private List<String> getLicensedDeviceIpsList() {
        return deviceOrmIdListToIpsList(attackCapacityLicensePojo.getLicensedDeviceOrmidList());
    }


    public boolean isDefenseFlowLicensed() {
        if (defenseFlowOrmId == null) return false;
        return attackCapacityLicensePojo.getLicensedDeviceOrmidList().contains(defenseFlowOrmId);
    }

    private void setLicenseInfo() throws IOException, ParseException {

        String attackCapacityLicenseResponse = sendRequest(requests.get("Attack Capacity License"));

        String licenseTypesResponse = sendRequest(requests.get("Vision License Info"));

        ObjectMapper mapper = new ObjectMapper();
        attackCapacityLicensePojo = mapper.readValue(attackCapacityLicenseResponse, AttackCapacityLicensePojo.class);


        JSONParser parser = new JSONParser();
        JSONObject licenseTypesResponseJson = (JSONObject) parser.parse(licenseTypesResponse);
        if(licenseTypesResponseJson.get("attackCapacityLicense")!=null && !licenseTypesResponseJson.get("attackCapacityLicense").equals("null")) {
            licenseTypesResponseJson = (JSONObject) licenseTypesResponseJson.get("attackCapacityLicense");
            licenseTypesResponse = licenseTypesResponseJson.toJSONString();


            ObjectReader updater = mapper.readerForUpdating(attackCapacityLicensePojo);

            attackCapacityLicensePojo = updater.readValue(licenseTypesResponse);
        }

    }


    private static void update_last_server_upgrade_time(LocalDateTime date) {

//        %s=YYYY-MM-DD HH:mm:ss
        String command = "result=$(mysql -prad123 vision_ng -e \"select count(*) from server_upgrade_status\" | grep -v + | grep -v count); mysql -prad123 vision_ng -e \"update server_upgrade_status set start_time_stamp='%s' where row_id=$result\\G\"\n";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        String dateStr = date.format(formatter);

        command = command.replace("%s", dateStr);
        CliOperations.runCommand(restTestBase.getRootServerCli(), command);
    }

    public static void update_last_server_upgrade_time(long daysToSubtract) {
        String currentDate = "";
        CliOperations.runCommand(restTestBase.getRootServerCli(), "date +%F");
        currentDate = currentDate.concat(CliOperations.lastRow);
        CliOperations.runCommand(restTestBase.getRootServerCli(), "date +%T");
        currentDate = currentDate.concat(" ").concat(CliOperations.lastRow);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime localDate = LocalDateTime.parse(currentDate, formatter);
        localDate = localDate.minusDays(daysToSubtract);
        update_last_server_upgrade_time(localDate);
    }

    public static void update_grace_period_state_at_db(GracePeriodState state) {
        String command = "mysql -prad123 vision_ng -e \"update ap set ava_grace_period_state='%d'\\G\"";
        command = String.format(command, state.getValue());
        CliOperations.runCommand(restTestBase.getRootServerCli(), command);
    }


    public enum GracePeriodState {
        NOT_SET(1),
        IN_GRACE(2),
        NO_GRACE(3);

        int value;

        GracePeriodState(int value) {
            this.value = value;
        }

        public int getValue() {
            return this.value;
        }
    }


}
