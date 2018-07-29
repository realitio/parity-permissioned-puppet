node rc-dev-3 {

   $network = 'mainnet'

   include puppet
   include utils
   include parity
   include webserver

}
