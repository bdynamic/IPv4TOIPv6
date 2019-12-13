#!/bin/bash
#Pubished under GNU GENERAL PUBLIC LICENSE 3., Author: Birk Bremer
#Project source: https://github.com/bdynamic/IPv4TOIPv6


HAPROXYCONFIGDIR="/etc/haproxy"                #directory were haconfig is stored
HAPROXYCONFIGFILE="haproxy.cfg"
ENTRIESDIR="$HAPROXYCONFIGDIR/entries"         #directory where our individual entry configs will be stored
TEMPLATESDIR="$HAPROXYCONFIGDIR/templates"     #the templates for generating the config are stored here
SCRIPTDEST="/usr/local/sbin"                #directory where our generation script will be stored

echo "Installing HA Proxy and config creator scripts"


#lets check if we are root (or can get)
if [ $(whoami) == "root" ]; then
	echo "Ok - we are already root"
	MKDIR="mkdir"
	APTGET="apt-get"
	CP="cp"
	CHOWN="chown"
	CHMOD="chmod"
	CAT="cat"
	MV="mv"
else
	echo "We are not root - will try with sudo"
	echo "Sudo might ask for you password"
	sudo echo "ok" || exit 1
	MKDIR="sudo mkdir"
	APTGET="sudo apt-get"
	CP="sudo cp"
	CHOWN="sudo chown"
	CHMOD="sudo chmod"
	CAT="sudo cat"
	MV="sudo mv"
fi
echo ""



# installation of haproxy on a debian based system
echo "Installing haproxy"
echo "=================="
sudo $APTGET install -y haproxy
echo ""
echo ""

echo "Creating config directories in $HAPROXYCONFIGDIR and populate them"
echo "============================================================="
$MKDIR -p $ENTRIESDIR
$MKDIR -p $TEMPLATESDIR
$CP templates/* $TEMPLATESDIR/
$CP entries/sample.entry-rename_me  $ENTRIESDIR/
$CHOWN -R root:root $TEMPLATESDIR
$CHOWN -R root:root $ENTRIESDIR

echo "Create a backup of the current haproxy config to $HAPROXYCONFIGDIR/$HAPROXYCONFIGFILE.org"
$CP "$HAPROXYCONFIGDIR/$HAPROXYCONFIGFILE" "$HAPROXYCONFIGDIR/$HAPROXYCONFIGFILE.org"

TEMPLATEPATH="<templates>"                #normally /etc/haproxy/templates
ENTRYSPATH="<entries>"                    #normally /etc/haproxy/entries
DSTCONFIG="<configfile>"

cat haproxy_genconfig.sh | sed "s+<templates>+$TEMPLATESDIR+g"  | sed "s+<entries>+$ENTRIESDIR+g"  | sed "s+<configfile>+$HAPROXYCONFIGDIR/$HAPROXYCONFIGFILE+g" >/tmp/haproxy_genconfig.sh
$MV /tmp/haproxy_genconfig.sh "$SCRIPTDEST/"
$CHOWN root:root "$SCRIPTDEST/haproxy_genconfig.sh"
$CHMOD 755 "$SCRIPTDEST/haproxy_genconfig.sh"

echo "Copied the generation script to $SCRIPTDEST/haproxy_genconfig.sh"
echo ""
echo ""
echo "Now create some configs in $ENTRIESDIR and then run haproxy_genconfig.sh"

exit 0
