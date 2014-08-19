FROM ubuntu:trusty
MAINTAINER Niklas Andersson <niklas.andersson@openforce.se>
ENV REFRESHED_AT 2014-08-18
RUN apt-get update -qq
ADD realmd.conf /etc/realmd.conf
ADD krb5-config.debconf /tmp/krb5-config.debconf
RUN debconf-set-selections /tmp/krb5-config.debconf
RUN apt-get install packagekit realmd samba-common-bin sssd-tools adcli krb5-user -y
RUN mkdir /var/run/dbus
ADD bashrc /.bashrc
