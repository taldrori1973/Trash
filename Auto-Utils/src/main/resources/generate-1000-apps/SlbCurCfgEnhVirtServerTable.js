module.exports.generateSlbCurCfgEnhVirtServerTable_1 = function (appArray) {
  let SlbCurCfgEnhVirtServerTable = [];
  debugger;
  appArray.forEach((app) => {
    let virtObject = {
      VirtServerIndex: app.virtualServerID,
      VirtServerIpAddress: app.virtualServerIP,
    };
    SlbCurCfgEnhVirtServerTable.push(virtObject);
  });

  return SlbCurCfgEnhVirtServerTable;
};

module.exports.generateSlbCurCfgEnhVirtServerTable_2 = function (appArray) {
  let SlbCurCfgEnhVirtServerTable = [];
  debugger;
  appArray.forEach((app) => {
    let virtObject = {
      ServIndex: app.virtualServerID,
      VirtPort: app.servicePort,
      Index: 1,
    };
    SlbCurCfgEnhVirtServerTable.push(virtObject);
  });

  return SlbCurCfgEnhVirtServerTable;
};

module.exports.generateSlbNewCfgEnhVirtServicesSeventhPartTable = function (
  appArray
) {
  let SlbNewCfgEnhVirtServicesSeventhPartTable = [];

  appArray.forEach((app) => {
    let virtObject = {
      ServSeventhPartIndex: app.virtualServerID,
      SeventhPartIndex: 1,
      ApplicName: `${app.virtualServerID}:${app.servicePort}`,
      Report: 1,
    };
    SlbNewCfgEnhVirtServicesSeventhPartTable.push(virtObject);
  });

  return SlbNewCfgEnhVirtServicesSeventhPartTable;
};
