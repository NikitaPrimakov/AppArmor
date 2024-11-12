# vim: ft=apparmor


abi <abi/3.0>,


include <tunables/global>


profile nginx /usr/sbin/nginx flags=(enforce) { 
  # загружаем общие библеотеки и файлы их поддержки  
  include <abstractions/base>
  # resolve hostnames/usernames
  include <abstractions/nameservice>
  # позволяет NGINX слушать разные порты
  include <abstractions/apache2-common> 
  # чтение openssl конфигурации
  include <abstractions/openssl>
  # чтение ssl - сертификатов
  include <abstractions/ssl_keys> 
  #
  include <abstractions/nis> 


  # обход проверки разрешений чтения, записи и выполнения файлов
  capability dac_override,
  # выполнение различных сетевых операций
  capability net_admin,
  # изменение GID
  capability setgid,
  # изменение UID
  capability setuid,
  # связывание сокетов с портами ниже 1024
  capability net_bind_service 


  # системные файлы для аутентификации и другое
  /etc/gorup r,   
  /etc/passwd r,  
  /etc/nsswitch.conf r, 

  
  # 
  /usr/sbin/nginx mr,
  /run/nginx.pid rw, 


  # файлы конфинурации nginx
  /etc/nginx/conf.d/* r, 
  /etc/nginx/mime.types r, 
  /etc/nginx/nginx.conf r, 
  /etc/nginx/snippets/* r, 
  /etc/ssl/openssl.cnf r, 
  owner /etc/nginx/conf.d/ r, 
  owner /etc/nginx/snippets/ r, 


  # логи
  /var/log/nginx/* w,
  
  
  # webroot
  /srv/** r, 

}