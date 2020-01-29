# Armbian
- [Docs](https://www.armbian.com/rock64/)
- [Guide](https://itnext.io/building-an-arm-kubernetes-cluster-ef31032636f9)

# Kubernetes 

## Setup

- [Install Docs](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

### All Devices

#### Unique IDs
```bash
rm /etc/machine-id
rm /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
# reboot
```

#### Install `kubelet kubeadm kubectl`
```bash
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

#### Install Docker
- [Docker Install Docs](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
```bash
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-cache madison docker-ce 
apt-get install docker-ce=$VERSION_STRING
```

#### Disable Swap
- Add this line to `/etc/rc.local`:
```
swapoff -a
```

#### Enable services on startup
```bash
systemctl enable kubelet
# ??? systemctl enable docker
```

### Master Only

#### Initialize
```bash
kubeadm config images pull
kubeadm init

su - admin
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### Weave Net
```bash
sysctl net.bridge.bridge-nf-call-iptables=1
su - admin
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

#### Confirm
- [Pending CoreDNS](https://github.com/kubernetes/kubeadm/issues/980)
```bash
watch kubectl get pods --all-namespaces
```

### Workers Only

#### Join Cluster
```bash
kubeadm join 192.168.178.214:6443 --token XXX --discovery-token-ca-cert-hash XXX
```

### Confirm on Master
```bash
watch kubectl get nodes
```

## Workstation
```bash
mkdir -p ~/.kube/
scp root@192.168.178.214:/etc/kubernetes/admin.conf ~/.kube/config
```

## Dashboard
- [Docs](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
```bash

```


## Troubleshooting

### After node reboot, it does not join the cluster
```bash
# on node
swapoff -a
systemctl restart kubelet
```

### Pod stuck in ContainerCreating
```bash
# on each device
rm /etc/machine-id
rm /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
# reboot
```




