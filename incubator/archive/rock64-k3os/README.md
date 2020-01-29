# Prerequisites
- Master node IP: 192.168.178.200 (DHCP reservation or static IP)

# Flash Linux on SD Card
- [Pine64 Installer](https://github.com/pine64dev/PINE64-Installer/blob/master/README.md)
- Select "Bionic Minimal"

# Node Setup
- Get IP address (_Angry IP Scanner_ or router dashboard)

```bash
ssh-keygen -R 192.168.178.200
ssh rock64@192.168.178.xxx
# Password: rock64
```

## K3OS ARM Overlay Installation
- [Docs](https://github.com/rancher/k3os#arm-overlay-installation)
- [Latest Releases](https://github.com/rancher/k3os/releases)

### Config file
- [Reference](https://github.com/rancher/k3os#configuration-reference)
- [Github Key (ssh-rsa)](https://github.com/nserfontein.keys)

```bash
sudo -i 
apt update
cd /root && nano myconfig.yml
```

```yaml
# MASTER NODE CONFIG
ssh_authorized_keys:
- ssh-rsa AAAAB3NzaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
- github:nserfontein
hostname: master

k3os:
  data_sources:
  - cdrom
  dns_nameservers:
  - 192.168.178.1
  ntp_servers:
  - 0.nl.pool.ntp.org
  - 1.nl.pool.ntp.org
  #password: rancher
  token: rancher
```

```yaml
# SLAVE NODES CONFIG
ssh_authorized_keys:
- ssh-rsa AAAAB3NzaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
- github:nserfontein
hostname: node{X}

k3os:
  data_sources:
  - cdrom
  dns_nameservers:
  - 192.168.178.1
  ntp_servers:
  - 0.nl.pool.ntp.org
  - 1.nl.pool.ntp.org
  #password: rancher
  token: rancher
  server_url: https://192.168.178.200:6443
```

### Installation on nodes
```bash
curl -sfL https://github.com/rancher/k3os/releases/download/v0.2.1/k3os-rootfs-arm64.tar.gz | tar zxvf - --strip-components=1 -C /
cp /root/myconfig.yml /k3os/system/config.yml

sync

reboot -f
```

### Configure kubectl
```bash
rm ~/.kube/config
ssh rancher@192.168.178.200 -- cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config
# Then change localhost to 192.168.178.200
```

### Get Node Token
```bash
ssh-keygen -R 192.168.178.200
ssh rancher@192.168.178.200 -- sudo cat /var/lib/rancher/k3s/server/node-token
# No password (or "rancher" ???)
```

# Dashboard UI
- [Docs](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [Token](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user)
- [Access UI](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)



------------------------------------------------------------------------------------------------------------------------

# Resources
- [Pine64 Cluster with K3OS](https://thepracticalsysadmin.com/build-a-pine64-kubernetes-cluster-with-k3os/)

# Tools
- [Angry IP Scanner](https://github.com/angryip/ipscan/releases)
