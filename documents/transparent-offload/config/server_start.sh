#!/bin/bash

modprobe overlay
mkdir /var/lib/docker/containers
mkdir -p /var/lib/docker/containers
mkdir -p /var/lib/docker/containerd
mkdir -p /var/lib/docker/overlay2
mkdir -p /var/lib/docker/tmp
mkdir -p /var/lib/docker/image
mkdir -p /var/run/docker/containerd
mkdir -p /run/containerd/io.containerd.runtime.v1.linux/
mkdir -p /var/run/docker/netns
mkdir -p /var/lib/containerd/io.containerd.runtime.v1.linux/
mkdir -p /run/user/0
touch /var/run/docker/netns/default
# this should be done once
mount --bind /proc/1/ns/net  /var/run/docker/netns/default

function TaskClean()
{
	echo "Now do task clean..."
	pkill engine
	rmmod qtfs_server
	echo "TaskClean done"
}

trap "TaskClean exit" SIGINT

mkdir -p /var/run/docker/containerd
mkdir -p /run/containerd/io.containerd.runtime.v1.linux/

# TEST_MODE: IP
insmod ${YOUR_PATH}/qtfs_server.ko qtfs_server_ip=${YOUR_SERVER_IP} qtfs_log_level=ERROR
nohup ${YOUR_PATH}/engine 16 1 ${YOUR_SERVER_IP} 12121 ${YOUR_CLIENT_IP} 12121 2>&1 &

# TEST_MODE: vsock
# insmod ${YOUR_PATH}/qtfs_server.ko qtfs_server_vsock_cid=${YOUR_SERVER_VSOCK_CID} qtfs_log_level=ERROR
# nohup ${YOUR_PATH}/engine 16 1 ${YOUR_SERVER_VSOCK_CID} 12121 ${YOUR_CLIENT_VSOCK_CID} 12121 2>&1 &

sleep 2

qtcfg -w udsconnect -x /var/run/rexec
qtcfg -w udsconnect -x /run/rexec
qtcfg -w udsconnect -x /var/run/containerd
