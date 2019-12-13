Hints
======

This proxy only makes sense if the proxy destination has a stable IPv6 Adress...
Well thats obvious. This can be achieved in the foolowing way


When using the NetworkManger
----------------------------
* edit your network interface in /etc/NetworkManager/system-connections/
* Add this section:
```
[ipv6]
   dns-search=
   method=auto
   addr-gen-mode=eui64
```