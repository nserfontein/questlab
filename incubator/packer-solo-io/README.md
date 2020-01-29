# TODO:
- Note if your image is arm64, set qemu_binary to qemu-aarch64-static in your configuration json file.

# Scratch 1  
```shell script
cd /tmp
git clone https://github.com/solo-io/packer-builder-arm-image
cd packer-builder-arm-image

PACKERFILE=~/dev/home/questlab/incubator/packer-solo-io/rock64.json
vagrant up --no-provision
vagrant provision --provision-with build-image

```

# Scratch 2
```shell script
cd /tmp
git clone https://github.com/solo-io/packer-builder-arm-image
cd packer-builder-arm-image
docker build -t packer-builder-arm .

docker run \
  --rm \
  --privileged \
  -v ${PWD}:/build \
  -v ${PWD}/packer_cache:/build/packer_cache \
  -v ${PWD}/output:/build/output \
  packer-builder-arm build samples/raspbian_golang.json
```

# Resources
- [Steps](https://github.com/solo-io/packer-builder-arm-image)
