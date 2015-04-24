FROM ubuntu:12.04
MAINTAINER Andrew Stewart, andrew.c.stewart@gmail.com

# Fetch prerequisites
RUN apt-get update
RUN apt-get install -y \
  build-essential \
  libpng-dev \
  zlib1g-dev \
  libgd2-xpm-dev \
  unzip \
  wget

# use curl instead of wget because of wget not being able to verify
# GitHub's SSL cert causing setup.sh to fail.
RUN apt-get install -y curl

# Install apache
RUN apt-get install -y apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Download jbrowse
WORKDIR /var/www
RUN wget -O JBrowse-1.11.5.zip http://jbrowse.org/wordpress/wp-content/plugins/download-monitor/download.php?id=98
RUN unzip /var/www/JBrowse-1.11.5.zip
RUN mv /var/www/JBrowse-1.11.5 /var/www/jbrowse
WORKDIR /var/www/jbrowse

RUN apt-get remove -y wget

# Install jbrowse
RUN ./setup.sh

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
# ENTRYPOINT ["service apache2 start"]
CMD ["-D", "FOREGROUND"]
