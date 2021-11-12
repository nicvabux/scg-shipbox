#!/bin/bash

# this targets v21_04

# Note that CUPS install is not needed, IoT uses it as well...
# Same with NGINX

set -x
# run as root (e.g. sudo -s first)
mount -o remount,rw /  && mount -o remount,rw /root_bypass_ramdisks/ \
  && mount --bind /root_bypass_ramdisks/etc /etc \
  && mount --bind /root_bypass_ramdisks/var /var

# python requirements for hw_scale_usb
pip3 install pyusb==1.2.1

# Nginx
sed -i 's/access_log .*;/access_log off;/' /etc/nginx/nginx.conf
mkdir /etc/nginx/ssl

cat > /etc/nginx/ssl/server.crt << EndOfMessage
#
EndOfMessage

cat > /etc/nginx/ssl/server.key << EndOfMessage
#
EndOfMessage

cat > /etc/nginx/sites-enabled/default << EndOfMessage
server {
    listen 443 ssl http2 default_server;
    listen [::]:443 ssl http2 default_server;

    server_name localhost;

    # Replace Certs if you have them.
    # ssl_certificate /etc/nginx/ssl/server.crt;
    # ssl_certificate_key /etc/nginx/ssl/server.key;
    ssl_certificate /etc/ssl/certs/nginx-cert.crt;
    ssl_certificate_key /etc/ssl/private/nginx-cert.key;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
     proxy_read_timeout 600s;
     proxy_pass http://127.0.0.1:8069;
    }
}

server {
       listen 80;

       root /var/www/;
       index index.html;

       location /hw_drivers/ {
            proxy_pass http://127.0.0.1:8069;
       }
}
EndOfMessage

# GIT ShipBox Deploy
cd /home/pi
git clone https://gitlab.com/hibou-io/hibou-odoo/hiboubox.git -b master ./hiboubox
cd /home/pi/odoo/addons/

# find ../../hiboubox/ -name 'hw_*' -type d -exec ln -s {} . \;

# Only Link Drives you want!
# CUPS is our printer server
ln -s ../../hiboubox/hw_cups .

# USB Scale requires more modifications
ln -s ../../hiboubox/hw_scale_usb .
# the SerialScaleDriver can/will probe and crash the USB Scale Driver
mv /home/pi/odoo/addons/hw_drivers/iot_handlers/drivers/SerialScaleDriver.py /home/pi/SerialScaleDriver.py
# the KeyboardUSBDriver can get tripped up by USB Scales (e.g. has no attribute input_device)
mv /home/pi/odoo/addons/hw_drivers/iot_handlers/drivers/KeyboardUSBDriver.py /home/pi/KeyboardUSBDriver.py

rm -rf /var/cache/*

sync && sleep 10 && reboot
