#!/bin/bash

#take down the interface and wait 5 seconds 
ifconfig eth0 down
sleep 5

#bring interface back up 
ifconfig eth0 up

#initially assign Intel-based MAC address to the interface 
macchanger -p -m 00:1B:21:80:46:3B eth0

#change the MAC without affecting the vendor bits 
macchanger -e -a eth0

#release and renew DHCP; restart networking 
dhclient -r -v eth0 && dhclient -v eth0
/etc/init.d/networking restart

#ping your DNS server 
for i in `cat /etc/resolv.conf |grep -w .| awk '{print $2}'`; do ping -c 1 $i; done

#run tcpdump on your ForeScout server, look for smb (obvi you need to change this IP) 
tcpdump -nnp host 10.1.10.20 # update this IP address!!
