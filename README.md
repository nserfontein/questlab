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
- TODO

# Access
```shell script
ssh-copy-id -i ~/.ssh/id_rsa node@192.168.178.20x

ssh node@192.168.178.20x
sudo visudo
# Add to end of file:
node  ALL=(ALL) NOPASSWD:ALL
```

# Reset
```shell script
cd control
./setup reset
```
