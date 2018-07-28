# 使用qemu运行slackware-2.0 #

[mirror]: https://mirrors.slackware.com/slackware/slackware-2.0.0/
[logo]: http://www.slackware.com/grfx/shared/slackware_traditional_website_logo.png
[qemu-slackware]: /pictures/qemu-slackware.png
[slackware]: /pictures/slackware-2.0.png

## ![slackware][logo] ##
## [slackware-2.0镜像链接][mirror] ##

*   *00index.txt*

    > 此文件含有slackware-2.0发行版的所有文件清单，用于slackware_download.sh下载。
    > 
    > 

*   *slackware_download.sh*

    > 用于下载00index.txt中的所有文件到当前目录下的slackfat目录中。
    > 系统需有wget工具
    > 

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

1.  `./slackware_download.sh`

2.  `dd if=/dev/zero of=disk.img bs=512 count=262080`

3.  `dd if=/dev/zero of=srcdisk.img bs=512 count=524160`

4.  
        qemu-system-i386 \
            -M isapc \
            -m 16M \
            -fda boot.img \
            -fdb root.img \
            -vga std -monitor stdio \
            -hda disk.img \
            -hdb fat:slackfat \
            -boot once=a \
            -option-rom /usr/share/vgabios/vgabios.bin \

5.  ![qemu-slackware][qemu-slackware]

6.  `mount root=/dev/fd1`

7.  `root`

8.  `setup`

*安装完成后*

9.  `qemu-system-i386 \
       -M isapc \
       -m 16M \
       -vga std -monitor stdio \
       -hda disk.img \
       -boot c \
       -option-rom /usr/share/vgabios/vgabios.bin \`

10. ![slackware][slackware]