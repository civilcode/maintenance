FROM nginx:stable-perl

ADD index.html /usr/share/nginx/html
ADD nginx.conf /etc/nginx/nginx.conf
