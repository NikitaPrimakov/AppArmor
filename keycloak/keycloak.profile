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
  capability new_bind_service

  # позволяет Keycloak выполнять задачи сетевого администрирования (например, устанавливать IP-адреса).
  capability net_admin

  # позволяет Keycloak изменять владельца файлов
  capability chown

  # позволяет Keycloak считывать содержимое каталога и выполнять поиск файлов
  capability dac_read_search

  # позволяет Keycloak выполнять файловые операции (например, чтение, запись, удаление) с файлами, которыми он владеет
  capability fowner

  # позволяет Keycloak устанавливать идентификатор группы для процесса
  capability setgid

  # позволяет Keycloak устанавливать идентификатор пользователя процесса
  capability setuid


  # Разрешить Keycloak считывать свои конфигурационные файлы
  /opt/keycloak/** r,
  /etc/keycloak/** r,

  # Разрешить Keycloak выполнять запись в свой каталог
  /var/lib/keycloak/** rw,

  # Разрешить Keycloak прослушивать свой порт по умолчанию
  network inet tcp listen 8080,

  # Разрешить Keycloak подключаться к своей базе данных
  network inet tcp connect 5432,

  # Разрешить Keycloak запускать свою JVM
  /usr/lib/jvm/java-11-openjdk-amd64/bin/java ix,

  # Запретить доступ ко всем другим файловым системам
  deny /** rw,


}