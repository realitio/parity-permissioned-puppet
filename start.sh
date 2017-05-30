#!/bin/bash

apt-get install puppet
puppet module install puppetlabs-stdlib --version 4.17.0

sudo puppet apply manifests/init.pp --modulepath modules/:/etc/puppet/modules

echo ""
echo "-----------------------------------------------------------------------"
echo "This should run once and fail because it does not have the keys."
echo "You should then copy the keys to"
echo "/home/parity/zenchain/keys/ZenChain"
echo "...and the password to "
echo "/home/parity/zenchain/user.pwds"
echo "-----------------------------------------------------------------------"
