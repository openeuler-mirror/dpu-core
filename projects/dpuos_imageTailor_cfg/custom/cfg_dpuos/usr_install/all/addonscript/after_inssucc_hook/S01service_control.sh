#!/bin/bash

LOCAL_DISK_PATH=/mnt/disk

chroot ${LOCAL_DISK_PATH} <<EOF
systemctl disable chronyd.service
systemctl disable ntpd.service
systemctl enable hirmd.service
EOF

return 0
