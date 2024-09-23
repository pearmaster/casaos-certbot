FROM certbot/certbot

ENTRYPOINT []

RUN pip3 install certbot-dns-cloudflare

COPY run.sh /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]