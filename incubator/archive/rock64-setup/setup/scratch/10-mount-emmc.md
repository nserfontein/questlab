# TODO: How to automate this in ansible?

# Clear Partitions
- /dev/mmcblk0 = eMMC
- /dev/mmcblk1 = SD

```bash
sudo -i
fdisk -l
fdisk /dev/mmcblk0
```

## fdisk prompt
```
p # list partitions
d # delete all partitions
w # write changes
```

# Create Partition

```bash
fdisk /dev/mmcblk0
```

## fdisk prompt
```
n # create new partition, all defaults
w # write changes
```

# Format Partition
```bash
fdisk -l
mkfs.ext4 -L "emmc" /dev/mmcblk0p1
```

# Mount
```bash
mkdir /emmc
mount /dev/mmcblk0p1 /emmc
```
