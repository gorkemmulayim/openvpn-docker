FROM alpine

RUN apk add --update openvpn iptables

WORKDIR /etc/openvpn

COPY server.conf .
COPY ca.crt .
COPY server.crt .
COPY server.key .
COPY dh2048.pem .
COPY ta.key .
COPY crl.pem .

COPY run.sh .
RUN chmod +x run.sh

EXPOSE 1194/udp

CMD ./run.sh
