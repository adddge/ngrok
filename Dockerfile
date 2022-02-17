FROM golang:1.13

WORKDIR /ngrok

COPY . /ngrok

RUN apt-get update && apt-get upgrade -y && apt-get install supervisor socat -y && \
cd /ngrok && mkdir cert

ENV GODEBUG="x509ignoreCN=0"
ENV email adddge@aliyun.com
ENV DOMAIN ng.adong.wiki
ENV HTTP 80
ENV HTTPS 443
ENV SDOMAIN test

CMD ["sh", "-c", "/ngrok/start.sh $DOMAIN $HTTP $HTTPS"]

# docker build -t adddge/ngrok:1.0 .
# docker run -it --name ngrok --restart=always -p 80:80 -p 443:443 -p 4443:4443 -e domain=ng.adong.wiki -e http=80 -e https=443 adddge/ngrok:1.0
# docker cp ngrok:/ngrok/bin/darwin_amd64/ngrok /home/ngrok
# docker cp ngrok:/ngrok/bin/windows_amd64/ngrok.exe /home/ngrok.exe
# docker cp ngrok:/ngrok/bin/darwin_amd64/ngrok /home/ngrok


# --webroot /opt/html --standalone
# curl  https://get.acme.sh >> ./acme.sh && chmod +x ./acme.sh && ./acme.sh install --force
# ~/.acme.sh/acme.sh --force --register-account -m "$4" --issue --debug --standalone -d "$1"

# ~/.acme.sh/acme.sh --force --install-cert -d "$1" \
# --cert-file      /ngrok/assets/server/tls/snakeoil.crt  \
# --key-file       /ngrok/assets/server/tls/snakeoil.key \
# --fullchain-file /ngrok/assets/client/tls/ngrokroot.crt