dbus-daemon --system --fork
echo Secret007! | kinit Administrator@OPENFORCE.ORG
#realm -v join openforce.org --membership-software=samba --client-software=sssd --user-principal=host/realmd@OPENFORCE.ORG
realm -v join openforce.org
