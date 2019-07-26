#!/bin/bash
set -e

if [ -z "$1" ]
 then
    echo "No argument supplied"
    exit 1
fi

echo "Introduce a password for Database"
read -sp 'Password Db: ' passvar

if [ -z "$passvar" ]
 then
    echo "No argument supplied, default will be used"
    passvar = admin
    sed -i -e "s/SOMEPASS/$passvar/" ./docker-compose.yml
 else
    sed -i -e "s/SOMEPASS/$passvar/" ./docker-compose.yml
fi

echo "Removing old glpi & fusioninventory"
rm -rf glpi
rm -rf fusioninventory

echo "Cloning repos"
git clone -b 9.4/gocontact --single-branch https://github.com/EnzoAkira/glpi

git clone -b go-contact --single-branch https://github.com/EnzoAkira/fusioninventory-for-glpi fusioninventory

echo "Cleaning Folders"
rm -rf glpi/.git glpi/.atoum.php glpi/.circleci glpi/*.yml glpi/.tx glpi/tools glpi/tests glpi/bin
rm -rf fusioninventory/.git fusioninventory/composer.json fusioninventory/*.yml fusioninventory/tools fusioninventory/screenshots fusioninventory/phpunit fusioninventory/.tx

echo "Rename install file"
mv glpi/install/install.php glpi/install/install.php.bak

echo "Modifying Db password"
sed -i -e "s/Change-me/$passvar/" ./config/config_db.php

echo "Building docker image"
docker build -t enzoakira/glpi:$1 .
docker push enzoakira/glpi:$1