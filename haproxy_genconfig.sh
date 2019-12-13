#!/bin/bash
#Pubished under GNU GENERAL PUBLIC LICENSE 3., Author: Birk Bremer
#Project source: https://github.com/bdynamic/IPv4TOIPv6

TEMPLATEPATH="<templates>"                #normally /etc/haproxy/templates
ENTRYSPATH="<entries>"                    #normally /etc/haproxy/entries
DSTCONFIG="<configfile>"                  #normally /etc/haproxy/haproxy.cfg


#generate absolut paths
TEMPLATEPATH="$(realpath $TEMPLATEPATH)"
ENTRYSPATH="$(realpath $ENTRYSPATH)"
DSTCONFIG="$(realpath $DSTCONFIG)"


echo "Writing config to $DSTCONFIG"
cat "$TEMPLATEPATH/global.template" >"$DSTCONFIG"
cat "$TEMPLATEPATH/defaults.template" >>"$DSTCONFIG"
cat "$TEMPLATEPATH/frontend_start.template" >>"$DSTCONFIG"



## Generation of frontend entries
for VALUE in $(ls -1 $ENTRYSPATH/*.entry)
do 
   #echo "Generting frontend entry for $VALUE"
   source "$VALUE"
   echo "Generating frontend entry for: $name"
   echo "   ### $name ">>"$DSTCONFIG"
   if [ $unencrypted == true ]; then
   	 #echo "Create unencrypted entry"
   	 cat "$TEMPLATEPATH/frontend_entry.template" | sed "s/<name>/$name/g" | sed "s/<url>/$url/g" >>"$DSTCONFIG"
   	 echo "" >>"$DSTCONFIG"
   fi

  if [ $ssl == true ]; then
   	 #echo "Create encrypted entry"
   	 cat "$TEMPLATEPATH/frontend_ssl_entry.template" | sed "s/<name>/$name/g" | sed "s/<url>/$url/g" >>"$DSTCONFIG"
   	 echo "" >>"$DSTCONFIG"
  fi

  echo ""
  echo "" >>"$DSTCONFIG"
done



## Generation of backend entries
for VALUE in $(ls -1 $ENTRYSPATH/*.entry)
do 
   #echo "Generting backend entry for $VALUE"
   source "$VALUE"
   echo "Generating backend entry for: $name"

   if [ $unencrypted == true ]; then
   	 echo "Create unencrypted entry"
   	 cat "$TEMPLATEPATH/backend_entry.template" | sed "s/<name>/$name/g" | sed "s/<ipv6>/$ipv6/g" >>"$DSTCONFIG"
   	 echo "" >>"$DSTCONFIG"
   fi

  if [ $ssl == true ]; then
   	 echo "Create encrypted entry"
   	 cat "$TEMPLATEPATH/backend_ssl_entry.template" | sed "s/<name>/$name/g" | sed "s/<ipv6>/$ipv6/g" >>"$DSTCONFIG"
   	 echo "" >>"$DSTCONFIG"
  fi

  echo ""
  echo "" >>"$DSTCONFIG"
done


exit 0