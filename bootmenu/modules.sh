#!/bin/sh
# copy modules to root-dir if not exist
if [ ! -e /lib/modules/lirc_dev.o ]; then
    cp /mnt/bootmenu/lib/modules/lirc_dev.o /lib/modules/;
fi

if [ ! -e /lib/modules/lirc_xilleon.o ]; then
    cp /mnt/bootmenu/lib/modules/lirc_xilleon.o /lib/modules/;
fi

if [ ! -e /lib/modules/evdev.o ]; then
    cp /mnt/bootmenu/lib/modules/evdev.o /lib/modules/;
fi

# remove ir-module from motorola-stack to load lirc-modules
if [ "`lsmod | grep 08ir`" != "" ]; then
    /sbin/rmmod 08ir;
fi

# insert modules if not already done
# (this could have been done by boot-menu)
if [ "`lsmod | grep lirc`" = "" ]; then
    /sbin/insmod lirc_dev >/dev/null
    /sbin/insmod lirc_xilleon >/dev/null
fi
if [ "`lsmod | grep evdev`" = "" ]; then
    /sbin/insmod evdev >/dev/null
fi

if [ "`mount | grep usbdevfs`" = "" ]; then
    mount -t usbdevfs none /proc/bus/usb;
fi
