node zen-tokyo-1 {

   $VALIDATOR_NUM = 0
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include parity
   include sshd

}

node zen-tokyo-2 {

   $NODE_ROLE = "PUBLIC_RPC"

   include puppet
   include parity
   include sshd

}

node zen-ishikari-1 {

   $VALIDATOR_NUM = 1
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include parity
   include sshd

}

node zen-ishikari-2 {

   $VALIDATOR_NUM = 2
   $NODE_ROLE = "VALIDATOR"

   include puppet
   include parity
   include sshd

}

node zen-tokyo-4 {

   $NODE_ROLE = "PRIVATE_RPC"

   include puppet
   include parity
   include sshd

}
