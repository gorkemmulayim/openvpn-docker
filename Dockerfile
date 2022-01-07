FROM ubuntu:20.04 as build

WORKDIR /build

RUN apt-get update && apt-get install -y openssl iptables openvpn

ADD https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz .
RUN tar xvf EasyRSA-3.0.4.tgz
COPY vars EasyRSA-3.0.4/
RUN ./EasyRSA-3.0.4/easyrsa init-pki
RUN ./EasyRSA-3.0.4/easyrsa build-ca nopass -batch
RUN ./EasyRSA-3.0.4/easyrsa build-server-full server nopass
RUN ./EasyRSA-3.0.4/easyrsa build-client-full ubuntu nopass
RUN ./EasyRSA-3.0.4/easyrsa build-client-full windows nopass
RUN ./EasyRSA-3.0.4/easyrsa build-client-full ios nopass
RUN ./EasyRSA-3.0.4/easyrsa gen-dh
RUN ./EasyRSA-3.0.4/easyrsa gen-crl
RUN openvpn --genkey --secret ta.key

COPY make_client_ovpn.sh .
COPY ubuntu.conf .
COPY windows.conf .
COPY ios.conf .

RUN ./make_client_ovpn.sh ubuntu ubuntu
RUN ./make_client_ovpn.sh windows windows
RUN ./make_client_ovpn.sh ios ios

WORKDIR /etc/openvpn

COPY server.conf .
RUN cp /build/pki/ca.crt .
RUN cp /build/pki/issued/server.crt .
RUN cp /build/pki/private/server.key .
RUN cp /build/pki/dh.pem dh2048.pem
RUN cp /build/ta.key .
RUN cp /build/pki/crl.pem .

CMD ["/bin/bash", "-c", "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE && openvpn --config server.conf"]
