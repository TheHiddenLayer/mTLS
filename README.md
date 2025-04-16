```bash
# Generate client and server certificates
./gen-certs.sh

# Start NGINX server
docker compose up

# GET request to /
curl localhost:8443 --cacert ./certs/server-ca.crt
```