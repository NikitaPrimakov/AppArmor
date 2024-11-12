# AppArmor profiles

## Nginx

```Nginx``` - it is an HTTP server, a reverse proxy server with support for caching and load balancing

### 1. Install nginx

You need to perform the standard steps - first update the local package index:

```
apt update
```

and start to install nginx

```
apt install nginx
```

### 2. Configuring Nginx to serve static files

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

