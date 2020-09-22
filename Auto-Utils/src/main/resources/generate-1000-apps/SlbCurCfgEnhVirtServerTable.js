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
