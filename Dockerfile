FROM certbot/certbot

ENTRYPOINT /bin/sh
ENV DOMAINS
ENV CLOUDFLARE_TOKEN
VOLUME CERTPATH

COPY run.sh /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]