# Networking

## CHUWI
- Controller
- 192.168.78.201

## Mini PCs
- Workers
- 192.168.78.202-203

## Rock64
- Masters
- 192.168.78.204-207

# Operating System

## AMD Nodes
- [Lubuntu](http://cdimage.ubuntu.com/lubuntu/releases/18.04/release/lubuntu-18.04.3-desktop-amd64.iso)
- Select Minimal
- Hostname: `nodeX`
- Credentials: `node:node`

```shell script
sudo apt install -y ssh
```

## ARM Nodes
- [Pine64 Installer](https://github.com/pine64dev/PINE64-Installer)
- Armbian Ubuntu Bionic Minimal
- Default credentials: `root:1234`
- New credentials: `node:node`
```shell script
armbian-config
# Network > Wifi > Activate
# Personal > Hostname > nodeX
```

# Access
- TODO: Move to Ansible
```shell script
ssh-copy-id -i ~/.ssh/id_rsa node@192.168.178.20

scp ~/.ssh/id_rsa node@192.168.178.20:~/.ssh/
scp ~/.ssh/id_rsa.pub node@192.168.178.20:~/.ssh/

ssh node@192.168.178.20
sudo visudo
# Add to end of file:
node  ALL=(ALL) NOPASSWD:ALL
```

# Configure `kubectl`
```shell script
rm -f ~/.kube/config
ssh node@192.168.178.201 -- cat /home/node/kubeconfig > ~/.kube/config
```
