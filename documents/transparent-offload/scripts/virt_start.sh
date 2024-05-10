#!/bin/bash
insmod ./qtfs.ko qtfs_server_ip=192.168.10.11 qtfs_log_level=NONE

systemctl stop libvirtd

if [ ! -d "/root/new_root/local_proc" ]; then
    mkdir -p /root/new_root/local_proc
fi
if [ ! -d "/root/new_root/local" ]; then
    mkdir -p /root/new_root/local
fi
mount -t proc proc /root/new_root/local_proc/
mount -t proc proc /root/new_root/local/proc
mount -t sysfs sysfs /root/new_root/local/sys
mount --bind /var/run/ /root/new_root/var/run/
mount --bind /var/lib/ /root/new_root/var/lib/
mount --bind /var/cache/ /root/new_root/var/cache
mount --bind /etc /root/new_root/etc

mkdir -p /root/new_root/home/VMs/
mount -t qtfs /home/VMs/ /root/new_root/home/VMs/

mount -t qtfs /var/lib/libvirt /root/new_root/var/lib/libvirt

mount -t devtmpfs devtmpfs /root/new_root/dev/
mount -t hugetlbfs hugetlbfs /root/new_root/dev/hugepages/
mount -t mqueue mqueue /root/new_root/dev/mqueue/
mount -t tmpfs tmpfs /root/new_root/dev/shm

mount -t sysfs sysfs /root/new_root/sys
mkdir -p /root/new_root/sys/fs/cgroup
mount -t tmpfs tmpfs /root/new_root/sys/fs/cgroup
list="perf_event freezer files net_cls,net_prio hugetlb pids rdma cpu,cpuacct memory devices blkio cpuset"
for i in $list
do
        echo $i
        mkdir -p /root/new_root/sys/fs/cgroup/$i
        mount -t cgroup cgroup -o rw,nosuid,nodev,noexec,relatime,$i /root/new_root/sys/fs/cgroup/$i
done

## common system dir
mount -t qtfs -o proc /proc /root/new_root/proc
echo "proc"

mount -t qtfs /sys /root/new_root/sys
echo "cgroup"
mount -t qtfs /dev/pts /root/new_root/dev/pts
mount -t qtfs /dev/vfio /root/new_root/dev/vfio
