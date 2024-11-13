# Table of contents

1. [Nginx](https://github.com/NikitaPrimakov/AppArmor?tab=readme-ov-file#nginx)
2. [Keycloak](https://github.com/NikitaPrimakov/AppArmor?tab=readme-ov-file#keycloak)
3. [Php - fpm](https://github.com/NikitaPrimakov/AppArmor?tab=readme-ov-file#php-fpm) 

# AppArmor profiles

## Nginx

```Nginx``` - it is an HTTP server, a reverse proxy server with support for caching and load balancing

### 1 Install nginx

You need to perform the standard steps - first update the local package index:

```
apt update
```

and start to install nginx

```
apt install nginx
```

### 2 Configuring Nginx to serve static files

```
sudo mkdir -p /data/www/safe
sudo mkdir -p /data/www/unsafe
```

Add the file to the safe directory:

```
sudo nano /data/www/safe/index.html
```

Place this code in it:

```
<html>
<b>Hello! Accessing this file is allowed.</b>
</html>
```

Then add a file called index.html to the /data/www/unsafe directory and place the following code in it:

```
<html>
<b>Hello! Accessing this file is NOT allowed.</b>
</html>
```

The Nginx configuration file is located in /etc/nginx/nginx.conf. Edit this file to configure 8080 sweat listening and /data/www directory support.

Comment out the line: `include /etc/nginx/sites-enabled/*;`

You need to add a whole server block:

```
server {
listen 8080;
location / {
root /data/www;
}
}
```

Restart Nginx to update the settings:

```
sudo nginx -s reload
```

### 3 Checking AppArmor Profiles

First of all, we should install AppArmor profiles:

```
sudo apt-get install apparmor-profiles
```

To view the list of available profiles, use the command:

```
sudo apparmor_status
```

Log files will be stored in the `/var/log/nginx directory.`

### 4 Creating an AppArmor profile for Nginx

Install apparmor-utils – a set of utilities for managing AppArmor.

```
sudo apt-get install apparmor-utils
```

The aa-autodep command will create an empty profile in the /etc/apparmor.d directory.

```
cd /etc/apparmor.d/
sudo aa-autodep nginx
```

The profile for Nginx was generated automatically, then it requires additional editing. Open the file /etc/apparmor.d/usr.sbin.nginx:

```
sudo nano /etc/apparmor.d/usr.sbin.nginx
```

The contents of the file can be placed in this configuration file [nginx.profile](https://github.com/NikitaPrimakov/AppArmor/blob/main/nginx/nginx.profile)


## Keycloak

To install Keycloak, you can use the following resource - ```[install keycloak](https://green.cloud/docs/how-to-install-configure-keycloak-on-ubuntu-20-04/)```

After that, you can configure the AppArmor profile, as it was done for NGINX

The AppArmor profile for keycloak is located ```[here](https://github.com/NikitaPrimakov/AppArmor/tree/main/keycloak)```.



## Php-fpm