class webserver {

   package { apache2: 
      ensure => installed,
   }

   file { "/var/www/html":
      ensure => directory,
      owner => ubuntu,
      group => ubuntu,
      require => Package["apache2"],
   }

}
