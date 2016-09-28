FROM debian

MAINTAINER orleika "orleika.net@gmail.com"

RUN apt update && \
apt install git make cmake wget libpcre3 libpcre3-dev zlib1g-dev libgd-dev libgd2-xpm-dev libgd-gd2-perl build-essential libpng12-dev libjpeg-dev && \
cd /usr/local/src && \
wget http://zlib.net/zlib-1.2.8.tar.gz && \
tar zxf zlib-1.2.8.tar.gz && \
wget https://www.openssl.org/source/openssl-1.1.0b.tar.gz && \
tar zxf openssl-1.1.0b.tar.gz && \
useradd -s /sbin/nologin nginx && \
mkdir /var/{log,run}/nginx && \
chown nginx:nginx /var/{log,run}/nginx/ && \
wget https://nginx.org/download/nginx-1.11.4.tar.gz && \
tar zxf nginx-1.11.4.tar.gz && \
cd nginx-1.11.4 && \
./configure \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--http-log-path=/var/log/nginx/access.log \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-proxy-temp-path=/var/lib/nginx/proxy \
--with-http_stub_status_module \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
--with-debug \
--with-http_gzip_static_module \
--with-http_v2_module \
--with-http_ssl_module \
--with-pcre-jit \
--user=nginx \
--group=nginx \
--with-openssl=/usr/local/src/openssl-1.1.0b \
--with-zlib=/usr/local/src/zlib-1.2.8 \
--with-http_ssl_module && \
make && \
make install

CMD nginx -g 'daemon off;'
