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
    && apt-get -y install locales build-essential libpng-dev libxml2 rubygems ruby-dev gcc libffi-dev make git default-jre wget jq
