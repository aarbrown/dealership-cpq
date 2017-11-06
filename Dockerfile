#####################################################
#
#   Name: base container for puppet tests
#   Author: Michael Haught
#
#####################################################

FROM ubuntu:16.04
MAINTAINER Michael Haught

# handle the basics
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install locales build-essential libpng-dev libxml2 rubygems ruby-dev gcc libffi-dev make git puppet wget

RUN wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip
RUN unzip pmd-bin-5.8.1.zip
RUN cp pmd-bin-5.8.1/bin/run.sh run.sh
