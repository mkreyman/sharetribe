FROM ubuntu:14.04
MAINTAINER Sharetribe Team <team@sharetribe.com>
RUN apt-get -yqq update

# Install RVM, Ruby, and Bundler
RUN apt-get -yqq install curl git libxml2
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.8"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Install deps
RUN apt-get -yqq install build-essential mysql-client libmysqlclient-dev libxslt-dev libxml2-dev mysql-server-5.5 nodejs sphinxsearch imagemagick
RUN /bin/bash -l -c "gem install mysql2 -v 0.2.7"

# Create directory for Sharetribe
RUN /bin/bash -l -c "mkdir -p /opt/sharetribe"
WORKDIR /opt/sharetribe

# Run Bundle install
ADD Gemfile /opt/sharetribe/Gemfile
ADD Gemfile.lock /opt/sharetribe/Gemfile.lock
RUN /bin/bash -l -c "bundle install"

EXPOSE 3000

#############
# Based on https://github.com/phusion/passenger-docker

FROM phusion/passenger-customizable:0.9.19
MAINTAINER Mark Kreyman <mark@kreyman.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Build system and git.
RUN /pd_build/utilities.sh

# Ruby support.
RUN /pd_build/ruby-2.3.*.sh

# Node.js and Meteor support.
RUN /pd_build/nodejs.sh

# Install deps
RUN apt-get -yqq install sphinxsearch imagemagick

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down

# Remove default website
RUN rm /etc/nginx/sites-enabled/default

# We don't need to add this .conf file,
# as it would be mapped in docker-compose.yml
# ADD sharetribe.conf /etc/nginx/sites-enabled/sharetribe.conf

# Create the app directory
RUN mkdir -p /home/app/sharetribe
