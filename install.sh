#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
echo Installing requirements.
apt-get install -y wget
#useradd -M -s /usr/sbin/nologin antitheft
mkdir /tmp/simple-antitheft
#chown -R antitheft:antitheft /tmp/simple-antitheft
chmod 777 /tmp/simple-antitheft
chmod +x /usr/bin/simple-antitheft
echo "Enter token:"
read t
echo "Enter url:"
read u
touch /usr/bin/simple-antitheft
echo "#!/bin/bash" > /usr/bin/simple-antitheft
echo 'wget "'$t'" -O /tmp/simple-antitheft/simple-antitheft.tmp' >> /usr/bin/simple-antitheft
echo 'cat /tmp/simple-antitheft/simple-antitheft.tmp >> /tmp/simple-antitheft/simple-antitheft.log' >> /usr/bin/simple-antitheft
echo 'date >> /tmp/simple-antitheft/simple-antitheft.log' >> /usr/bin/simple-antitheft
echo 'host '$u' >> /tmp/simple-antitheft/simple-antitheft.log' >> /usr/bin/simple-antitheft
echo 'rm /tmp/simple-antitheft/simple-antitheft.tmp' >> /usr/bin/simple-antitheft
chmod +x /usr/bin/simple-antitheft
echo "* *    * * *   root    /usr/bin/simple-antitheft-core" >> /etc/crontab
systemctl start cron
systemctl restart cron
systemctl enable cron
