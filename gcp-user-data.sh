#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
wget -O /var/www/html/index.html ${s3bucket}
sed -i 's/host/GCP/g' /var/www/html/index.html
