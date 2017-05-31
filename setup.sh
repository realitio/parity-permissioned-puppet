#!/bin/bash

if [ ! -f "./modules/parity/files/secrets/account0" ]; then
   echo "Key file not found. Key file should be copied here manually, it is not managed by puppet."
   echo "Please create a key as modules/parity/files/secrets/account0 and save its password in a file modules/parity/files/secrets/user.pwds"
   exit 1
fi

if [ ! -f "./modules/parity/files/secrets/account0" ]; then
   echo "Please save your keys's password in a file modules/parity/files/secrets/user.pwds"
   exit 1
fi


apt-get install puppet
puppet module install puppetlabs-stdlib --version 4.17.0

sudo puppet apply manifests/init.pp --modulepath modules/:/etc/puppet/modules

echo "Add to reserved-peers.txt on all nodes:"
grep 'Public node URL: enode' /var/log/syslog | perl -ne 'if ($_=~/.*?(enode:\/\/.*?:30300)/) { print "$1\n" } ' | tail -n1

