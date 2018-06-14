FROM php:7.1.18-fpm-alpine3.7

RUN apk add --update --no-cache gcc libc-dev autoconf make libpng-dev libmcrypt-dev libmemcached-dev \
  && docker-php-ext-install gd mcrypt pdo_mysql \
  && printf "\n" | pecl install memcached \
  && docker-php-ext-enable memcached \
  && pecl install xdebug \
  && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
  && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$version \
  && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
  && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
  && docker-php-ext-enable blackfire

COPY ["./usr/local/etc/php-fpm.conf", "/usr/local/etc/php-fpm.conf"]
COPY ["./usr/local/etc/php/conf.d/*", "/usr/local/etc/php/conf.d/"]
COPY ["./opt/*", "/opt/"]

CMD  ["/opt/docker-startup.sh"]
