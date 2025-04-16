```bash
# Generate client and server certificates
./gen-certs.sh

# Start NGINX server
docker compose up

# GET request to / on TLS server
curl localhost:8443 --cacert ./certs/server-ca.crt

# GET request to / on mTLS server (have to pass client certificate and key along to server)
curl https://localhost:8444 --cacert certs/server-ca.crt --cert certs/client.crt --key certs/client.key
```