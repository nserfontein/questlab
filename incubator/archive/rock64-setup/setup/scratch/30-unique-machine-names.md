# Unique IDs
```bash
cat /etc/machine-id
# Skip if these are different

rm /etc/machine-id
rm /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
# reboot
```
