#!/bin/bash
local_disk=/mnt/disk
grub_cfg=$(find ${local_disk}/boot -name grub.cfg)
root_mount=$(cat ${grub_cfg} | grep linux | grep "root=" | head -1 | awk -F"root=" '{print $2}' | awk '{print $1}')
function fn_GetPartitionById()
{
    uuid=$(echo "${root_mount}" | awk -F= '{print $2}')
    partition_dev_name=$(ls -l /dev/disk/by-uuid/${uuid} | awk '{print $NF}' | awk -F/ '{print $NF}')
    partition_by_id="`ls -l /dev/disk/by-id 2>&1 | grep -w "${partition_dev_name}" | awk '{print $9}'`"
    if [ -z "${partition_by_id}" ]; then
        echo "/dev/${partition_dev_name}"
    else
        echo "/dev/disk//by-id${partition_by_id}"
    fi
}
partition_byId="$(fn_GetPartitionById)"
sed -i "s#root=${root_mount}#root=${partition_byId}#g" ${grub_cfg}
