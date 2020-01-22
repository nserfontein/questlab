- [Ask Ubuntu](https://askubuntu.com/questions/1105069/how-to-enable-wireless-on-ubuntu-server-18-04-via-cli)
- Ethernet connected
```bash
ssh-keygen -R snode1
ssh rock64@snode1
# Password: rock64
```

- Create 01-netcfg.yaml
```bash
sudo -i
apt install -y wireless-tools
ifconfig
iwlist wlxXXXXXXXXXXXX scan | grep SSID

nano /etc/netplan/01-netcfg.yaml
```
```
network:
  version: 2
  renderer: networkd
  wifis:
    wlxXXXXXXXXXXXX:
      dhcp4: true
      access-points:
        "Ziggo53A85C3_EXT":
          password: "Bluerobin123"
```
```bash
netplan --debug generate
netplan apply
reboot
# remove ethernet
```

# TRY THIS - Asus USB-N10 Driver (RTL8192CU)
- [Resource](http://ubuntuhandbook.org/index.php/2019/04/nstall-rtl8723de-wifi-driver-ubuntu-19-04/)
```bash
sudo apt-get update -y
sudo apt-get install dkms git-core build-essential
git clone -b extended https://github.com/lwfinger/rtlwifi_new.git
sudo dkms add ./rtlwifi_new
sudo dkms install rtlwifi-new/0.6
# Reboot?XZZxz

# If not connected:
sudo modprobe -r rtl8723de && sudo modprobe rtl8723de


```


# TRY THIS - 
- [Forum](https://forum.pine64.org/showthread.php?tid=5292&pid=33035#pid33035)
- [NMTUI](https://manpages.ubuntu.com/manpages/xenial/en/man1/nmtui.1.html)
