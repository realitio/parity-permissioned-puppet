class parity {
  
   $VALIDATORS = [
      "0x7f9efb6a1432db5e80730613ffc4195f2c5ade83",
      "0x32f1d8ae279dee2a86794cccd38e5c63bf1b3b38",
      "0xf4403274de2dc2a967ac291d63984b04adf19899"
   ]
   $DEPLOYERS = [
      "0x8426f51494194f63a506acc57e87b9e7e4a63dc6",
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

   file { '/lib/systemd/system/parity.service':
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
     source  => "puppet:///modules/parity/systemd/parity.service",
     require => File["/home/parity/zenchain/node.toml"],
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
