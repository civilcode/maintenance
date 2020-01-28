FROM nginx:stable-perl

ADD index.html /usr/share/nginx/html
ADD maintenance_files /usr/share/nginx/html/maintenance_files
ADD nginx.conf /etc/nginx/nginx.conf
