```bash
sudo -i
apt update

apt-get remove docker docker-engine docker.io containerd runc
apt autoremove

cd /tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker node

# Downgrade docker to supported version by Rancher (https://rancher.com/docs/rancher/v2.x/en/installation/requirements/)
apt-get purge -y docker-ce docker-ce-cli containerd.io
apt-get install -y docker-ce=18.06.3~ce~3-0~ubuntu containerd.io
```
