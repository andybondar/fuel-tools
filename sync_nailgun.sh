#!/bin/bash

source_dir="/root/gerrit/fuel-web/nailgun/nailgun/"
target_dir="/var/lib/docker/devicemapper/mnt/e2132d89e355747542a599098852b00472d016991dbbd174befb339a69e1f734/rootfs/usr/lib/python2.6/site-packages/nailgun"

rsync -a $source_dir $target_dir

#echo $source_dir
#echo $target_dir
