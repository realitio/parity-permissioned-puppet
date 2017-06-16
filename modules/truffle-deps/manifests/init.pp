class truffle-deps {

   package { "curl":
      ensure => installed,
   }
   package { "build-essential":
      ensure => installed,
   }
   package { "python":
      ensure => installed,
   }

}
