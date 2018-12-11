FROM alpine

RUN apk add --update openvpn iptables

WORKDIR /etc/openvpn

COPY server.conf .
COPY EasyRSA-3.0.4/pki/ca.crt .
COPY EasyRSA-3.0.4/pki/issued/server.crt .
COPY EasyRSA-3.0.4/pki/private/server.key .
COPY EasyRSA-3.0.4/pki/dh.pem dh2048.pem
COPY EasyRSA-3.0.4/ta.key .
COPY EasyRSA-3.0.4/pki/crl.pem .

COPY run.sh .
RUN chmod +x run.sh

EXPOSE 1194/udp

CMD ./run.sh
