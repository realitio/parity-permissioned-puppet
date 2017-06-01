This sets up nodes in a parity private network, running in systemd. It is intended for our particular application and will need to be customized or generalized to use on anything else. The name of the network is hard-coded, as are various other parameters including validator addresses.

To set up a node, we run
`sudo ./setup.sh [noparity]`

It assumes you have generated the validator keys on other systems, and copied them over manually. (See error message when you run setup.sh without doing this)

If you don't have a key, you can create it with:

`sudo dpkg -i /modules/parity/files/parity_1.6.5_amd64.deb`

`parity account new --datadir ~/paritykeys`

...then move the resulting key file beginning UTC- to `modules/parity/files/secrets/account0`, and save the password at `modules/parity/files/secrets/user.pwds`

The following are hard-coded:

 * modules/parity/manifests/init.pp: 
   The signing accounts of the validator accounts, and a single deployer account. These are used to generate the genesis file.

 * modules/parity/files/reserved-peers.txt:
   The enodes and IP addresses of the permitted peers. On a new install the network will not sync until these are updated.
   The enode of each node is output by the setup script, which gets it from syslog.
   You can update them after setting up the nodes by updating puppet then running ./setup.sh again (or just the puppet line from it).

The setup includes a non-validator node for running truffle deployments and other command-line scripts.
The truffle installation is not in puppet, although puppet handles some dependencies. 
Run truffle-setup.sh after running setup.sh.

We also do not automate copying over the truffle build directory to the static web server, which you can do with rsync.
