FROM certbot/certbot

ENTRYPOINT /bin/sh
ENV DOMAINS=example.com
ENV CLOUDFLARE_TOKEN=example
VOLUME /etc/letsencrypt

COPY run.sh /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]