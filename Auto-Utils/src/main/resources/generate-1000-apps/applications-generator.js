const fs = require("fs");

const hex = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
];

const apps = [];

const template = {
  entityType: "Virtual Service",
  deviceID: "$myDevId",
  timestamp: "${ms_clock}",
  virtualServerID: "",
  virtualServerIP: "",
  applicationId: "",
  servicePort: "80",
  type: "http",
  action: "discard",
  group: "",
  status: "DOWN",
  healthScore: "1000",
  haState: "Active",
  apmState: "Disabled",
  throughput: "0",
  totalBandwidth: "0",
  cps: "0",
  concurrentConnections: "0",
  clientRttUsecs: "",
  serverRttUsecs: "",
  httpVersionPS: [
    {
      "HTTP 2": "0",
    },
    {
      "HTTP 1.1": "0",
    },
    {
      "HTTP 1.0": "0",
    },
  ],
  uid: "",
  apdexScore: "NA",
  srvcAvailScore: "0",
  applicHealthScore: "0",
};

function generate(numberOfApps) {
  for (let index = 1; index <= numberOfApps; index++) {
    let app = { ...template };
    app.virtualServerID = `service_application_${index}_$myiphex`;
    app.virtualServerIP = `${getIp(index)}`;
    app.uid = `${generateUUID(38)}$myiphex`;
    app.applicationId = `${app.virtualServerID}:${app.servicePort}`;

    apps.push(app);
  }
}

function getIp(index) {
  let thirdOctet = Math.floor(index / 255) + 1;
  let fourthOctet = index % 255;
  return `100.100.10${thirdOctet}.${fourthOctet}`;
}
function generateUUID(size) {
  let uuid = "";
  for (let index = 0; index < size; index++) {
    uuid += hex[Math.floor(Math.random() * 16)];
  }

  return uuid;
}

function generateVirtualServersObject(numOfApps) {
  generate(numOfApps);
  let virts = {};
  apps.forEach((app) => {
    let virtName = `${app.virtualServerID}_${app.servicePort}`;
    virts[virtName] = [app];
  });

  return virts;
}

// generate(1000);
// console.log(JSON.stringify(apps));
fs.writeFile(
  "apps.json",
  JSON.stringify(generateVirtualServersObject(1000)),
  (err) => {
    if (err) throw err;
  }
);
