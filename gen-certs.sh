#!/bin/bash
# NOTE: this example has the client and server rely on *separate* Certificate Authorities

mkdir -p certs

# Generate certificate authority private keys
openssl genrsa -out certs/server-ca.key 2048
openssl genrsa -out certs/client-ca.key 2048

# Generate Certificate Authority certificates (reference private keys created in previous step)
openssl req -new -x509 -nodes -days 1000 -key certs/server-ca.key -out certs/server-ca.crt
openssl req -new -x509 -nodes -days 1000 -key certs/client-ca.key -out certs/client-ca.crt

# Generate a Certificate Authority signing request
openssl req -newkey rsa:2048 -nodes -keyout certs/server.key -out certs/server.req
openssl req -newkey rsa:2048 -nodes -keyout certs/client.key -out certs/client.req

# Have the Certificate Authority sign the requests and generate the certificates for the client and server
openssl x509 -req -in certs/server.req -days 1000 -CA certs/server-ca.crt -CAkey certs/server-ca.key -set_serial 01 -out certs/server.crt -extfile localhost.ext
openssl x509 -req -in certs/client.req -days 1000 -CA certs/client-ca.crt -CAkey certs/client-ca.key -set_serial 01 -out certs/client.crt

# Clean up the request
rm certs/server.req
rm certs/client.req
