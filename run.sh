#!/bin/sh

if [ -z "$DOMAINS" ]; then
    echo "Need domain list set as DOMAINS environment variable, comma separated"
    exit
fi

if [ -z "$CLOUDFLARE_TOKEN" ]; then
    echo "Need cloudflare api token set as CLOUDFLARE_TOKEN environment variable"
    exit
fi

if [ -z "$EMAIL" ]; then
    echo "Need  email address set as EMAIL environment variable"
    exit
fi


TEMP_FILE=$(mktemp)

echo "dns_cloudflare_api_token = \"${CLOUDFLARE_TOKEN}\"" > $TEMP_FILE

/usr/local/bin/certbot certonly --non-interactive --dns-cloudflare --dns-cloudflare-credentials ${TEMP_FILE} --dns-cloudflare-propagation-seconds 60 --agree-tos --email "${EMAIL}" -d ${DOMAINS}

CERT_DIR="/etc/letsencrypt/live/${DOMAINS%%,*}"
EMBY_P12_DIR="/etc/letsencrypt/emby/"

mkdir -p ${EMBY_P12_DIR}

openssl pkcs12 -inkey "${CERT_DIR}/privkey.pem" -in "${CERT_DIR}/fullchain.pem" -export -out "${EMBY_P12_DIR}/${DOMAINS%%,*}.pfx" -passout "pass:${P12_PASSWORD}"

while true ; do
    sleep 604800
    /usr/local/bin/certbot renew --non-interactive
    openssl pkcs12 -inkey "${CERT_DIR}/privkey.pem" -in "${CERT_DIR}/fullchain.pem" -export -out "${EMBY_P12_DIR}/${DOMAINS%%,*}.pfx" -passout "pass:${P12_PASSWORD}"
done


rm ${TEMP_FILE}
