#!/bin/bash

HAPROXYCONFIG="/etc/haproxy"
ENTRIESDIR="$HAPROXYCONFIG/entries"
TEMPLATESDIR="$HAPROXYCONFIG/templates"
SCRIPTDEST="/usr/local/sbin"



echo "Installing HA Proxy"
sudo apt-get install -y haproxy

echo "Creating config directories in /etc/haproxy and populate them"
sudo mkdir -p $ENTRIESDIR
sudo mkdir -p $TEMPLATESDIR
sudo cp templates/* $TEMPLATESDIR/
sudo cp entries/sample.entry-rename_me  $ENTRIESDIR/
sudo chown -R root:root $TEMPLATESDIR
sudo chown -R root:root $ENTRIESDIR

echo "Create a backup of the current haproxy config to /etc/haproxy/haproxy.cfg_org"
sudo cp "$HAPROXYCONFIG/haproxy.cfg" "$HAPROXYCONFIG/haproxy.cfg_org"

sudo cp haproxy_genconfig.sh "$SCRIPTDEST/"
sudo chown root:root "$SCRIPTDEST/haproxy_genconfig.sh"
sudo chmod 755 "$SCRIPTDEST/haproxy_genconfig.sh"

echo "Copied the generation script to $SCRIPTDEST/haproxy_genconfig.sh"
echo "Now create some configs in $ENTRIESDIR and then run haproxy_genconfig.sh"
