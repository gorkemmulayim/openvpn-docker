#!/usr/bin/env bash

# First argument: Identifier
# Second argument: Operating system

identifier="$identifier"
os="$2"

cat $os.conf \
  <(echo -e "") \
  <(echo -e "<ca>") \
  pki/ca.crt \
  <(echo -e "</ca>\n<cert>") \
  pki/issued/"$identifier".crt \
  <(echo -e "</cert>\n<key>") \
  pki/private/"$identifier".key \
  <(echo -e "</key>\n<tls-auth>") \
  ta.key \
  <(echo -e "</tls-auth>") \
  > "$identifier".ovpn
