#!/bin/bash

arr=($(virsh list --all | grep -v Name | awk '{print $2}'))

for i in ${arr[@]};
# do echo $i;
 do virsh dumpxml $i > $i.xml;
done



