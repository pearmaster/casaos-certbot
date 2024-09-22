#!/bin/sh

if [ -z "$DOMAINS" ]; then
    echo "Need domain list set as DOMAINS environment variable, comma separated"
    exit
fi

/usr/local/bin/certbot run --dry-run -d ${DOMAINS}