# vim: ft=apparmor


abi <abi/3.0>,


#include <tunables/global>

profile keycloak {
  # Allow Keycloak to read its configuration files
  /opt/keycloak/** r,
  /etc/keycloak/** r,

  # Allow Keycloak to write to its data directory
  /var/lib/keycloak/** rw,

  # Allow Keycloak to listen on its default port
  network inet tcp listen 8080,

  # Allow Keycloak to connect to its database
  network inet tcp connect 5432,

  # Allow Keycloak to execute its JVM
  /usr/lib/jvm/java-11-openjdk-amd64/bin/java ix,

  # Deny all other filesystem access
  deny /** rw,
}