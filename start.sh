#!/usr/bin/env bash

echo "ngrok run $1 $2 $3 $4 $5"

device_crt="/ngrok/cert/device.crt"
if [ ! -f "$device_crt" ];then
    cd /ngrok/cert
    openssl genrsa -out rootCA.key 2048
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$1" -days 5000 -out rootCA.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=$1" -out device.csr
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
    
    cp rootCA.pem /ngrok/assets/client/tls/ngrokroot.crt
    cp device.crt /ngrok/assets/server/tls/snakeoil.crt
    cp device.key /ngrok/assets/server/tls/snakeoil.key

    cd /ngrok/

    GOOS=linux GOARCH=amd64 make release-server
    GOOS=darwin GOARCH=amd64 make release-client
    GOOS=windows GOARCH=amd64 make release-client
fi
./bin/ngrokd -domain="$1" -httpAddr=":$2" -httpsAddr=":$3"


# start.sh test.com 80 443