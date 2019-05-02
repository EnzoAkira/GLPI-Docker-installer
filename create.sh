#!/bin/bash
set -ex

if [ -z "$1" ]
 then
    echo "No argument supplied"
    exit 1
fi

echo 'Introduce a password for Database'
read -sp 'Password Db: ' passvar

rm -rf glpi
rm -rf fusioninventory

git clone -b 9.4/gocontact --single-branch https://github.com/EnzoAkira/glpi

git clone -b go-contact --single-branch https://github.com/EnzoAkira/fusioninventory-for-glpi fusioninventory

rm -rf glpi/.git glpi/install/install.php glpi/.atoum.php glpi/.circleci glpi/*.yml glpi/.tx glpi/tools glpi/tests glpi/composer.json glpi/composer.lock
rm -rf fusioninventory/.git fusioninventory/composer.json fusioninventory/*.yml fusioninventory/tools fusioninventory/screenshots fusioninventory/phpunit fusioninventory/.tx

sed -i -e "s/Change-me/$passvar/" ./config_db.php

docker build -t enzoakira/glpi:$1 .
docker push enzoakira/glpi:$1