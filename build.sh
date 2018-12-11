#!/bin/sh

set -x
set -e

if [ ! -f EasyRSA-3.0.4.tgz ]; then
	wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz
fi
rm -rf EasyRSA-3.0.4
tar xvf EasyRSA-3.0.4.tgz

cd EasyRSA-3.0.4
cp ../vars .
./easyrsa init-pki
yes | ./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full ubuntu nopass
./easyrsa build-client-full windows nopass
./easyrsa gen-dh
./easyrsa gen-crl
openvpn --genkey --secret ta.key
cd ..

./make_client_ovpn.sh ubuntu ubuntu
./make_client_ovpn.sh windows windows

docker build -t openvpn .
