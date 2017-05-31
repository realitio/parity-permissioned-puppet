This sets up nodes in a parity private network, running in systemd.

The name of the network etc are hard-coded.

It assumes you have generated the validator keys on other systems, and copied them over manually. (See error message when you run setup.sh without doing this)

The following are hard-coded in modules/parity/manifests/init.pp:

 * The signing accounts of the validator accounts, and a single deployer account. These are used to generate the genesis file.

 * The URL or IP address of a single public RPC node, which will be used to bootstrap the others. Ideally this should be brought up first, even though it won't see any blocks.
   This will be periodically retried with a cron
