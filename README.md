# IPv4TOIPv6
Set of scripts for creating HAProxy configs for a IPv4TOIPv6 GW

HAProxy is then used for forwarding (on TCP layer) the traffic to the destinationserver via IPv6.
HAProxy is configured that connections via ipv4 and ipv6 are accepted and forwarded.
Because TCP is used the ssl connection will not terminate in the proxy --> end2end security from the browser to the fileserver is obtained. Using the sni extension in HAProxy still different domain names can be forwarded to different servers (both encrypted and unencrypted).


Installation
------------
* clone this repository
* if you are on a ubuntu or debian based system: run the install_debian.sh script
* afterwards copy the file sample.entry-rename_me in the entries directory to something myserver.entry and edit it. The config files need to end with ".entry"


Config / entry files
--------------------
```
name="CONFIGNAME"                                     #name in the config to be used, must be unique in all files
url="blog.myblog.de"                                  #the full dns name
ipv6="2004:a21:abc:def:ba27:aaaa:bbbb:cccc"           #the IPv6 adress 
unencrypted=true                                      #true|false create a port 80 forward?
ssl=true                                              #true|false create a port 443 forward?
maxconn=5                                             #max numer of connection to the server
```

A sample of the resulting config can be found here: https://github.com/bdynamic/IPv4TOIPv6/blob/master/docu/example_result_haproxy.cfg

Links
-----
I used the following resouces in creating this project:
* How to create your own cert agency and certificates: https://legacy.thomas-leister.de/eine-eigene-openssl-ca-erstellen-und-zertifikate-ausstellen/
* How to bind HAProxy to all interface on ipv6 AND ipv4: https://serverfault.com/questions/747895/bind-to-all-interfaces-for-ipv4-and-ipv6-in-haproxy (Hint: bind :::80 v4v6)
* HA Proxy and virtual domains: http://badberg-online.com/2017/05/01/haproxy-mit-mehreren-domains-und-ssl/

The following compenion project of mine can be used for updating the IPv6 adress on change (based on the myfritz service)
* https://github.com/bdynamic/ipV6moni