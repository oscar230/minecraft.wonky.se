FROM nginx:stable
COPY out /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf