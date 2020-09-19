FROM ubuntu:xenial

ARG runalyze_web_app_config

RUN apt-get update && apt-get -y install apt-utils

RUN apt-get install -y apache2 \
        libapache2-mod-php7.0 \
        php7.0-intl \
        php7.0-mysql \
        php7.0-sqlite3 \
        php7.0-mbstring \
        php7.0-xml \
        php7.0-curl \
        php7.0-zip \
        php7.0-gettext \
        php7.0-intl \
        perl \
        sqlite3 \
        libsqlite3-mod-spatialite \
        gettext \
        libxml2 \
        python3 \
        python3-pip \
        inkscape \
        librsvg2-bin \
        librsvg2-common \
        locales

RUN sed -i -e 's/# \(en_GB\.UTF-8 .*\)/\1/' /etc/locale.gen
RUN touch /usr/share/locale/locale.alias
RUN locale-gen

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

COPY data/config/php.ini /etc/php/7.0/apache2/

RUN mkdir -p /app
WORKDIR /app
ADD data/version/runalyze.tar.gz .
WORKDIR /app/runalyze

ADD data/timezone.sqlite.tar.gz ./data/
COPY data/srtm/* ./data/srtm/

COPY data/config/${runalyze_web_app_config} ./data/config.yml

RUN cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/defaultBack
COPY data/config/apacheDefaultSite /etc/apache2/sites-enabled/000-default.conf
COPY data/config/apache2.conf /etc/apache2/apache2.conf

RUN a2enmod rewrite

CMD ["/usr/sbin/apache2ctl", "-D FOREGROUND"]
