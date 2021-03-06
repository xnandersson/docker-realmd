Docker Realmd is an implementation of realmd in Docker.

Prerequisites:

 * An Active Directory Domain controller. docker-realmd has been tested with docker-dc [1]

Quick Howto:

 * Set up a docker-dc as per [1], and make a note of your ip address. (sudo docker inspect dc | grep IPAddress)
 * Modify the contents of krb5-config.debconf to reflect your domain. Defaults are for docker-dc
 * Build the image. (./realmd.build)
 * Modify the realmd.run so --dns= reflect the ip to your AD-server.
 * Run it (./realmd.run). Your client is automatically provisioned.
 * Thats it. Nothing more to it.

Quirks:

 * The bashrc script is needed, because dbus-daemon needs to be started in order 
   for realmd to be able to do it's job. There is a directory /var/run/dbus created 
   in the Dockerfile for the very same reason.
 * Packagekit is needed due to a bug in aptdaemon in Ubuntu. Without it your packages
   won't resolve correctly.

[1] https://github.com/xnandersson/docker-dc
