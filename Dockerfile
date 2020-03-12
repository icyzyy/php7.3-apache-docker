FROM debian:buster

RUN apt update && \
    apt -y install apache2 php php-cli php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-curl \
    php7.3-dba php7.3-dev php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap \
    php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql \
    php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-phpdbg php7.3-pspell php7.3-readline \
    php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy \
    php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip nano telnet supervisor curl

RUN mkdir -p /var/www/html/ && \
    echo "<?php phpinfo();" > /var/www/html/index.php

WORKDIR /var/www/html

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
EXPOSE 8080

RUN a2enmod rewrite

CMD /etc/init.d/apache2 start && tail -f /var/log/apache2/access.log
