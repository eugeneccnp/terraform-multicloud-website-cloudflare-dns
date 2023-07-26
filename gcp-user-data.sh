#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
#echo "<h1>MultiCloud Demo Google Cloud</h1>" | sudo tee /var/www/html/index.html
wget -O /var/www/html/pray_gcp.png https://terraform-multicloud-website-cloudflare-dns-bucket.s3.ca-central-1.amazonaws.com/pray_gcp.png
echo '<!DOCTYPE html>
<html>
<head>
    <title>Pray to Google Gods</title>
</head>
<body>
    <img src="pray_gcp.png">
</body>
</html>' | sudo tee /var/www/html/index.html