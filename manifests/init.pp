node zen-tokyo-1 {

   $VALIDATOR_NUM = 0
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include utils
   include parity
   include sshd

}

node zen-tokyo-2 {

   $NODE_ROLE = "PUBLIC_RPC"

   include puppet
   include utils
   include parity
   include sshd

}

node zen-ishikari-1 {

   $VALIDATOR_NUM = 1
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include utils
   include parity
   include sshd

}

node zen-ishikari-2 {

   $VALIDATOR_NUM = 2
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include utils
   include parity
   include sshd

}

node zen-tokyo-4 {

   $VALIDATOR_NUM = 0
   $NODE_ROLE = "DEPLOYER"

   include puppet
   include utils
   include parity
   include sshd

   include truffle-deps

}

node zen-tokyo-3 {

   include puppet
   include utils
   include sshd
   include webserver

}

node your-node-goes-here {

   $NODE_ROLE = "PRIVATE_NODE"
   $UNLOCK_ACCOUNT = "0xYourAddressGoesHere"

   include puppet
   include parity
   include truffle-deps

}
