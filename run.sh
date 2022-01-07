#!/bin/sh

set -x
set -e

sysctl -w net.ipv4.ip_forward=1 || echo "Failed to enable IPv4 Forwarding"
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

openvpn --config server.conf
