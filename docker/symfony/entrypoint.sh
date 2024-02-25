#check if the dir /var/www/html/vendor exits
echo "Checking if the directory /var/www/html/vendor exists"
if [ ! -d "/var/www/html/vendor" ]; then
  echo "Directory /var/www/html/vendor does not exist."
  symfony new /var/www/html/temp

  mv /var/www/html/temp/* /var/www/html/
  mv /var/www/html/temp/.gitignore ./.gitignore
  mv /var/www/html/temp/.env ./.env
  rm -rf /var/www/html/temp

  composer require symfony/orm-pack
  composer require --dev symfony/maker-bundle
else
  echo "Directory /var/www/html/vendor exists."
fi

cd /var/www/html
#start the server
symfony server:start --no-tls --allow-http
