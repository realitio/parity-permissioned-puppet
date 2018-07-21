class parity {
  
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
      source  => "puppet:///modules/parity/parity_1.10.9_ubuntu_amd64.deb",
      require => User["parity"],
   }

   package { "parity":
      provider => dpkg,
      ensure => installed,
      source => "/home/parity/parity_1.6.5_amd64.deb",
      require => File["/home/parity/parity_1.6.5_amd64.deb"],
   }

   file { '/lib/systemd/system/parity.service':
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
     source  => "puppet:///modules/parity/systemd/parity.service",
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
