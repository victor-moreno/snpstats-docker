FROM artemklevtsov/r-alpine:release

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# use old version of haplo.stats to keep code working
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/haplo.stats/haplo.stats_1.6.11.tar.gz')"
RUN Rscript -e "install.packages('genetics', repo='https://cloud.r-project.org/')"

RUN rm -rf /tmp/*

# Setup apache and php
RUN apk --update add apache2 php5-apache2 curl \
    php5-json php5-phar php5-openssl php5-curl php5-mcrypt php5-ctype php5-gd php5-xml php5-dom ghostscript mc \
    && rm -f /var/cache/apk/* \
    && mkdir /run/apache2 \
    && mkdir -p /opt/utils

EXPOSE 80

ADD start.sh /opt/utils/

RUN chmod +x /opt/utils/start.sh

ADD snpstats.tar.gz /app/
ENV WEBAPP_ROOT snpstats

# php.ini needs modification: increase max_input_vars
RUN cp /app/snpstats/php/php.ini /etc/php5/php.ini

ENTRYPOINT ["/opt/utils/start.sh"]

