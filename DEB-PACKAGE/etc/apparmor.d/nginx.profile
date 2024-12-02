# vim: ft=apparmor


abi <abi/3.0>,


include <tunables/global>


profile nginx /usr/sbin/nginx flags=(enforce) { 
  # позволяет NGINX слушать разные порты
  include <abstractions/apache2-common>

  # загружаем общие библеотеки и файлы их поддержки
  include <abstractions/base>

  # файл абстракции AppArmor, который предоставляет набор правил для доступа к сетевой информационной службе 
  include <abstractions/nis>

  # чтение openssl конфигурации
  include <abstractions/openssl>
  
  # чтение ssl - сертификатов
  include <abstractions/ssl_keys>

  # resolve hostnames/usernames
  include <abstractions/nameservice>

  # обход проверки разрешений чтения, записи и выполнения файлов
  capability dac_override,

  # позволяет процессу обходить проверки разрешений на чтение файлов и проверки разрешений на чтение/выполнение каталогов
  capability dac_read_search,

  # связывание сокетов с портами ниже 1024  
  capability net_bind_service,

  # изменение GID
  capability setgid,
  

  # изменение UID
  capability setuid,

  /data/www/safe/* r,

  deny /data/www/unsafe/* r,

  /etc/group r,

  /etc/nginx/conf.d/ r,

  /etc/nginx/mime.types r,

  /etc/nginx/nginx.conf r,

  /etc/nsswitch.conf r,

  /etc/passwd r,

  /etc/ssl/openssl.cnf r,

  /run/nginx.pid rw,

  /usr/sbin/nginx mr,

  /var/log/nginx/access.log w,

  /var/log/nginx/error.log w,

}
