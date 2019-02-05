#!/bin/bash
set -ex

if [ -z "$1" ]
 then
    echo "No argument supplied"
    exit 1
fi

rm -rf glpi
rm -rf fusioninventory

git clone https://github.com/EnzoAkira/glpi

git clone https://github.com/EnzoAkira/fusioninventory-for-glpi fusioninventory

rm -rf glpi/.git glpi/install/install.php glpi/.atoum.php glpi/.circleci glpi/*.yml glpi/.tx glpi/tools glpi/tests glpi/
rm -rf fusioninventory/.git fusioninventory/composer.json fusioninventory/*.yml fusioninventory/tools fusioninventory/screenshots fusioninventory/phpunit fusioninventory/.tx

docker build -t enzoakira/glpi:$1 .
docker push enzoakira/glpi:$1
