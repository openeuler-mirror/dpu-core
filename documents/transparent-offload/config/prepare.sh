#!/bin/bash

mkdir -p /another_rootfs/var/run/docker/containerd
iptables -t nat -N DOCKER

echo "---------insmod qtfs ko----------"
# TEST_MODE: IP
insmod ${YOUR_PATH}/qtfs.ko qtfs_server_ip=${YOUR_SERVER_IP} qtfs_log_level=INFO #此处需要自行修改ip, 以及ko的路径
nohup ${YOUR_PATH}/udsproxyd 1 ${YOUR_CLIENT_IP} 12121 ${YOUR_SERVER_IP} 12121 2>&1 &

# TEST_MODE: vsock
# insmod ${YOUR_PATH}/qtfs.ko qtfs_server_vsock_cid=${YOUR_SERVER_VSOCK_CID} qtfs_log_level=INFO #此处需要自行修改ip, 以及ko的路径
# nohup ${YOUR_PATH}/udsproxyd 1 ${YOUR_CLIENT_VSOCK_CID} 12121 ${YOUR_SERVER_VSOCK_CID} 12121 2>&1 &

qtcfg -w udsconnect -x /var/run/rexec
qtcfg -w udsconnect -x /run/rexec

mkdir /another_rootfs/local_proc/
mount -t proc proc /another_rootfs/local_proc/
mount --bind /var/run/ /another_rootfs/var/run/
mount --bind /var/lib/ /another_rootfs/var/lib/
mount --bind /etc /another_rootfs/etc
mount -t devtmpfs devtmpfs /another_rootfs/dev/
mount -t sysfs sysfs /another_rootfs/sys
mkdir -p /another_rootfs/sys/fs/cgroup
mount -t tmpfs tmpfs /another_rootfs/sys/fs/cgroup
list="perf_event freezer files net_cls,net_prio hugetlb pids rdma cpu,cpuacct memory devices blkio cpuset"
for i in $list
do
        echo $i
        mkdir -p /another_rootfs/sys/fs/cgroup/$i
        mount -t cgroup cgroup -o rw,nosuid,nodev,noexec,relatime,$i /another_rootfs/sys/fs/cgroup/$i
done

mount -t qtfs -o proc /proc /another_rootfs/proc
echo "proc"
mount -t qtfs /sys /another_rootfs/sys
echo "cgroup"

mkdir -p /another_rootfs/var/lib/docker/containers
mkdir -p /another_rootfs/var/lib/docker/containerd
mkdir -p /another_rootfs/var/lib/docker/overlay2
mkdir -p /another_rootfs/var/lib/docker/image
mkdir -p /another_rootfs/var/lib/docker/tmp
mount -t qtfs /var/lib/docker/containers /another_rootfs/var/lib/docker/containers
mount -t qtfs /var/lib/docker/containerd /another_rootfs/var/lib/docker/containerd
mount -t qtfs /var/lib/docker/overlay2 /another_rootfs/var/lib/docker/overlay2
mount -t qtfs /var/lib/docker/image /another_rootfs/var/lib/docker/image
mount -t qtfs /var/lib/docker/tmp /another_rootfs/var/lib/docker/tmp
mkdir -p /another_rootfs/run/containerd/io.containerd.runtime.v1.linux/
mount -t qtfs /run/containerd/io.containerd.runtime.v1.linux/ /another_rootfs/run/containerd/io.containerd.runtime.v1.linux/
mkdir -p /another_rootfs/var/run/docker/containerd
mount -t qtfs /run/docker/containerd /another_rootfs/run/docker/containerd
mkdir -p /another_rootfs/var/lib/containerd/io.containerd.runtime.v1.linux
mount -t qtfs /var/lib/containerd/io.containerd.runtime.v1.linux /another_rootfs/var/lib/containerd/io.containerd.runtime.v1.linux

qtcfg -w udsconnect -x /another_rootfs/var/run/rexec
qtcfg -w udsconnect -x /another_rootfs/run/rexec
