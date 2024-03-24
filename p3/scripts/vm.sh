VBoxManage createvm --name debian-iot --ostype Debian_64 --register
vboxmanage modifyvm debian-iot --cpus 4 --memory 4096 --vram 12
VBoxManage storagectl "debian-iot" --name "SATA" --add sata
VBoxManage storageattach "debian-iot" --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium /home/rgeral/data/debian-12.5.0-amd64-netinst.iso
VBoxManage unattended install "debian-iot" --iso="/home/rgeral/data/debian-12.5.0-amd64-netinst.iso" --user=rgeral --password=1234 --full-user-name="rgeral" --country=US --time-zone=UTC
VBoxManage createhd --filename "/home/rgeral/data/debian-iot.vdi" --size 20480
VBoxManage storageattach "debian-iot" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "/home/rgeral/data/debian-iot.vdi"
VBoxManage startvm "debian-iot" --type headless
