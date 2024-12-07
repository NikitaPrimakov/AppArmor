# vim: ft=apparmor


abi <abi/3.0>,


#include <tunables/global>

profile keycloak { 
  include <abstractions/base> # загружаем общие библиотеки и файлы их поддержки

  include <abstractions/openssl> # чтение openssl конфигурации

  include <abstractions/ssl_keys> # чтение ssl- сертификатов

  # выполение различных сетевых опкераций
  capability net_admin,

  # позволяет Keycloak привязываться к привилегированным портам (например, к порту 80)
  capability net_bind_service,

  # позволяет Keycloak изменять владельца файлов
  capability chown,

  # позволяет Keycloak считывать содержимое каталога и выполнять поиск файлов
  capability dac_read_search,

  # позволяет Keycloak переопределять права доступа к файлам
  capability dac_override,

  # позволяет Keycloak выполнять файловые операции (например, чтение, запись, удаление) с файлами, которыми он владеет
  capability fowner,

  # позволяет Keycloak отправлять сигналы другим процессам
  capability kill,

  # позволяет Keycloak устанавливать биты set-user-ID и set-group-ID для файлов и каталогов
  capability fsetid,

  # позволяет Keycloak устанавливать идентификатор группы для процесса
  capability setgid,

  # позволяет Keycloak устанавливать идентификатор пользователя процесса
  capability setuid,


  # Разрешить Keycloak считывать свои конфигурационные файлы
  /opt/keycloak/** r,
  /etc/keycloak/** r,

  # Разрешить Keycloak выполнять запись в свой каталог
  /var/lib/keycloak/** rw,

  # Разрешить Keycloak привязываться к своему собственному порту
  /var/run/keycloak.pid r,

  # Разрешить Keycloak запускать свои собственные двоичные файлы
  /opt/keycloak/bin/** ix,

  # Разрешить Keycloak читать системные библиотеки
  /usr/lib/** r,

  # Разрешить Keycloak прослушивать свой порт по умолчанию
  network inet tcp,

  # Разрешить Keycloak запускать свою JVM
  /usr/lib/jvm/java-11-openjdk-amd64/bin/java ix,

  # Запретить доступ ко всем другим файловым системам
  deny /{,**} rw,

}