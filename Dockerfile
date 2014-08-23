FROM ubuntu:trusty
MAINTAINER Niklas Andersson <niklas.andersson@openforce.se>
ENV REFRESHED_AT 2014-08-23-1
RUN apt-get update -qq
ADD realmd.conf /etc/realmd.conf
ADD krb5-config.debconf /tmp/krb5-config.debconf
RUN debconf-set-selections /tmp/krb5-config.debconf
RUN apt-get install packagekit realmd samba-common-bin sssd-tools adcli krb5-user openssh-server ldap-utils -y
RUN mkdir /var/run/dbus
RUN mkdir /var/run/sshd
ADD sssd.conf.openforce /etc/sssd/sssd.conf.openforce
COPY pam.d/ /etc/pam.d
ADD realmd.fg /usr/local/bin/realmd.fg
CMD /usr/local/bin/realmd.fg
