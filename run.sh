#!/bin/sh

set -x
set -e

iptables -t nat -A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE

sysctl -w net.ipv4.ip_forward=1 || echo "Failed to enable IPv4 Forwarding"
ip -6 route show default 2>/dev/null
sysctl -w net.ipv6.conf.all.disable_ipv6=0 || echo "Failed to enable IPv6 support"
sysctl -w net.ipv6.conf.default.forwarding=1 || echo "Failed to enable IPv6 Forwarding default"
sysctl -w net.ipv6.conf.all.forwarding=1 || echo "Failed to enable IPv6 Forwarding"
sysctl -p

openvpn --config server.conf
