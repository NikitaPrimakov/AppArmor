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
