# vim: ft=apparmor

abi <abi/3.0>,

include <tunables/global>

profile php-fpm /usr/sbin/php-fpm* flags=(complain,attach_disconnected) {
  # поддержка общих библетек
  include <abstractions/base>
  # поддержка hostnames/usernames
  include <abstractions/nameservice>
  # общие файлы php и файлы поддержки, необходимые для php
  include <abstractions/php>
  # чтение конфигурации openssl
  include <abstractions/openssl>
  # чтение системных сертификатов
  include <abstractions/ssl_certs>

  # выполнение различных сетевых операций
  capability net_admin,
  # изменение GID и UID
  capability setuid,
  capability setgid,
  # произвольное изменение UID и GID файлов
  capability chown,
  # позволяет не выполнять проверки при отправке сигналов
  capability kill,
  # позволяет пропускать проверки доступа к файлу на чтение, запись и выполнение
  capability dac_override,

  # we need write access here to move it into a different apparmor sub profile
  @{PROC}/@{pid}/attr/{apparmor/,}current rw,

  # главный лог-файл
  /var/log/php*-fpm.log rw,

  # we need to be able to create all sockets
  @{run}/php{,-fpm}/php*-fpm.pid rw,
  @{run}/php*-fpm.pid rw,
  @{run}/php{,-fpm}/php*-fpm.sock rwlk,

  # для перезагрузки
  /usr/sbin/php-fpm* rix,

  # запрет на открытие / в рамках чтения/записи
  deny / rw,

  # разрешение на отправку сигнала
  signal (send) peer=php-fpm//*,

  # 
  change_profile -> php-fpm//*,

  # 
  # 
  include if exists <php-fpm.d>

  # 
  include if exists <local/php-fpm>
}