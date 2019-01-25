FROM nginx:latest

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

COPY ./nginx.conf /etc/nginx/conf.d/default.template
COPY ./start /usr/bin/docker-nginx-start

RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --fix-missing --no-install-recommends \
            openssl \
    &&  apt-get clean -y && apt-get clean -y && apt-get autoclean -y && rm -r /var/lib/apt/lists/* \
    &&  chmod +x /usr/bin/docker-nginx-start \
    &&  mkdir -p /etc/nginx/ssl

EXPOSE 80
EXPOSE 443

VOLUME /etc/nginx/ssl /var/log/nginx

CMD /usr/bin/docker-nginx-start