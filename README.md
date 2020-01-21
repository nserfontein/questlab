# Networking

## CHUWI
- Rancher
- Kubernetes Master
- 192.168.78.201

## Mini PCs
- Kubernetes Workers
- 192.168.78.202-203

## Rock64
- Kubernetes Workers
- 192.168.78.204-207

# Operating System

## Intel Nodes
- [Lubuntu](http://cdimage.ubuntu.com/lubuntu/releases/18.04/release/lubuntu-18.04.3-desktop-amd64.iso)
- Select Minimal
- Hostname: `nodeX`
- Username, Password: `node`

```shell script
sudo apt install -y ssh
```

## ROCK64 Nodes
- [Pine64 Installer](https://github.com/pine64dev/PINE64-Installer)
- [Armbian Ubuntu Bionic Desktop](https://wiki.pine64.org/index.php/ROCK64_Software_Release#Armbian_Ubuntu_Bionic_Desktop_on_mainline_Kernel_.5BmicroSD_.2F_eMMC_Boot.5D)
- Settings > Armbian Config > Personal > Hostname > `nodeX`
- Username, Password: `node`

# Access
```shell script
ssh-copy-id -i ~/.ssh/id_rsa node@192.168.178.20

ssh node@192.168.178.20
sudo visudo
# Add to end of file:
node  ALL=(ALL) NOPASSWD:ALL
```

# Setup
```shell script
cd control
./setup.sh
```

# Status
```shell script
cd control
./status.sh
```

# Reboot
```shell script
cd control
./reboot.sh
```

# Reset
```shell script
cd control
./reset.sh
```
