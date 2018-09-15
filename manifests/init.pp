node rc-dev-3 {

   $network = 'mainnet'

   include puppet
   include utils
   include parity
   include webserver

}

node rc-dev-4 {

   $network = 'rinkeby'

   include puppet
   include utils
   #include parity
   # set up geth manually
   include webserver

}
