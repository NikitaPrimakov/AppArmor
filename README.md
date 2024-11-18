# Table of contents

1. [Nginx](https://github.com/NikitaPrimakov/AppArmor/tree/main/nginx)
2. [Keycloak](https://github.com/NikitaPrimakov/AppArmor/tree/main/keycloak)
3. [Php - fpm](https://github.com/NikitaPrimakov/AppArmor/tree/main/php)

# AppArmor profiles

AppArmor is an effective and easy-to-use Linux application security system. AppArmor proactively protects the operating system and applications from external or internal threats, even zero-day attacks, by enforcing good behavior and preventing both known and unknown application flaws from being exploited.

## Installation

Simply run aa-status to see if your Linux distribution already has AppArmor integrated:

```
$ aa-status
```

Since it is a kernel module it is usually not something users install themselves. Individual users and system administrators might however want to manage the application profiles which define what each application is allowed to do by editing the files in /`etc/apparmor.d/`.

The list of currently active profiles can be easily checked with `aa-status`.

## Checking AppArmor log messages

Each time AppArmor denies applications from doing potentially harmful operations the event is logged. Depending on your system the AppArmor events can be seen in the syslog, auditd, kernel log or in journald logs.

Example:

```
$ sudo journalctl -fx
audit[13172]: AVC apparmor="ALLOWED" operation="open"
profile="libreoffice-soffice"
name="/home/otto/.mozilla/firefox/ov37570l.default/cert8.db"
pid=13172 comm="soffice.bin" requested_mask="w"
denied_mask="w" fsuid=1001 ouid=1001
```