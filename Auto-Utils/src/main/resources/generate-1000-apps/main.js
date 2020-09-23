const fs = require("fs");
const reporter_virtualServers_generator = require("./reporter_virtualServer_generator");
const application_generator = require("./applications-generator");
const generateSlbCurCfgEnhVirtServerTable = require("./SlbCurCfgEnhVirtServerTable");

// Generate All Apps and save it to an array
application_generator.generateApps(1000);

// get the saved apps array
let appsArr = application_generator.getApps();

// generate json object for /reporter/virtualServer request under data.virtualServers
let reporter_virtualServers = reporter_virtualServers_generator.generateVirtualServersObject(
  appsArr
);
// for %http_get_action /config/SlbCurCfgEnhVirtServerTable?count=1024&props=VirtServerIndex,VirtServerIpAddress

let generateSlbCurCfgEnhVirtServerTable_1 = generateSlbCurCfgEnhVirtServerTable.generateSlbCurCfgEnhVirtServerTable_1(
  appsArr
);

// for %http_get_action /config/SlbCurCfgEnhVirtServicesTable?count=1024&props=ServIndex,VirtPort,Index

let generateSlbCurCfgEnhVirtServerTable_2 = generateSlbCurCfgEnhVirtServerTable.generateSlbCurCfgEnhVirtServerTable_2(
  appsArr
);

// for %http_get_action /config/SlbNewCfgEnhVirtServicesSeventhPartTable?count=1024&props=ServSeventhPartIndex,SeventhPartIndex,ApplicName,Report

let SlbNewCfgEnhVirtServicesSeventhPartTable = generateSlbCurCfgEnhVirtServerTable.generateSlbNewCfgEnhVirtServicesSeventhPartTable(
  appsArr
);

fs.writeFile(
  "./jsons/reporter_virtualServers.json",
  JSON.stringify(reporter_virtualServers),
  (err) => {
    if (err) throw err;
  }
);

fs.writeFile(
  "./jsons/generateSlbCurCfgEnhVirtServerTable_1.json",
  JSON.stringify(generateSlbCurCfgEnhVirtServerTable_1),
  (err) => {
    if (err) throw err;
  }
);

fs.writeFile(
  "./jsons/generateSlbCurCfgEnhVirtServerTable_2.json",
  JSON.stringify(generateSlbCurCfgEnhVirtServerTable_2),
  (err) => {
    if (err) throw err;
  }
);

fs.writeFile(
  "./jsons/SlbNewCfgEnhVirtServicesSeventhPartTable.json",
  JSON.stringify(SlbNewCfgEnhVirtServicesSeventhPartTable),
  (err) => {
    if (err) throw err;
  }
);
