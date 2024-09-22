FROM certbot/certbot

ENTRYPOINT []
ENV DOMAINS=example.com
ENV CLOUDFLARE_TOKEN=example
ENV EMAIL=root@example.com
VOLUME /etc/letsencrypt

RUN pip3 install certbot-dns-cloudflare

COPY run.sh /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]