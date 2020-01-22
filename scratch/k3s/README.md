# Setup
```shell script
# On workstation
scp ~/.ssh/id_rsa node@192.168.178.204:~/.ssh/
scp ~/.ssh/id_rsa node@192.168.178.205:~/.ssh/
scp ~/.ssh/id_rsa node@192.168.178.206:~/.ssh/
scp ~/.ssh/id_rsa node@192.168.178.207:~/.ssh/

# Configure Bastion
ssh node@192.168.178.204
cd /tmp

curl https://releases.rancher.com/install-docker/19.03.sh | sh


curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/arm64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -sLS https://get.k3sup.dev | sh
sudo install k3sup-arm64 /usr/local/bin/k3sup

# Configure Master (from bastion)
k3sup install --ip 192.168.178.205 --user node

# Configure Workers (from bastion)
k3sup join --ip 192.168.178.206 --server-ip 192.168.178.205 --user node
k3sup join --ip 192.168.178.207 --server-ip 192.168.178.205 --user node
```

# Config
```shell script
export KUBECONFIG=/home/node/.ssh/kubeconfig
kubectl get node -o wide
```
