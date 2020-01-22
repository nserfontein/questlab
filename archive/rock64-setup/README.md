# Networking
## Main Wifi (Ziggo)
- [Browse Admin](http://192.168.178.1/)
- Advanced Settings > DHCP > DHCPv4 server:
    - Enabled
    - Starting local address: 192.168.178.10
    - Number of CPEs: 189
    - Lease Time: 3600 seconds
- Advanced Settings > DHCP > Reserved IP Addresses
    - rock1    AE:84:C6:6A:5C:81   192.168.178.211
    - rock2    AE:84:C6:AE:2E:25   192.168.178.212
    - rock3    AE:84:C6:DD:28:52   192.168.178.213
    - rock4    AE:84:C6:50:E0:13   192.168.178.214

## Wifi Extender (TP Link)
- Hold reset for 15 seconds
- Wait for "TP-Link_Extender" to become available on Wifi
- Connect Wifi to "TP-Link_Extender"
- [Browse Admin](http://tplinkrepeater.net)
- Create password
- Select main Wifi and enter password
- Change SSID to {MAIN_WIFI}_EXT
- Apply (and auto reboot)
- Confirm by connecting to extender (main Wifi password)
- Confirm Internet connection
- Network Settings: 
    - IP Address: 192.168.178.227 (dynamic)
    - Subnet Mask: 255.255.255.0
    - Default Gateway: 192.168.178.1
- DHCP Server Settings:
    - DHCP Server: Off
    - // IGNORE: IP Address Pool: 192.168.178.100 - 192.168.178.199
    - // IGNORE: Address Lease Time: 1
    - // IGNORE: Default Gateway: 192.168.178.1
    - // IGNORE: Primary DNS: Blank
    - // IGNORE: Secondary DNS: Blank
    
# Serial Interface (Only if no screen available)
- [Steps](https://forum.pine64.org/showthread.php?tid=5029)
- [Serial Driver](https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver)
- [CoolTerm](http://freeware.the-meiers.org/CoolTermMac.zip)
    - Port: wchusbserial14610
    - Data Rate: 1500000
    - Data Bits: 8
    - Parity: None
    - Stop Bits: 1
