mv docker-compose.yml ./docker-compose.save.yml
if [ ! -f "/var/www/html/composer.json" ]; then
  echo "Creating new symfony app..."
  composer create-project symfony/skeleton /temp/var/www/html
  cd /temp/var/www/html

  #dependencies
  echo "Installing symfony dependencies..."
  composer require symfony/orm-pack symfony/security-bundle symfony/validator  symfony/serializer twig/twig
  composer require symfony/debug-bundle symfony/maker-bundle doctrine/doctrine-fixtures-bundle --dev

  #remove docker-compose files created by orm-pack
  rm compose.yaml
  rm compose.override.yaml

  cd /var/www/html

  mv /temp/var/www/html/* /var/www/html/
  mv /temp/var/www/html/.gitignore /var/www/html/.gitignore
  mv /temp/var/www/html/.env /var/www/html/.env
else
  echo "Symfony app already exists."
fi

composer install
rm docker-compose.yml
mv ./docker-compose.save.yml docker-compose.yml