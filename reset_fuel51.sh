#!/bin/bash

cobbler_container_id=$(docker ps --no-trunc | awk '/cobbler/ {print $1}')

nailgun_container_id=$(docker ps --no-trunc | awk '/nailgun/ {print $1}')

cobbler_container='dockerctl shell cobbler'

nailgun_container='dockerctl shell nailgun'



refresh_cobbler () {

    $cobbler_container /etc/init.d/dnsmasq stop

    echo > /var/lib/docker/devicemapper/mnt/${cobbler_container_id}/rootfs/var/lib/dnsmasq/dnsmasq.leases

    $cobbler_container /etc/init.d/dnsmasq start

    $cobbler_container cobbler sync

    sleep 1

    #FIXME

    #ssh root@$FUEL_MASTER 'amqp-deleteq naily --user naily --password naily && supervisorctl restart naily'

}



    for system in $($cobbler_container cobbler system list |grep -v default |grep -v fuel); do

        echo "Cobbler removing $system"

        $cobbler_container cobbler system remove --name $system

    done

    refresh_cobbler

    $nailgun_container manage.py dropdb

    $nailgun_container manage.py syncdb

    $nailgun_container manage.py loaddefault

    sleep 5
