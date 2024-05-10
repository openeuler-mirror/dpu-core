#!/bin/bash

umount /root/new_root/dev/hugepages
umount /root/new_root/etc
umount /root/new_root/home/VMs
umount /root/new_root/local_proc
umount /root/new_root/local/proc
umount /root/new_root/var/lib/libvirt
umount /root/new_root/var/lib
umount /root/new_root/*
umount /root/new_root/dev/pts
umount /root/new_root/dev/mqueue
umount /root/new_root/dev/shm
umount /root/new_root/dev/vfio
umount /root/new_root/dev
rmmod qtfs

umount /root/new_root/sys/fs/cgroup/*
umount /root/new_root/sys/fs/cgroup
umount /root/new_root/sys
