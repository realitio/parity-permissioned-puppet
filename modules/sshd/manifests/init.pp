class sshd {

   include stdlib

   service { 'sshd':
     ensure  => 'running',
     enable  => true,
   }

   file_line { 'ssh_no_password_auth':
     path => '/etc/ssh/sshd_config',
     line => 'PasswordAuthentication no',
     notify  => Service['sshd'],
   }

}
