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
  # файл абстракции AppArmor, который предоставляет набор правил для доступа к сетевой информационной службе 
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
  capability net_bind_service,

  # Разрешить Nginx считывать и записывать данные в свои конфигурационные файлы
  /etc/nginx/** r,
  /etc/nginx/conf.d/** r,
  /etc/nginx/sites-enabled/** r,
  /etc/nginx/sites-available/** r,

  # Разрешить Nginx читать и записывать в свои лог-файлы
  /var/log/nginx/** rw,

  # Разрешить Nginx доступ к своему файлу идентификатора процесса
  /run/nginx.pid r,

  # Разрешить Nginx доступ к своему файлу сокета
  /var/run/nginx.sock rw,

  # Разрешить Nginx выполнять свои CGI-скрипты
  /usr/lib/nginx/modules/*.so mr,

  # Разрешить Nginx доступ к своему корневому каталогу документов
  /var/www/** r,

  # Разрешить Nginx прослушивать порты HTTP и HTTPS
  network inet tcp,
  network inet udp,

  # Запретить доступ ко всем другим файловым системам
  deny /{,**} rw,
}