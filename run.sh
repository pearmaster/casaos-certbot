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

/usr/local/bin/certbot certonly --non-interactive --dns-cloudflare --dns-cloudflare-credentials ${TEMP_FILE} --agree-tos --email "${EMAIL}" -d ${DOMAINS}

while true ; do
    sleep 604800
    /usr/local/bin/certbot renew --non-interactive
done


rm ${TEMP_FILE}
