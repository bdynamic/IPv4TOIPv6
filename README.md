# IPv4TOIPv6
Set of scripts for creating HAProxy configs for a IPv4TOIPv6 GW

haproxy is then used for forwarding (on TCP layer) the traffic to the destinationserver via IPv6
haproxy is configured that connections via ipv4 and ipv6 are accepted and forwarded.
because TCP is used the ssl connection will not terminate in the proxy --> end2end security from the browser to the fileserver is obtained. Using the sni extension in haproxy still different domain names can be forwarded to different servers.


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



Links
-----
I used the following resouces in creating this project:
* How to create your own cert agency and certificates: https://legacy.thomas-leister.de/eine-eigene-openssl-ca-erstellen-und-zertifikate-ausstellen/
* How to bind haproxy to all interface on ipv6 AND ipv4: https://serverfault.com/questions/747895/bind-to-all-interfaces-for-ipv4-and-ipv6-in-haproxy (Hint: bind :::80 v4v6)
* HA Proxy and virtual domains: http://badberg-online.com/2017/05/01/haproxy-mit-mehreren-domains-und-ssl/
