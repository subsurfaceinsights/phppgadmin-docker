FROM alpine:3.12.1
RUN apk add --no-cache \
  nginx \
  php7 \
  php7-fpm \
  php7-opcache \
  php7-pgsql \
  php7-session \
  php7-mbstring \
  supervisor
ARG PHPPGADMIN_VER=REL_7-13-0
RUN addgroup -S www && adduser -S www -G www
RUN wget \
    https://github.com/phppgadmin/phppgadmin/archive/${PHPPGADMIN_VER}.tar.gz &&\
    tar --strip-components=1 -xzf ./${PHPPGADMIN_VER}.tar.gz -C /var/lib/nginx/html && \
    mkdir /run/nginx && \
    chown -R www:www /var/lib/nginx/ /run/nginx && \
    rm -rf ./${PHPPGADMIN_VER}.tar.gz
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i "s/user nginx;/user www;/g" /etc/nginx/nginx.conf && \
    sed -i "s/nobody/www/g" /etc/php7/php-fpm.d/www.conf
COPY config.inc.php /var/lib/nginx/html/conf
COPY docker-entrypoint.sh .
EXPOSE 80 443
CMD [ "./docker-entrypoint.sh" ]


