package com.radware.vision.infra.testhandlers.topologytree.dataTables;

public class DeviceInfoDataTable {


     String site ;
     String deviceType ;
     String deviceName ;
     String deviceIp ;
     String username;
     String password ;
     String readCommunity ;
     String writeCommunity ;
     String treeTabType;
     String register;
     String interfaceName;
     String interfaceSubnet;

     public String getInterfaceName() {
          return interfaceName;
     }

     public String getInterfaceSubnet() {
          return interfaceSubnet;
     }

     public String getTreeTabType() {
          return treeTabType;
     }
     public String getRegister() {
          return register;
     }
     public String getSite() {
          return site;
     }

     public String getDeviceType() {
          return deviceType;
     }

     public String getDeviceName() {
          return deviceName;
     }

     public String getDeviceIp() {
          return deviceIp;
     }

     public String getUsername() {
          return username;
     }

     public String getPassword() {
          return password;
     }

     public String getReadCommunity() {
          return readCommunity;
     }

     public String getWriteCommunity() {
          return writeCommunity;
     }
}
