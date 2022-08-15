#!/bin/bash

setcap "cap_net_admin,cap_net_raw+p" /mnt/disk/usr/bin/ping
setcap "cap_net_admin,cap_net_raw+p" /mnt/disk/usr/bin/ping6
setcap "cap_net_raw+p" /mnt/disk/usr/sbin/arping
setcap "cap_net_raw+p" /mnt/disk/usr/sbin/clockdiff
