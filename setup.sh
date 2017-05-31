#!/bin/bash

if [ "$1" != "noparity" ]
then

	if [ ! -f "./modules/parity/files/secrets/account0" ]; then
	   echo "Key file not found. Key file should be copied here manually, it is not managed by puppet."
	   echo "Please create a key as modules/parity/files/secrets/account0 and save its password in a file modules/parity/files/secrets/user.pwds"
	   exit 1
	fi

	if [ ! -f "./modules/parity/files/secrets/user.pwds" ]; then
	   echo "Please save your keys's password in a file modules/parity/files/secrets/user.pwds"
	   exit 1
	fi
fi


apt-get install puppet
puppet module install puppetlabs-stdlib --version 4.17.0

sudo puppet apply manifests/init.pp --modulepath modules/:/etc/puppet/modules


if [ "$1" != "noparity" ]
then
	echo "..."
	sleep 3

	echo "Add to reserved-peers.txt on all nodes:"
	grep 'Public node URL: enode' /var/log/syslog | perl -ne 'if ($_=~/.*?(enode:\/\/.*?:30300)/) { print "$1\n" } ' | tail -n1
fi


# The following from pssh will update all nodes via the current puppet manifest
# pssh -h nodes-pssh.conf -l ubuntu -i "cd parity-permissioned-puppet && git pull && sudo puppet apply manifests/init.pp --modulepath modules/:/etc/puppet/modules"

# The following deploys the build directory after truffle build to the public webserver
#  rsync -avz --delete build/ ubuntu@59.106.213.49:/var/www/html/ 
# This assumes you logged into the build box (zen-tokyo-4) with key forwarding, and you have a key to log into the web server box
