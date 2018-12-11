#!/bin/bash

# First argument: Client identifier
# Second argument: Client operating system

if [ "$2" == "ubuntu" ]
then
  cat ubuntu.conf \
      <(echo -e "") \
      <(echo -e "<ca>") \
      EasyRSA-3.0.4/pki/ca.crt \
      <(echo -e "</ca>\n<cert>") \
      EasyRSA-3.0.4/pki/issued/"$1".crt \
      <(echo -e "</cert>\n<key>") \
      EasyRSA-3.0.4/pki/private/"$1".key \
      <(echo -e "</key>\n<tls-auth>") \
      EasyRSA-3.0.4/ta.key \
      <(echo -e "</tls-auth>") \
      > "$1".ovpn
elif [ "$2" == "windows" ]
then
  cat windows.conf \
      <(echo -e "") \
      <(echo -e "<ca>") \
      EasyRSA-3.0.4/pki/ca.crt \
      <(echo -e "</ca>\n<cert>") \
      EasyRSA-3.0.4/pki/issued/"$1".crt \
      <(echo -e "</cert>\n<key>") \
      EasyRSA-3.0.4/pki/private/"$1".key \
      <(echo -e "</key>\n<tls-auth>") \
      EasyRSA-3.0.4/ta.key \
      <(echo -e "</tls-auth>") \
      > "$1".ovpn
fi
