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
-----BEGIN CERTIFICATE-----
MIIF1jCCBL6gAwIBAgIRAJBSAAdhGhQKeqMCmjtfY+UwDQYJKoZIhvcNAQELBQAw
gY8xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE3MDUGA1UE
AxMuU2VjdGlnbyBSU0EgRG9tYWluIFZhbGlkYXRpb24gU2VjdXJlIFNlcnZlciBD
QTAeFw0yMTA0MDEwMDAwMDBaFw0yMjA0MDUyMzU5NTlaMCIxIDAeBgNVBAMMFyou
c2VhdHRsZWNvZmZlZWdlYXIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA+ywtq+8I/3bR0i6whObCrVLGamgBzYqdzPyA6UDhwI9rdHQ24Vg5clnM
yzBeOl1zGtsTuiC7cSwX9HyBJqo2sxqCH0l+z7tOWuITwahT1n0goe4pVU60rpPD
QlltEnESXXr6McSMwMHjkUpUXldMvp56pqPyeMFEd6AyPlKwzPKnYsVg5tWuH562
w4r/c+l1qDqn8dH3CahCbSqLazugdkfQkpKExd04BPhdK5d58Eb55N2DTqDzKZ+2
IZjeXab8oZtKKEdHrW2IsLqO43C9HGi7s2ENG+mXzKyt2vFfYMYQSF01E/cgzmAD
qUXDcDaBPbS3x/iFQFkWfFTV34rwVwIDAQABo4IClzCCApMwHwYDVR0jBBgwFoAU
jYxexFStiuF36Zv5mwXhuAGNYeEwHQYDVR0OBBYEFK7r6rzUJDXWihPZHduI7yVy
WBwlMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsG
AQUFBwMBBggrBgEFBQcDAjBJBgNVHSAEQjBAMDQGCysGAQQBsjEBAgIHMCUwIwYI
KwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMAgGBmeBDAECATCBhAYI
KwYBBQUHAQEEeDB2ME8GCCsGAQUFBzAChkNodHRwOi8vY3J0LnNlY3RpZ28uY29t
L1NlY3RpZ29SU0FEb21haW5WYWxpZGF0aW9uU2VjdXJlU2VydmVyQ0EuY3J0MCMG
CCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTA5BgNVHREEMjAwghcq
LnNlYXR0bGVjb2ZmZWVnZWFyLmNvbYIVc2VhdHRsZWNvZmZlZWdlYXIuY29tMIIB
BQYKKwYBBAHWeQIEAgSB9gSB8wDxAHYARqVV63X6kSAwtaKJafTzfREsQXS+/Um4
havy/HD+bUcAAAF4jl/pkAAABAMARzBFAiEAjH9iZslRPJkLxtPSzi11yasSupcA
iKgffYExJI/O14oCIAipLOeyK3+cadG7baYZQ9dfCY6XQsIuOJo4Bcybq7+SAHcA
36Veq2iCTx9sre64X04+WurNohKkal6OOxLAIERcKnMAAAF4jl/pcgAABAMASDBG
AiEA+oW1a8S5MVbbxlcWAaRgFYA7iQae1EVlymODVgsCZMYCIQDPMd/8l8voiO/k
ThqyXltY7/oNmRshYY3T4QqMnSqMRTANBgkqhkiG9w0BAQsFAAOCAQEADW7eI6OB
h0PTINNXEPiZTXYurE0piIzKrVr0CuCLZm8ocZqPeKvP7njLHMdPyL6EYisH1W9j
Js4ikM1Vw1Z3yQE5QvI9pCbPdCf84hXsjCbRowPR1QHZlFkmYixZpKIAdk5QE6Bj
5zuq4Y1SBJsaDuDkqV8fEUcmClyynIk048vMMV3Dh2U/BiS5iUQzgdIrDufPi4c5
hRdj3SHS4xJ0YJ+DLQMfS5hZIj9MCCsVud8y+pfq2nxm8iE1I7OzQfLGVYA1opum
A391S3BxbfZ9O4UwdndbPODFbGi8AZxDWpaFbIYS6lYS3DKFqaYh41FuoiNwGDAA
R7LgWy3KitTz6g==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIGEzCCA/ugAwIBAgIQfVtRJrR2uhHbdBYLvFMNpzANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0pl
cnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNV
BAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgx
MTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBjzELMAkGA1UEBhMCR0IxGzAZBgNV
BAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UE
ChMPU2VjdGlnbyBMaW1pdGVkMTcwNQYDVQQDEy5TZWN0aWdvIFJTQSBEb21haW4g
VmFsaWRhdGlvbiBTZWN1cmUgU2VydmVyIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA1nMz1tc8INAA0hdFuNY+B6I/x0HuMjDJsGz99J/LEpgPLT+N
TQEMgg8Xf2Iu6bhIefsWg06t1zIlk7cHv7lQP6lMw0Aq6Tn/2YHKHxYyQdqAJrkj
eocgHuP/IJo8lURvh3UGkEC0MpMWCRAIIz7S3YcPb11RFGoKacVPAXJpz9OTTG0E
oKMbgn6xmrntxZ7FN3ifmgg0+1YuWMQJDgZkW7w33PGfKGioVrCSo1yfu4iYCBsk
Haswha6vsC6eep3BwEIc4gLw6uBK0u+QDrTBQBbwb4VCSmT3pDCg/r8uoydajotY
uK3DGReEY+1vVv2Dy2A0xHS+5p3b4eTlygxfFQIDAQABo4IBbjCCAWowHwYDVR0j
BBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFI2MXsRUrYrhd+mb
+ZsF4bgBjWHhMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAbBgNVHSAEFDASMAYGBFUdIAAw
CAYGZ4EMAQIBMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0
LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2Bggr
BgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDov
L29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAMr9hvQ5Iw0/H
ukdN+Jx4GQHcEx2Ab/zDcLRSmjEzmldS+zGea6TvVKqJjUAXaPgREHzSyrHxVYbH
7rM2kYb2OVG/Rr8PoLq0935JxCo2F57kaDl6r5ROVm+yezu/Coa9zcV3HAO4OLGi
H19+24rcRki2aArPsrW04jTkZ6k4Zgle0rj8nSg6F0AnwnJOKf0hPHzPE/uWLMUx
RP0T7dWbqWlod3zu4f+k+TY4CFM5ooQ0nBnzvg6s1SQ36yOoeNDT5++SR2RiOSLv
xvcRviKFxmZEJCaOEDKNyJOuB56DPi/Z+fVGjmO+wea03KbNIaiGCpXZLoUmGv38
sbZXQm2V0TP2ORQGgkE49Y9Y3IBbpNV9lXj9p5v//cWoaasm56ekBYdbqbe4oyAL
l6lFhd2zi+WJN44pDfwGF/Y4QA5C5BIG+3vzxhFoYt/jmPQT2BVPi7Fp2RBgvGQq
6jG35LWjOhSbJuMLe/0CjraZwTiXWTb2qHSihrZe68Zk6s+go/lunrotEbaGmAhY
LcmsJWTyXnW0OMGuf1pGg+pRyrbxmRE1a6Vqe8YAsOf4vmSyrcjC8azjUeqkk+B5
yOGBQMkKW+ESPMFgKuOXwIlCypTPRpgSabuY0MLTDXJLR27lk8QyKGOHQ+SwMj4K
00u/I5sUKUErmgQfky3xxzlIPK1aEn8=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7
MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4
MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5
MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBO
ZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sI
s9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnG
vDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQ
Ijy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfb
IWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97E
xwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNV
icQNwZNUMBkTrNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5
D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJSdhJ
WBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAfV1SoPv10Yy+xUGUJ
5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu6lzG
KAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSg
EQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rID
ZsswDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAG
BgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29t
L0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsGAQUFBwEBBCgwJjAkBggr
BgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUA
A4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+
rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+
/czSAaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gA
CiIDEOUMsfnNkjcZ7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1F
zZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyA
vGp4z7h/jnZymQyd/teRCBaho1+V
-----END CERTIFICATE-----
EndOfMessage

cat > /etc/nginx/ssl/server.key << EndOfMessage
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD7LC2r7wj/dtHS
LrCE5sKtUsZqaAHNip3M/IDpQOHAj2t0dDbhWDlyWczLMF46XXMa2xO6ILtxLBf0
fIEmqjazGoIfSX7Pu05a4hPBqFPWfSCh7ilVTrSuk8NCWW0ScRJdevoxxIzAweOR
SlReV0y+nnqmo/J4wUR3oDI+UrDM8qdixWDm1a4fnrbDiv9z6XWoOqfx0fcJqEJt
KotrO6B2R9CSkoTF3TgE+F0rl3nwRvnk3YNOoPMpn7YhmN5dpvyhm0ooR0etbYiw
uo7jcL0caLuzYQ0b6ZfMrK3a8V9gxhBIXTUT9yDOYAOpRcNwNoE9tLfH+IVAWRZ8
VNXfivBXAgMBAAECggEBAKa2FP5YowVE7VFvcfRUYgS+uzmnHQM7LTAArOOlD/JK
f00FUePSNhcDKZ331aMxoZPCs15IGYGtfZzmAqcSNUo9nv57PrNMpF5ITkqsmjD0
TnOMa1zW57A0HVbtmiqyaDkpxeTAi5fpWU13I3aWxTaEY+41RVwHE5W++3pIUldE
q11SvM/vQC9efBEBpTJwhawvuFZGzg95zW09kZxdZ0yoNCB/fkQLkqECWfunBIDp
leILx1uBhe/HgOBl3XybLedrqPAl2RReOJS88WwaEPsUYS/uAqs5t58XMvkBVI0O
DqTKj9qlPDrU9rOU1RWXJNHqgQIeDbYIbvZEN4k1RxkCgYEA/c+WNfi4Isbm8m6n
VVRhTcJmYKDdbbwuqPHtF0I8fICN6LIn3U/w/hmxZHjdqMa+1jLRTUslv2P7x1W4
tvKsFvokq9lNCnkaVgSa/noKXlfq4TJdCU6v2Mk6P+yunGV7mEJh4RQw4UN5jktO
XUtegBcdZLQXJA8brKZmUOfvNFsCgYEA/VbEKY4QFAtOU0MrsrcNvkEft8C7WpQU
mTLbrBHiqfumTa+zg6PjFqVKZxAqQLLlxiiNznM/ZnKZAwxEWx9W80Tah3mfc+fu
9KwOM6wuow11woOcIbz975LFKD4xEshVVCvyJ7q/F7GMEg6efMslbXwqcWmD9Yi0
bH9fCiEEhLUCgYBqilbtdOgmgQO0xEotgWwO7gl3ik8onxOfC16QotctE/F9ujsN
pV7t6u8R08KH9FVrKI2/OkowGtI3jH4rHZarVnlKQb8bJFavwOMm6yerDpCj0zZG
j+c0wtNWvg1VzSuicEsR5h3WkTJXTrkoZFjYv9swyH/mPQlK4daVI6a/fQKBgQDI
5/dW0R+1FaY+56UO7JaMi87ghYrO8WJIgAmvsttjXHttXmppeh3MRrbzduFbP8Ry
2pRi5gigcT8hKKhI71igQblf+LbYT1W0WYJFvkWZ70G1SXQXWW60gFu0Z2W5dIAe
6V733ORQoO/pHgjYBK6g3fg2yqvom0oiRPyU5sxThQKBgBSoqLqcwwkq/qtmPD0E
ij0t7KNTtTct2WhbiOCpWigPHjJ2d+3ffZ5aeCHFugEh1hdFD+H8B53NTAjYsvti
XLeu6+n83L+gq8IrQeOIsaPIunX5snUe+5vBVPifSqR/ypO1oQ/miQXibfasvkGM
mQe4PI8q0Xi4l6AA7h7oRWbK
-----END PRIVATE KEY-----
EndOfMessage

cat > /etc/nginx/sites-enabled/default << EndOfMessage
server {
    listen 443 ssl http2 default_server;
    listen [::]:443 ssl http2 default_server;

    server_name localhost;

    # Replace Certs if you have them.
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;
    # ssl_certificate /etc/ssl/certs/nginx-cert.crt;
    # ssl_certificate_key /etc/ssl/private/nginx-cert.key;

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
