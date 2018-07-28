# Bochs-linux

## bochsrc
```
###############################################################
# bochsrc.txt file for DLX Linux disk image.
###############################################################
# how much memory the emulated machine will have
megs: 16
# filename of ROM images
romimage: file=$BXSHARE/BIOS-bochs-latest
vgaromimage: file=$BXSHARE/VGABIOS-lgpl-latest
# what disk images will be used 
floppya: 1_44=scsi, status=inserted
floppyb: 1_44=color144, status=inserted
# hard disk
ata0: enabled=1, ioaddr1=0x1f0, ioaddr2=0x3f0, irq=14
ata0-master: type=disk, path="disk.img", cylinders=520, heads=16, spt=63
ata0-slave: type=disk, path="diskapp.img", cylinders=260, heads=16, spt=63
ata0-slave: type=disk, path="disksrc.img", cylinders=520, heads=16, spt=63
# choose the boot disk.
boot: a
# default config interface is textconfig.
#config_interface: textconfig
#config_interface: wx
#display_library: x
# other choices: win32 sdl wx carbon amigaos beos macintosh nogui rfb term svga
# where do we send log messages?
log: bochsout.txt
# disable the mouse, since DLX is text only
mouse: type=imps2, enabled=1
# set up IPS value and clock sync
cpu: ips=15000000
clock: sync=both
# enable key mapping, using US layout as default.
keyboard: keymap=$BXSHARE/keymaps/x11-pc-us.map
pci: enabled=1, chipset=i440fx, slot1=pcivga, slot2=ne2k
sound: driver=default, waveout=/dev/dsp
ne2k: ioaddr=0x300, irq=9, mac=b0:c4:20:00:00:00, ethmod=linux, ethdev=eno1
```

## boot.img
> slackware-2.0.0 -> scsi.gz
> `gunzip scsi.gz`

## root.img
> slackware-2.0.0 -> color144.gz
> `gunzip color144.gz`

## disk.img
> 512 * 524160 = 520 * 16 * 63 * 512 = 260M
```bash
dd if=/dev/zero of=disk.img bs=512 count=524160

# sudo losetup /dev/loop1 disk.img
# sudo fdisk /dev/loop1
# ...
# sudo losetup -d /dev/loop1

# sudo losetup -o 1048576 /dev/loop1 disk.img (1048576=512*2048)
# sudo mkfs -t ext2 /dev/loop1
# sudo mount -t ext2 /dev/loop1 /mnt
# sudo cp -r .../slackware /mnt
# sudo umount /mnt
# sudo losetup -d /dev/loop1
```

## diskapp.img
> 512 * 262080 = 260 * 16 * 63 * 512 = 130M
```bash
dd if=/dev/zero of=diskapp.img bs=512 count=262080
```

## disksrc.img
> 512 * 524160 = 520 * 16 * 63 * 512 = 260M
```bash
dd if=/dev/zero of=disk.img bs=512 count=524160
```

## start.sh
```bash
#!/bin/bash

BXSHARE=/usr/share/bochs

export BXSHARE

bochs -f bochsrc -q
```

```bash
chmod a+x start.sh
./start.sh
```

```bash in bochs
mount root=/dev/fd1

fdisk /dev/hda
n -> ...(hda1(240M), hda2(8M:swap))
mke2fs /dev/hda1

fdisk /dev/hdb
n -> ...(hdb1(120M))
mke2fs /dev/hdb1

fdisk /dev/hdc
n -> ...(hdc1(260M))
mke2fs /dev/hdc1

logout
```

```bash
sudo losetup -o 32256 /dev/loop1 diskapp.img (32256=63*512)
sudo mount -t ext2 /dev/loop1 /mnt
sudo cp -r ...slackware-2.0.0/slakware /mnt
sudo umount /mnt
sudo losetup -d /dev/loop1
./start.sh
```

```bash
sudo losetup -o 32256 /dev/loop1 disksrc.img (32256=63*512)
sudo mount -t ext2 /dev/loop1 /mnt
sudo cp -r ...slackware-2.0.0/source /mnt
sudo umount /mnt
sudo losetup -d /dev/loop1
./start.sh
```

```bash in bochs
mkswap /dev/hda2 8568
swapon /dev/hda2

setup
```