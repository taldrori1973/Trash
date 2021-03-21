module.exports.generateVirtualServersObject = function (appsArr) {
  let virts = {};
  appsArr.forEach((app) => {
    let virtName = `${app.virtualServerID}_${app.servicePort}`;
    virts[virtName] = [app];
  });

  return virts;
};
