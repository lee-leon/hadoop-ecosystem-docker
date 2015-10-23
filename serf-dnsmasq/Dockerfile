# Creates a base ubuntu image with serf and dnsmasq
FROM ubuntu:15.04

MAINTAINER Leon Lee <lee.leon0519@gmail.com>

RUN apt-get update && \
apt-get install -y unzip curl dnsmasq net-tools iputils-ping vim

# dnsmasq configuration 
ADD dnsmasq/* /etc/

# Download and install serf-0.6.4 Linux 64-bit binary 
RUN curl -Lso serf.zip  https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip && \
unzip serf.zip -d /bin && \
rm serf.zip

# configure serf
ENV SERF_CONFIG_DIR /etc/serf
ADD serf/* $SERF_CONFIG_DIR/
ADD handlers $SERF_CONFIG_DIR/handlers
RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh
