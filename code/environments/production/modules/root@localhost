#!/bin/sh
echo Enter module name:
read module
cd /etc/puppetlabs/code/environments/production/modules
mkdir $module
cd $module
mkdir manifests
mkdir tests
mkdir files

echo 'class '$module'{' >> manifests/init.pp
echo '}' >> manifests/init.pp
echo 'include '$module >> tests/init.pp
