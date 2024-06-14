
# Set URLs and file paths
repoLink="https://github.com/rocket-ap/rocket-ssh/raw/master/app.zip"

originalEnvFile="/var/www/html/panel/.env"
pathDir="/var/www/html"

# Banner Path
bannerPath="/var/www/html/panel/banner.txt"

if [ ! -e "$bannerPath" ]; then
    touch "$bannerPath"
    echo "Banner file created: $bannerPath"
else
    echo "Banner file already exists: $bannerPath"
fi

# Backup original .env file contents to a variable
originalEnvContent=$(cat "$originalEnvFile")

# Download PHP code zip file
sudo wget -O /var/www/html/update.zip $repoLink

# # Extract PHP code
sudo unzip -o /var/www/html/update.zip -d $pathDir
wait
# # Restore original .env file contents
echo "$originalEnvContent" > "$originalEnvFile"

sudo chown -R www-data:www-data /var/www/html/panel
wait
chown www-data:www-data /var/www/html/panel/index.php
wait
sudo chown -R www-data:www-data /var/www/html/account
wait
chown www-data:www-data /var/www/html/account/index.php
wait
chown www-data:www-data /var/www/html/index.php
wait
sudo systemctl stop cron
wait
rm /tmp/call_url.lock
wait
pkill -f /var/www/html/cronjob.sh 
wait
sudo systemctl start cron
wait
clear
echo "PHP code updated and .env content restored."
