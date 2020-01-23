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

# Once Offs
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

# Setup
```shell script
ansible-playbook ./init.yml
ansible-playbook ./setup.yml
```

# Setup `kubectl` on Control
```shell script
ssh node@192.168.178.204
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/arm64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

# Configure `kubectl` on Workstation
```shell script
rm -f ~/.kube/config
ssh node@192.168.178.204 -- cat /home/node/kubeconfig > ~/.kube/config
```

# Reset
```shell script
# Repeat all these steps until "Remove directories" has no critical errors
ansible-playbook ./init.yml
ansible-playbook ./reboot.yml
ansible-playbook ./status.yml
ansible-playbook ./init.yml
```

# Rancher
- [Dashboard](192.168.178.201)
- Clustes > Add Cluster > Import
