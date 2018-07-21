class webserver {

   package { apache2: 
      ensure => absent,
   }

   package { nginx: 
      ensure => installed,
   }

   file { "/etc/nginx/sites-enabled/default":
      source  => "puppet:///modules/webserver/etc/nginx/sites-enabled/default", 
      ensure => present,
      owner => root,
      group => root,
      require => Package["nginx"],
   }

   file { "/var/www/html":
      ensure => directory,
      owner => root,
      group => root,
      require => Package["nginx"],
   }

   # For certbot
   file { "/var/www/html/.acme":
      ensure => directory,
      owner => root,
      group => root,
      require => File["/var/www/html"],
   }



}
