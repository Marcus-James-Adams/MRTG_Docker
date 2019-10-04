FROM nginx:stable-alpine-perl
RUN apk add --no-cache net-snmp \
	&& apk add --no-cache mrtg \
	&& apk add --no-cache nano \
    && mkdir -p /etc/mrtg
COPY content /usr/share/nginx/html
COPY nginx_conf /etc/nginx
COPY mrtg_conf /etc/mrtg
VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
VOLUME /etc/mrtg
RUN cfgmaker --global 'WorkDir: /usr/share/nginx/html' --output /etc/mrtg/mrtg.cfg public@localhost
RUN indexmaker --output=/var/www/html/index.html /etc/mrtg/mrtg.cfg
WORKDIR /usr/share/nginx/html
