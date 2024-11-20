#!/bin/sh

# Reload AppArmor after installation
apparmor_parser -r /etc/apparmor.d

# Enable the AppArmor profile
aa-enforce /etc/apparmor.d/keycloak

# Restart the service to apply the new AppArmor profile
