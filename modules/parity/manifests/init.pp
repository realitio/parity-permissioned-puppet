class parity {
  
   $VALIDATORS = [
      "0x84ab299f1b95ad86fd90a5c7286becf297d03145",
      "0x893c4f6a029bfd91ca72f6bdfe076dfbfbc11031",
      "0xc09af5f02d6a6553116c336e60d938e28c9fa98a"
   ]
   $DEPLOYERS = [
      "0x3290c133b4c8eb6b7160313854538569dcfa9027",
   ]

   group { "parity": 
     ensure           => 'present',
     gid              => '1001',
   }

   user { 'parity':
     ensure           => 'present',
     gid              => '1001',
     home             => '/home/parity',
     shell            => '/bin/bash',
     uid              => '1001',
     managehome       => true,
     require          => Group["parity"],
   }

   file { "/home/parity/parity_1.6.5_amd64.deb":
      ensure  => present,
      source  => "puppet:///modules/parity/parity_1.6.5_amd64.deb",
      require => User["parity"],
   }

   package { "parity":
      provider => dpkg,
      ensure => installed,
      source => "/home/parity/parity_1.6.5_amd64.deb",
      require => File["/home/parity/parity_1.6.5_amd64.deb"],
   }

   file { "/home/parity/zenchain":
      ensure  => directory,
      owner   => "parity",
      group   => "parity",
      require => [ User["parity"], Group["parity"] ],
   }

   file { "/home/parity/zenchain/zenchain.json":
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain"],
      content => template("parity/zenchain.json"),
   }

   file { "/home/parity/zenchain/node.toml":
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain"],
      content => template("parity/node.toml"),
   }

   file { "/home/parity/zenchain/keys":
      ensure => directory,
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain"],
   }

   file { "/home/parity/zenchain/keys/ZenChain":
      ensure => directory,
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain/keys"],
   }

   file { "/home/parity/zenchain/keys/ZenChain/account0":
      source  => "puppet:///modules/parity/secrets/account0",
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain/keys/ZenChain"],
   }

   file { "/home/parity/zenchain/user.pwds":
      source  => "puppet:///modules/parity/secrets/user.pwds",
      owner   => "parity",
      group   => "parity",
      require => File["/home/parity/zenchain"],
   }

   # NB This needs to be set up manually when a new node is created
   file { "/home/parity/zenchain/reserved-peers.txt":
      source  => "puppet:///modules/parity/reserved-peers.txt",
      owner   => "parity",
      group   => "parity",
      # replace => "no", # Uncomment this if you prefer to manage the file without puppet
      require => File["/home/parity/zenchain"],
      notify  => Service["parity.service"],
   }

   file { '/lib/systemd/system/parity.service':
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
     source  => "puppet:///modules/parity/systemd/parity.service",
     require => [ File["/home/parity/zenchain/node.toml"], File["/home/parity/zenchain/user.pwds"] ],
     notify  => Exec["parity-systemd-reload"],
   }
   exec { 'parity-systemd-reload':
     command     => 'systemctl daemon-reload',
     path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
     refreshonly => true,
   }
   service { 'parity.service':
     ensure   => running,
     enable   => true,
     require => File["/lib/systemd/system/parity.service"],
   }


}
