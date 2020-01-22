# Install
- [Link](http://wiki.pine64.org/index.php/ROCK64_Software_Release#Ubuntu_18.04_Bionic_Containers_Image_.28DockerCE_.26_Kubernetes.29.5BmicroSD_.2F_eMMC_Boot.5D_.5B0.7.8.5D)

## All nodes

### Access
```bash
ssh rock64@192.168.178.101 # 101 = node1, 102 = node2 etc.
# Password: rock64
```

### Unique IDs
```bash
rm /etc/machine-id
rm /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
# reboot
```

// ### Disable NetworkManager and DHCP Client
// ```bash
// systemctl stop dhcpcd
// systemctl stop NetworkManager
// systemctl disable dhcpcd
// systemctl disable NetworkManager
// systemctl daemon-reload
// ```

### Configure network
```bash
nano /etc/netplan/eth0
```
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses: [192.168.178.101/24]
      gateway4: 192.168.178.1
      nameservers:
        addresses: [192.168.178.1]
      dhcp4: false
```
```bash
netplan apply
```

// ### Set DNS
// ```bash
// nano /etc/resolv.conf
// ``` 
// ```
// nameserver 192.168.178.1
// ```

### Change Hostname
```bash
nano /etc/hosts
nano /etc/hostname
hostname nodex
```

// ### Disable IPv6
// ```bash
// nano /etc/sysctl.conf
// ```
// ```
// net.ipv6.conf.all.disable_ipv6 = 1
// net.ipv6.conf.default.disable_ipv6 = 1
// net.ipv6.conf.lo.disable_ipv6 = 1
// net.ipv6.conf.eth0.disable_ipv6 = 1
// ```
// ```bash
// sysctl -p
// ```

### Reboot
```bash
reboot
```

### Update packages
```bash
apt-mark hold docker-ce
apt -y update
apt -y upgrade
```

## Master node

### Initialize
```bash
kubeadm config images pull

# For weave net
kubeadm init

# For flannel:
kubeadm init --pod-network-cidr=10.244.0.0/16

su - admin
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Weave Net
```bash
su - admin
sudo sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

### ??? Or Falnnel ???
```bash
su - admin
sudo sysctl net.bridge.bridge-nf-call-iptables=1

# According to tutorial:
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# According to docs:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
```

#### Confirm
- [Pending CoreDNS](https://github.com/kubernetes/kubeadm/issues/980)
```bash
watch kubectl get pods --all-namespaces
```

## Worker nodes

### Join Cluster
```bash
(sudo ???) kubeadm join 192.168.178.101:6443 --token aemdju.0ep4ap5l3ze2jial --discovery-token-ca-cert-hash sha256:fd6018ace6388e39eac2695a8bebcf96c6bda8b65a2143083de0bb123b6cd556
```

### Enable services on startup
```bash
systemctl enable kubelet
```

### Confirm
```bash
watch kubectl get nodes
```

## Workstation
```bash
mkdir -p ~/.kube/
scp rock64@192.168.178.101:~/.kube/config ~/.kube/config
```
