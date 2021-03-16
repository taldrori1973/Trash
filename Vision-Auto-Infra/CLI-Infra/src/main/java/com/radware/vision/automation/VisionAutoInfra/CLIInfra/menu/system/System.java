package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Version;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.Statistics;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.auditLog.AuditLog;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.Backup;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.cleanup.Cleanup;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.ConfigSync;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.database.DataBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.date.Date;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.dpm.Dpm;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.Exporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.hardware.Hardware;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.hostname.HostName;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.java.Java;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.Ntp;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.Snmp;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ssl.Ssl;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.storage.Storage;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.tcp_dump.TcpDump;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.terminal.Terminal;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.timezone.Timezone;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.upgrade.Upgrade;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.user.User;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.vision_server.VisionServer;

/**
 * @author Hadar Elbaz
 */

public class System extends Builder {

    public System(String prefix) {
        super(prefix);
    }

    public ConfigSync configSync(){return new ConfigSync(build());}

    public Snmp snmp() {
        return new Snmp(build());
    }

    public Backup backup() {
        return new Backup(build());
    }

    public AuditLog auditLog() {
        return new AuditLog(build());
    }

    public DataBase database() {
        return new DataBase(build());
    }

    public HostName hostName() {
        return new HostName(build());
    }

    public Date date() { return new Date(build()); }

    public Dpm dpm() {
        return new Dpm(build());
    }

    public Exporter exporter(){return new Exporter(build());}

    public Ntp ntp() {
        return new Ntp(build());
    }

    public Terminal terminal() {
        return new Terminal(build());
    }

    public Upgrade upgrade() {
        return new Upgrade(build());
    }

    public Ssl ssl() {
        return new Ssl(build());
    }

    public Storage storage() {
        return new Storage(build());
    }

    public TcpDump tcpDump() {
        return new TcpDump(build());
    }

    public Timezone timezone() {
        return new Timezone(build());
    }

    public User user() {
        return new User(build());
    }

    public VisionServer visionServer() {
        return new VisionServer(build());
    }

    public Cleanup cleanup() {
        return new Cleanup(build());
    }

    public Statistics statistics() {
        return new Statistics(build());
    }

    public Version version() {
        return new Version(build());
    }

    public Hardware hardware() {
        return new Hardware(build());
    }

    public Java java() { return new Java(build()); }

    @Override
    public String getCommand() {
        return " system";
    }
}
